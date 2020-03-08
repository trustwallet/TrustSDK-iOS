// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation

/// Describes a wallet app supporting the trust deeplink spec
public struct WalletApp {
    /// Wallet scheme
    public let scheme: String
    /// Wallet install URL
    let installURL: URL

    public init(scheme: String, installURL: URL) {
        self.scheme = scheme
        self.installURL = installURL
    }
}

extension WalletApp {
    enum ParamKeys: String {
        case app, callback, id
    }

    func open(command: String, params: [URLQueryItem], app: String, callback: String, id: String) {
        guard
            let url = URL(string: "\(scheme)://\(command)"),
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true),
            let commandUrl = components.url, UIApplication.shared.canOpenURL(commandUrl) else {
            UIApplication.shared.open(installURL)
            return
        }

        components.queryItems = params
        components.queryItems?.append(contentsOf: [
            URLQueryItem(name: ParamKeys.app.rawValue, value: app),
            URLQueryItem(name: ParamKeys.callback.rawValue, value: callback),
            URLQueryItem(name: ParamKeys.id.rawValue, value: id),
        ])

        if let url = components.url {
            UIApplication.shared.open(url)
        }
    }
}
