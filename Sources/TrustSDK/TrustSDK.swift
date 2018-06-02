// Copyright © 2018 Trust.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import TrustCore
import UIKit
@objc(TrustSDK)
public final class TrustSDK: NSObject {
    /// The callback URL scheme.
    public let callbackScheme: String

    /// Wallet application to use
    public var walletApp: WalletApp?

    private var pendingCommand: Command?

    @objc public init(callbackScheme: String) {
        self.callbackScheme = callbackScheme
        walletApp = WalletAppManager.availableApps.first
    }

    /// Handles an open URL callback
    ///
    /// - Returns: `true` is the URL was handled; `false` otherwise.
    @objc public func handleCallback(url: URL) -> Bool {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false), components.scheme == callbackScheme else {
            return false
        }

        return pendingCommand?.handleCallback(url: url) ?? false
    }

    func execute(command: Command) {
        guard let app = walletApp else {
            return
        }

        pendingCommand = command
        let url = command.requestURL(scheme: app.scheme)
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }

    func fallbackToInstall() {
        guard let app = walletApp else {
            return
        }

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(app.installURL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(app.installURL)
        }
    }
}
