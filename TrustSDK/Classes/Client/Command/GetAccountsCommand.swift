//  Copyright © 2018 Trust.
//
//	This file is part of TrustSDK. The full TrustSDK copyright notice, including
//	terms governing use, modification, and redistribution, is contained in the
//	file LICENSE at the root of the source code distribution tree.
	

import Foundation
import TrustWalletCore

public typealias GetAccountsCallback = ((Result<[String], Error>) -> Void)

public struct GetAccountsCommand: Command {
    let separator = ":"
    
    enum QueryItems: String {
        case error, message, addresses
    }
    
    let name: CommandName = .getAccounts
    private let callback: GetAccountsCallback
    private let coins: [CoinType]
    
    var data: [String : String] {
        return [ "coins": coins.map{ "\($0.rawValue)" }.joined(separator: separator) ]
    }
    
    init(for coins: [CoinType], callback: @escaping GetAccountsCallback) {
        self.coins = coins
        self.callback = callback
    }
    
    func resolve(with components: URLComponents) {
        if let error = components.queryItem(for: QueryItems.error.rawValue)?.value {
            let message = components.queryItem(for: QueryItems.message.rawValue)?.value
            callback(Result.failure(TrustSDKError(from: error, value: message) ?? TrustSDKError.unknown))
            return
        }
        
        guard let addresses = components.queryItem(for: QueryItems.addresses.rawValue)?.value else {
            callback(Result.failure(TrustSDKError.invalidResult))
            return
        }
        
        callback(Result.success(addresses.components(separatedBy: separator)))
    }
}
