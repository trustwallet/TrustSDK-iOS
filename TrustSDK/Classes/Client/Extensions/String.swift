//  Copyright © 2018 Trust.
//
//	This file is part of TrustSDK. The full TrustSDK copyright notice, including
//	terms governing use, modification, and redistribution, is contained in the
//	file LICENSE at the root of the source code distribution tree.
	

import Foundation
import TrustWalletCore

extension String {
    init(coins: [CoinType]) {
        self = coins.map{ "\($0.rawValue)" }.joined(separator: ":")
    }
    
    func toCoinArray(separator: String = ":") -> [CoinType] {
        return self.components(separatedBy: separator)
            .map { $0.toCoin() }
            .compactMap{ $0 }
    }
    
    func toCoin() -> CoinType? {
        if let rawValue = UInt32(self), let coin = CoinType(rawValue: rawValue) {
            return coin
        }
        return nil
    }
    
    func toBase64Data() -> Data? {
        return Data(base64UrlEncoded: self)
    }
}
