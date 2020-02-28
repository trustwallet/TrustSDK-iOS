//  Copyright © 2018 Trust.
//
//	This file is part of TrustSDK. The full TrustSDK copyright notice, including
//	terms governing use, modification, and redistribution, is contained in the
//	file LICENSE at the root of the source code distribution tree.
	

import Foundation
import TrustWalletCore

public extension TrustSDK {
    enum Command {
        case sign(coin: CoinType, input: Data)
        case getAccounts(coins: [CoinType])
        
        var name: String {
            switch self {
            case .getAccounts:
                return "get_accounts"
            case .sign:
                return "sign"
            }
        }
        
        var params: [String: String] {
            switch self {
            case .getAccounts(let coins):
                return [
                    "coins": String(coins: coins)
                ]
            case .sign(let coin, let input):
                return [
                    "coin": coin.rawValue.description,
                    "data": input.base64UrlEncodedString()
                ]
            }
        }
        
        init?(name: String, params: [String: String]) {
            switch name {
            case "get_accounts":
                guard let coinsParam = params["coins"] else {
                    return nil
                }
                
                self = .getAccounts(coins: coinsParam.toCoinArray())
            case "sign":
                guard
                    let coinParam = params["coin"],
                    let dataParam = params["data"],
                    let coin = coinParam.toCoin(),
                    let data = dataParam.toBase64Data()
                else {
                    return nil
                }
                
                self = .sign(coin: coin, input: data)
            default: return nil
            }
        }
        
        init?(components: URLComponents) {
            guard let name = components.host else { return nil }
            self.init(name: name, params: components.queryItemsDictionary())
        }
    }
}
