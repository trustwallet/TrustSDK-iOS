//  Copyright © 2018 Trust.
//
//	This file is part of TrustSDK. The full TrustSDK copyright notice, including
//	terms governing use, modification, and redistribution, is contained in the
//	file LICENSE at the root of the source code distribution tree.
	

import Foundation
import TrustWalletCore

public class TrustSDK {
    enum QueryItems: String {
        case id
    }
    
    public static let signers = Signers()
    internal static var configuration: TrustConfiguration?
    internal static let requestRegistry = RequestRegistry()
    
    public static func initialize(with configuration: TrustConfiguration) {
        self.configuration = configuration
    }
        
    public static func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        guard
            let config = configuration,
            let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
            let scheme = components.scheme,
            let host = components.host,
            scheme == config.scheme && host == config.callbackPath
        else {
            return false
        }
        
        guard let id = components.queryItem(for: QueryItems.id.rawValue)?.value else {
            return false
        }
        
        requestRegistry.resolve(request: id, with: components)
        return true
    }
    
    static func send(request: Request) throws {
        guard let config = configuration else {
            throw TrustSDKError.notInitialized
        }
        
        let id = requestRegistry.register(request: request)
        let command = request.command
        config.walletApp.open(
            command: command.name,
            params: command.params,
            app: config.scheme,
            callback: config.callbackPath,
            id: id
        )
    }
}

public extension TrustSDK {
    static func getAccounts(for coins:[CoinType], callback: @escaping ((Result<[String], Error>) -> Void)) {
        do {
            let command: TrustSDKCommand = .getAccounts(coins: coins)
            try send(request: GetAccountsRequest(command: command, callback: callback))
        } catch {
            callback(Result.failure(error))
        }
    }
}
