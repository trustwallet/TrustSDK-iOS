// Copyright © 2018 Trust.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import TrustSDK
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    /// Instantiate the TrustSDK with the scheme registered for this app
    let trustSDK = TrustSDK(callbackScheme: "trustexample")

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if let viewController = window?.rootViewController as? ViewController {
            viewController.trustSDK = trustSDK
        }

        // Override point for customization after application launch.

        /// Handle wallet results
        if let url = launchOptions?[.url] as? URL {
            return trustSDK.handleCallback(url: url)
        }

        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey: Any] = [:]) -> Bool {
        /// Handle wallet results
        return trustSDK.handleCallback(url: url)
    }
}

