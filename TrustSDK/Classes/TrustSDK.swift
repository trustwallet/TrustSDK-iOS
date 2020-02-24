//  Copyright © 2018 Trust.
//
//	This file is part of TrustSDK. The full TrustSDK copyright notice, including
//	terms governing use, modification, and redistribution, is contained in the
//	file LICENSE at the root of the source code distribution tree.
	

import Foundation
import TrustWalletCore

public class TrustSDK {
    enum QueryItems: String {
        case command
    }
    
    public static let signers = Signers()
    internal static var configuration: TrustConfiguration?
    internal static let commandManager = CommandManager()
    
    public static func initialize(with configuration: TrustConfiguration) {
        self.configuration = configuration
    }
        
    public static func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplicationOpenURLOptionsKey: Any] = [:]
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
        
        guard let command = components.queryItem(for: QueryItems.command.rawValue)?.value else {
            return false
        }
        
        commandManager.resolve(command: command, with: components)                                
        return true
    }
}

extension TrustSDK {
    static func getAddress(for coins:[CoinType], callback: @escaping GetAddressCallback) {
        do {
            let command = GetAddressCommand(for: coins, callback: callback)
            try TrustWalletApp.send(command: command)
        } catch {
            callback(Result.failure(error))
        }
    }
}

public struct Signers {
    public var ethereum: Signer<EthereumSigningOutput> {
        return Signer(coin: .ethereum)
    }
}
