// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation
import TrustWalletCore

enum CommandName: String {
    case getAccounts = "sdk_get_accounts"
    case sign = "sdk_sign"
    case signThenSend = "sdk_sign_then_send"
}

enum SignMetadataName: String {
    case dApp = "dapp"
}

public extension TrustSDK {
    enum SignMetadata {
        case dApp(name: String, url: URL?)

        init?(value: String) {
            let params = value
                .components(separatedBy: "|")
                .map { $0.components(separatedBy: ":") }
                .compactMap { values -> (key: String, value: String)? in
                    switch values.count {
                    case 1: return (key: values[0], value: "")
                    case 2: return (key: values[0], value: values[1])
                    default: return nil
                    }
                }
                .toDictionary { [$0.key: $0.value] }

            guard
                let metaname = params["metaname"],
                let name = SignMetadataName(rawValue: metaname)
            else { return nil }

            switch name {
            case .dApp:
                self = .dApp(name: params["name"] ?? "", url: URL(string: params["url"] ?? ""))
            }
        }

        var name: String {
            let name = { () -> SignMetadataName in
                switch self {
                case .dApp:
                    return .dApp
                }
            }()

            return name.rawValue
        }

        var value: String {
            var params = { () -> [String: String] in
                switch self {
                case .dApp(let name, let url):
                    return [
                        "name": name,
                        "url": url?.absoluteString ?? "",
                    ]
                }
            }()

            params["metaname"] = self.name
            return params.reduce("") { (acc, param) -> String in
                return "\(acc)|\(param.key):\(param.value)"
            }
        }
    }

    enum Command {
        case sign(coin: CoinType, input: Data, metadata: SignMetadata?)
        case signThenSend(coin: CoinType, input: Data, metadata: SignMetadata?)
        case getAccounts(coins: [CoinType])

        public var name: String {
            let name = { () -> CommandName in
                switch self {
                case .getAccounts:
                    return .getAccounts
                case .sign:
                    return .sign
                case .signThenSend:
                    return .signThenSend
                }
            }()

            return name.rawValue
        }

        public var params: [String: String] {
            switch self {
            case .getAccounts(let coins):
                return [
                    "coins": String(coins: coins),
                ]
            case .sign(let coin, let input, let meta),
                 .signThenSend(let coin, let input, let meta):
                return [
                    "coin": coin.rawValue.description,
                    "data": input.base64UrlEncodedString(),
                    "meta": meta?.value ?? "",
                ]
            }
        }

        public init?(name: String, params: [String: String]) {
            switch CommandName(rawValue: name) {
            case .getAccounts:
                guard let coinsParam = params["coins"] else {
                    return nil
                }

                self = .getAccounts(coins: coinsParam.toCoinArray())
            case .sign:
                guard
                    let coinParam = params["coin"],
                    let dataParam = params["data"],
                    let coin = coinParam.toCoin(),
                    let data = dataParam.toBase64Data()
                else {
                    return nil
                }
                let meta = SignMetadata(value: params["meta"] ?? "")
                self = .sign(coin: coin, input: data, metadata: meta)
            case .signThenSend:
                guard
                    let coinParam = params["coin"],
                    let dataParam = params["data"],
                    let coin = coinParam.toCoin(),
                    let data = dataParam.toBase64Data()
                else {
                    return nil
                }
                let meta = SignMetadata(value: params["meta"] ?? "")
                self = .signThenSend(coin: coin, input: data, metadata: meta)
            default:
                return nil
            }
        }

        public init?(components: URLComponents) {
            guard let name = components.host else { return nil }
            self.init(name: name, params: components.queryItemsDictionary())
        }
    }
}

extension TrustSDK.SignMetadata: Equatable {}
extension TrustSDK.Command: Equatable {}
