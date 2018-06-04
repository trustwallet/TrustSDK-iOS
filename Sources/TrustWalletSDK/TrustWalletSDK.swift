// Copyright © 2018 Trust.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import BigInt
import Result
import TrustCore
import UIKit

public final class TrustWalletSDK {
    /// Delegate providing wallet functionality
    weak var delegate: WalletDelegate?

    public init(delegate: WalletDelegate) {
        self.delegate = delegate
    }

    /// Handles deep-link wallet commands
    ///
    /// - Parameter url: URL passed to the app
    /// - Returns: `true` if the URL was handled; `false` otherwise
    public func handleOpen(url: URL) -> Bool {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return false
        }

        switch url.host {
        case "sign-message"?, "sign-personal-message"?:
            return handleSignMessage(components)
        case "sign-transaction"?:
            return handleSignTransaction(components)
        default:
            return false
        }
    }

    private func handleSignMessage(_ components: URLComponents) -> Bool {
        guard let delegate = delegate else {
            // Missing delegate, ignore
            return false
        }

        guard let message = components.queryParameterValue(for: "message").flatMap({ Data(base64Encoded: $0) }) else {
            return false
        }
        let address = components.queryParameterValue(for: "address").flatMap({ Address(eip55: $0) })
        let callback = components.queryParameterValue(for: "callback").flatMap({ URL(string: $0) })
        delegate.signMessage(message, address: address) { result in
            if let callback = callback {
                self.handleSignMessageResult(result, callback: callback)
            }
        }

        return true
    }

    private func handleSignMessageResult(_ result: Result<Data, WalletError>, callback: URL) {
        switch result {
        case .success(let signedMessage):
            if var callbackComponents = URLComponents(url: callback, resolvingAgainstBaseURL: false) {
                callbackComponents.append(queryItem: URLQueryItem(name: "result", value: signedMessage.base64EncodedString()))
                UIApplication.shared.open(callbackComponents.url!, options: [:], completionHandler: nil)
            }
        case .failure(let error):
            callbackWithFailure(url: callback, error: error)
        }
    }

    private func handleSignTransaction(_ components: URLComponents) -> Bool {
        guard let delegate = delegate else {
            // Missing delegate, ignore
            return false
        }

        guard let gasPrice = components.queryParameterValue(for: "gasPrice").flatMap({ BigInt($0) }) else {
            return false
        }
        guard let gasLimit = components.queryParameterValue(for: "gasLimit").flatMap({ UInt64($0) }) else {
            return false
        }
        guard let to = components.queryParameterValue(for: "to").flatMap({ Address(eip55: $0) }) else {
            return false
        }
        guard let amount = components.queryParameterValue(for: "amount").flatMap({ BigInt($0) }) else {
            return false
        }
        let callback = components.queryParameterValue(for: "callback").flatMap({ URL(string: $0) })

        var transaction = Transaction(gasPrice: gasPrice, gasLimit: gasLimit, to: to)
        transaction.amount = amount

        if let dataHex = components.queryParameterValue(for: "data").flatMap({ String($0) }) {
           transaction.payload = Data(hexString: dataHex)
        }

        transaction.nonce = components.queryParameterValue(for: "nonce").flatMap({ UInt64($0) }) ?? 0

        delegate.signTransaction(transaction) { result in
            if let callback = callback {
                self.handleSignTransactionResult(result, callback: callback)
            }
        }

        return true
    }

    private func handleSignTransactionResult(_ result: Result<Data, WalletError>, callback: URL) {
        switch result {
        case .success(let signedTransaction):
            if var callbackComponents = URLComponents(url: callback, resolvingAgainstBaseURL: false) {
                callbackComponents.append(queryItem: URLQueryItem(name: "result", value: signedTransaction.base64EncodedString()))
                UIApplication.shared.open(callbackComponents.url!, options: [:], completionHandler: nil)
            }
        case .failure(let error):
            callbackWithFailure(url: callback, error: error)
        }
    }

    private func callbackWithFailure(url: URL, error: WalletError) {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.append(queryItem: URLQueryItem(name: "error", value: error.rawValue))
        UIApplication.shared.open(components.url!, options: [:], completionHandler: nil)
    }
}
