// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation
import WalletCore

extension String {
    init(coins: [CoinType], separator: String = ",") {
        self = coins.map { "\($0.rawValue)" }.joined(separator: separator)
    }

    func toCoinArray(separator: String = ",") -> [CoinType] {
        return self.components(separatedBy: separator)
            .map { $0.toCoin() }
            .compactMap { $0 }
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

    func toBool() -> Bool {
        return Bool(self) ?? false
    }
}

extension String {
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, bundle: TrustSDK.resourceBundle, comment: comment)
    }
}
