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
    func open(command: CommandName, data: [String: String], app: String, callback: String, id: String) {
        guard
            let url = URL(string: "\(scheme)://\(command.rawValue)"),
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true),
            let commandUrl = components.url, UIApplication.shared.canOpenURL(commandUrl) else {
            UIApplication.shared.open(installURL)
            return
        }

        // Add callback data
        var params = data
        params[ParamKeys.app.rawValue] = app
        params[ParamKeys.callback.rawValue] = callback
        params[ParamKeys.id.rawValue] = id

        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        
        if let url = components.url {
            UIApplication.shared.open(url)
        }
    }
}
