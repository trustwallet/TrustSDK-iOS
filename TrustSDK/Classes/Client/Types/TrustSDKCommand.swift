//  Copyright © 2018 Trust.
//
//	This file is part of TrustSDK. The full TrustSDK copyright notice, including
//	terms governing use, modification, and redistribution, is contained in the
//	file LICENSE at the root of the source code distribution tree.
	

import Foundation
import TrustWalletCore

public enum TrustSDKCommand {
    case sign(coin: CoinType, input: SigningInput)
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
                "coins": coins.map{ "\($0.rawValue)" }.joined(separator: ":")
            ]
        case .sign(let coin, let input):
            let data = try? input.serializedData()
            return [
                "coin": coin.rawValue.description,
                "data": data?.base64UrlEncodedString() ?? ""
            ]
        }
    }
}
