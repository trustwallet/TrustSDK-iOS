// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation
import WalletCore

/// https://developer.trustwallet.com/add_new_asset/universal_asset_id
public struct UniversalAssetID: CustomStringConvertible, Equatable {

    let cPrefix = "c"
    let tPrefix = "t"

    public let coin: CoinType
    public let token: String?

    public var description: String {
        let prefix = "\(cPrefix)\(coin.rawValue)"
        guard let token = token else {
            return prefix
        }
        return "\(prefix)_\(tPrefix)\(token)"
    }

    public init(coin: CoinType, token: String? = nil) {
        self.coin = coin
        self.token = token
    }

    public init?(string: String) {
        guard !string.isEmpty else { return nil }
        let parts = string.split(separator: "_").map { String($0) }
        guard parts[0].hasPrefix(cPrefix) else {
            return nil
        }
        guard let int = UInt32(String(parts[0].dropFirst(cPrefix.count))),
            let coin = CoinType(rawValue: int) else {
            return nil
        }
        self.coin = coin
        if parts.count == 2 {
            guard parts[1].hasPrefix(tPrefix) else {
                return nil
            }
            self.token = String(parts[1].dropFirst(tPrefix.count))
        } else {
            self.token = nil
        }
    }
}
