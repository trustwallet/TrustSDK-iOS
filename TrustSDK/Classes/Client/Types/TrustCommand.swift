// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation
import WalletCore

public enum CommandName: String {
    case getAccounts = "sdk_get_accounts"
    case sign = "sdk_sign"
    case signMessage = "sdk_sign_message"
    case signSimple = "sdk_transaction"
}

enum SignMetadataName: String {
    case dApp = "dapp"
}

public extension TrustSDK {
    enum SignMetadata: CustomStringConvertible {
        case dApp(name: String, url: URL?)

        init?(params: [String: Any]) {
            guard
                let nameParam = params["__name"] as? String,
                let name = SignMetadataName(rawValue: nameParam)
            else { return nil }

            switch name {
            case .dApp:
                let name = params["name"] as? String
                let url = params["url"] as? String
                self = .dApp(name: name ?? "", url: URL(string: url ?? ""))
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

        var params: [String: Any] {
            var params = { () -> [String: Any] in
                switch self {
                case .dApp(let name, let url):
                    return [
                        "name": name,
                        "url": url?.absoluteString ?? "",
                    ]
                }
            }()

            params["__name"] = self.name
            return params
        }

        public var description: String {
            return "\(params)"
        }
    }

    enum Command {
        case sign(coin: CoinType, input: Data, send: Bool, metadata: SignMetadata?)
        case signMessage(coin: CoinType, message: Data, metadata: SignMetadata?)
        case getAccounts(coins: [CoinType])
        case signSimple(tx: Transaction)

        public var name: CommandName {
            switch self {
            case .getAccounts: return .getAccounts
            case .sign: return .sign
            case .signMessage: return .signMessage
            case .signSimple: return.signSimple
            }
        }

        public var params: [String: Any] {
            switch self {
            case .getAccounts(let coins):
                return [
                    "coins": coins.map { $0.rawValue },
                ]
            case .sign(let coin, let input, let send, let meta):
                return [
                    "coin": "\(coin.rawValue)",
                    "data": input.base64UrlEncodedString(),
                    "send": send,
                    "meta": meta?.params ?? [:],
                ]
            case .signMessage(let coin, let data, let meta):
                return [
                    "coin": "\(coin.rawValue)",
                    "data": data.hex,
                    "meta": meta?.params ?? [:],
                ]
            case .signSimple(let tx):
                return tx.params()
            }
        }

        public init?(name: String, params: [String: Any]) {
            switch CommandName(rawValue: name) {
            case .getAccounts:
                guard let coinsParam = params["coins"] as? [String: String] else {
                    return nil
                }

                self = .getAccounts(
                    coins: coinsParam
                        .mapKeys { UInt32($0) }
                        .sorted { $0.key < $1.key }
                        .compactMap { $0.value.toCoin() }
                )
            case .sign:
                guard
                    let coinParam = params["coin"] as? String,
                    let dataParam = params["data"] as? String,
                    let coin = coinParam.toCoin(),
                    let data = dataParam.toBase64Data()
                else {
                    return nil
                }
                let metaParam = params["meta"] as? [String: Any]
                let sendParam = params["send"] as? String
                self = .sign(
                    coin: coin,
                    input: data,
                    send: sendParam?.toBool() ?? false,
                    metadata: SignMetadata(params: metaParam ?? [:])
                )
            case .signMessage:
                guard let coin = (params["coin"] as? String)?.toCoin(),
                    let dataParam = params["data"] as? String,
                    let data = Data(hexEncoded: dataParam) else {
                    return nil
                }
                let meta = params["meta"] as? [String: Any] ?? [:]
                self = .signMessage(coin: coin, message: data, metadata: SignMetadata(params: meta))
            case .signSimple:
                guard let tx = Transaction(params: params) else {
                    return nil
                }
                self = .signSimple(tx: tx)
            default:
                return nil
            }
        }

        public init?(components: URLComponents) {
            guard let name = components.host else { return nil }
            self.init(name: name, params: Dictionary(queryItems: components.queryItems ?? []))
        }
    }
}

extension TrustSDK.SignMetadata: Equatable {}
extension TrustSDK.Command: Equatable {}
