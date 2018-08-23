// Copyright © 2018 Trust.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation
import TrustCore
import BigInt

@objc(TrustSDK)
public extension TrustSDK {
    @objc
    public func signMessage(_ message: Data, address: String? = nil, success: @escaping (Data) -> Void, failure: @escaping (NSError) -> Void) {
        signMessage(message) { result in
            switch result {
            case .success(let signedMesssage):
                success(signedMesssage)
            case .failure(let error):
                failure(error as NSError)
            }
        }
    }

    @objc
    public func signTransaction(_ gasPrice: String, _ gasLimit: UInt64, _ address: String, amount: String, success: @escaping (Data) -> Void, failure: @escaping (NSError) -> Void) {
        let transaction = EthereumTransaction(
            nonce: 0,
            gasPrice: BigInt(gasPrice)!,
            gasLimit: BigInt(gasLimit),
            to: EthereumAddress(string: address)!,
            amount: BigInt(amount)!,
            payload: .none
        )

        signTransaction(transaction) { result in
            switch result {
            case .success(let signedMesssage):
                success(signedMesssage)
            case .failure(let error):
                failure(error as NSError)
            }
        }
    }

    @objc
    public func signPersonalMessage(_ message: Data, address: String? = nil, success: @escaping (Data) -> Void, failure: @escaping (NSError) -> Void) {
        signPersonalMessage(message, address: address.flatMap({ EthereumAddress(string: $0) })) { result in
            switch result {
            case .success(let signedMesssage):
                success(signedMesssage)
            case .failure(let error):
                failure(error as NSError)
            }
        }
    }
}
