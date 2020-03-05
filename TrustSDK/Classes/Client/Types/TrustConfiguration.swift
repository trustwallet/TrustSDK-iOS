// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation

public extension TrustSDK {
    struct Configuration {
        public static let trustWalletApp = WalletApp(
            scheme: "trust",
            installURL: URL(string: "https://apps.apple.com/app/trust-crypto-bitcoin-wallet/id1288339409")!
        )

        let scheme: String
        let callback: String
        let walletApp: WalletApp

        public init(
            scheme: String,
            callback: String = "sdk_sign_result",
            walletApp: WalletApp = Self.trustWalletApp
        ) {
            self.scheme = scheme
            self.callback = callback
            self.walletApp = walletApp
        }
    }
}
