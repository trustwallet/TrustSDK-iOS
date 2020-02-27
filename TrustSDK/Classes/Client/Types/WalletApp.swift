//  Copyright © 2018 Trust.
//
//	This file is part of TrustSDK. The full TrustSDK copyright notice, including
//	terms governing use, modification, and redistribution, is contained in the
//	file LICENSE at the root of the source code distribution tree.

import Foundation

/// Describes a wallet app supporting the trust deeplink spec
public struct WalletApp {
    enum ParamKeys: String {
        case app, callback, id
    }
    /// TrustWallet scheme
    public let scheme: String
    /// TrustWallet install URL
    let installURL: URL
    
    public init(scheme: String, installURL: URL) {
        self.scheme = scheme
        self.installURL = installURL
    }
}

extension WalletApp {
    func open(command: String, params: [String: String], app: String, callback: String, id: String) {
        guard
            let url = URL(string: "\(scheme)://\(command)"),
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true),
            let commandUrl = components.url, UIApplication.shared.canOpenURL(commandUrl) else {
            UIApplication.shared.open(installURL)
            return
        }

        // Add callback data
        var _params = params
        _params[ParamKeys.app.rawValue] = app
        _params[ParamKeys.callback.rawValue] = callback
        _params[ParamKeys.id.rawValue] = id

        components.queryItems = _params.map { URLQueryItem(name: $0, value: $1) }
        
        if let url = components.url {
            UIApplication.shared.open(url)
        }
    }
}
