// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation
import WalletCore

public extension WalletSDK {
    enum Response {
        case sign(output: Data)
        case signThenSend(txHash: String)
        case signMessage(signature: Data)
        case accounts([String])
        case failure(error: TrustSDKError)
        case signSimple(data: Data)
        case sentSimple(hash: String)

        var params: [String: String] {
            switch self {
            case .sign(let output):
                return [
                    "data": output.base64UrlEncodedString(),
                ]
            case .accounts(let accounts):
                return [
                    "accounts": accounts.joined(separator: ","),
                ]
            case .signThenSend(let txHash):
                return [
                    "tx_hash": txHash,
                ]
            case .signMessage(let signature):
                return [
                    "signature": signature.hex,
                ]
            case .failure(let error):
                return error.params
            case .signSimple(let data):
                return [
                    "data": "0x" + data.hex,
                ]
            case .sentSimple(let data):
                return [
                    "data": data,
                ]
            }
        }
    }
}
