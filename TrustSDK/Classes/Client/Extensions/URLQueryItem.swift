// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation
import WalletCore

extension URLQueryItem {
    var intValue: Int? {
        if let value = self.value {
            return Int(value)
        }

        return nil
    }

    var coinValue: CoinType? {
        if let value = self.value, let intValue = UInt32(value) {
            return CoinType(rawValue: intValue)
        }

        return nil
    }

    var dataValue: Data? {
        if let value = self.value {
            return Data(base64UrlEncoded: value)
        }

        return nil
    }
}
