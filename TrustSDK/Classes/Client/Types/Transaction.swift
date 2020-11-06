// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation
import WalletCore

public extension TrustSDK {
    struct Transaction: Equatable {
        public let to: String
        public let coin: CoinType
        public let amount: String
        public let send: Bool
        public let tokenId: String?
        public let from: String?
        public let nonce: String?
        public let gasLimit: String?
        public let gasPrice: String?

        public init(
            to: String,
            coin: CoinType,
            amount: String,
            send: Bool,
            tokenId: String?,
            from: String?,
            nonce: String?,
            gasLimit: String?,
            gasPrice: String?
        ) {
            self.to = to
            self.coin = coin
            self.amount = amount
            self.send = send
            self.tokenId = tokenId
            self.from = from
            self.nonce = nonce
            self.gasLimit = gasLimit
            self.gasPrice = gasPrice
        }

        public func params(meta: SignMetadata? = nil) -> [String: Any] {
            return [:]
        }
    }
}
