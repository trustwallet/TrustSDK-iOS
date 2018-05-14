// Copyright © 2018 Trust.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import BigInt
import TrustCore

final class SignTransactionCommand: Command {
    let name = "sign-transaction"

    /// Transaction to sign
    var transaction: Transaction

    /// Completion closure
    var completion: (Transaction) -> Void

    /// Callback scheme
    var callbackScheme: String

    var callback: URL {
        var components = URLComponents()
        components.scheme = callbackScheme
        components.host = name
        return components.url!
    }

    init(transaction: Transaction, callbackScheme: String, completion: @escaping (Transaction) -> Void) {
        self.transaction = transaction
        self.completion = completion
        self.callbackScheme = callbackScheme
    }

    func requestURL(scheme: String) -> URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = name
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "gasPrice", value: transaction.gasPrice.description))
        queryItems.append(URLQueryItem(name: "gasLimit", value: transaction.gasLimit.description))
        queryItems.append(URLQueryItem(name: "to", value: transaction.to.description))
        queryItems.append(URLQueryItem(name: "amount", value: transaction.amount.description))
        if let payload = transaction.payload {
            queryItems.append(URLQueryItem(name: "payload", value: payload.base64EncodedString()))
        }
        queryItems.append(URLQueryItem(name: "callback", value: callback.absoluteString))
        components.queryItems = queryItems
        return components.url!
    }

    func handleCallback(url: URL) -> Bool {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false), components.host == name else {
            return false
        }
        guard let vs = components.queryItems?.first(where: { $0.name == "v" })?.value, let v = BigInt(vs) else {
            return false
        }
        guard let rs = components.queryItems?.first(where: { $0.name == "r" })?.value, let r = BigInt(rs) else {
            return false
        }
        guard let ss = components.queryItems?.first(where: { $0.name == "s" })?.value, let s = BigInt(ss) else {
            return false
        }

        transaction.v = v
        transaction.r = r
        transaction.s = s
        if let nonce = components.queryItems?.first(where: { $0.name == "v" })?.value, let val = UInt64(nonce) {
            transaction.nonce = val
        }

        completion(transaction)
        return true
    }
}

public extension TrustSDK {
    func signTransaction(_ transaction: Transaction, completion: @escaping (Transaction) -> Void) {
        guard WalletAppManager.hasWalletApp else {
            return fallbackToInstall()
        }
        let command = SignTransactionCommand(transaction: transaction, callbackScheme: callbackScheme, completion: completion)
        execute(command: command)
    }
}
