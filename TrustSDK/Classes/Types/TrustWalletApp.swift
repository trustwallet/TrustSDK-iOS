//  Copyright © 2018 Trust.
//
//	This file is part of TrustSDK. The full TrustSDK copyright notice, including
//	terms governing use, modification, and redistribution, is contained in the
//	file LICENSE at the root of the source code distribution tree.

import Foundation

/// Describes a wallet app supporting the trust deeplink spec
struct TrustWalletApp {
    enum ParamKeys: String {
        case app, callback, id
    }
    /// TrustWallet scheme
    static let trustScheme = "trust"
    /// TrustWallet install URL
    static let installURL = URL(string: "https://apps.apple.com/app/trust-crypto-bitcoin-wallet/id1288339409")!
    
    static func send(command: Command) throws {
        guard let config = TrustSDK.configuration else {
            throw TrustSDKError.notInitialized
        }
        
        let id = TrustSDK.commandManager.register(command: command)
        open(
            command: command.name.rawValue,
            data: command.data,
            app: config.scheme,
            callback: config.callbackPath,
            id: id
        )
    }
    
    private static func open(command: String, data: [String: String], app: String, callback: String, id: String) {
        guard
            var components = buildURLComponents(commant: command),
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
    
    private static func buildURLComponents(commant: String) -> URLComponents? {
        guard let url = URL(string: "\(trustScheme)://\(commant)") else { return nil }
        return URLComponents(url: url, resolvingAgainstBaseURL: true)
    }
}
