// Copyright © 2018 Trust.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import UIKit

public class WalletAppManager {
    /// List of supported wallet apps
    static let apps = [
        WalletApp(
            name: "Trust",
            scheme: "trust",
            installURL: URL(string: "https://itunes.apple.com/ru/app/trust-ethereum-wallet/id1288339409")!
        )
    ]

    private init() {}

    /// List of available wallet apps
    public static var availableApps: [WalletApp] {
        return apps.filter {
            UIApplication.shared.canOpenURL(URL(string: "\($0.scheme)://")!)
        }
    }

    /// Whether there is a wallet app installed
    public static var hasWalletApp: Bool {
        return !availableApps.isEmpty
    }
}
