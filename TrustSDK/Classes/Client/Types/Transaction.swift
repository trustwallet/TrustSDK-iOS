// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation

public extension TrustSDK {
    struct Transaction: Equatable {
        public enum Action: String, Equatable {
            case transfer
        }

        public let to: String
        public let asset: UniversalAssetID
        public let amount: String
        public let action: Action
        public let confirm: ConfirmType
        public let from: String?
        public let nonce: UInt64?
        public let feeLimit: String?
        public let feePrice: String?
        public let meta: String?

        public init(
            asset: UniversalAssetID,
            to: String,
            amount: String,
            action: Action,
            confirm: ConfirmType,
            from: String? = nil,
            nonce: UInt64? = nil,
            feePrice: String? = nil,
            feeLimit: String? = nil,
            meta: String? = nil
        ) {
            self.asset = asset
            self.to = to
            self.amount = amount
            self.action = action
            self.confirm = confirm
            self.from = from
            self.nonce = nonce
            self.feePrice = feePrice
            self.feeLimit = feeLimit
            self.meta = meta
        }

        public init?(params: [String: Any]) {
            guard
                let asset = UniversalAssetID(string: (params["asset"] as? String) ?? ""),
                let action = Action(rawValue: (params["action"] as? String) ?? ""),
                let confirm = ConfirmType(rawValue: (params["confirm_type"] as? String) ?? ""),
                let to = params["to"] as? String, !to.isEmpty,
                let amount = params["amount"] as? String, !amount.isEmpty
            else {
                return nil
            }
            self.asset = asset
            self.to = to
            self.amount = amount
            self.action = action
            self.confirm = confirm
            self.from = params["from"] as? String
            self.feeLimit = params["fee_limit"] as? String
            self.feePrice = params["fee_price"] as? String
            self.meta = params["meta"] as? String
            if let nonceStr = params["nonce"] as? String {
                self.nonce = UInt64(nonceStr)
            } else {
                self.nonce = nil
            }
        }

        public func params() -> [String: Any] {
            var params: [String: Any] = [
                "asset": asset.description,
                "to": to,
                "amount": amount,
                "action": action.rawValue,
                "confirm_type": confirm.rawValue,
            ]
            if let from = from {
                params["from"] = from
            }
            if let nonce = nonce {
                params["nonce"] = nonce
            }
            if let feePrice = feePrice {
                params["fee_price"] = feePrice
            }
            if let feeLimit = feeLimit {
                params["fee_limit"] = feeLimit
            }
            if let meta = meta {
                params["meta"] = meta
            }
            return params
        }
    }
}
