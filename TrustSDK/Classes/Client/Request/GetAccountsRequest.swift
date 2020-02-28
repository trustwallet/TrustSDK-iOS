//  Copyright © 2018 Trust.
//
//	This file is part of TrustSDK. The full TrustSDK copyright notice, including
//	terms governing use, modification, and redistribution, is contained in the
//	file LICENSE at the root of the source code distribution tree.
	

import Foundation

struct GetAccountsRequest: CallbackRequest {
    enum QueryItems: String {
        case error, message, addresses
    }
    
    typealias Response = [String]
    
    let command: TrustSDK.Command
    let callback: Callback
    
    init(command: TrustSDK.Command, callback: @escaping Callback) {
        self.command = command
        self.callback = callback
    }
    
    func resolve(with components: URLComponents) {
        if let error = components.queryItem(for: QueryItems.error.rawValue)?.value {
            let message = components.queryItem(for: QueryItems.message.rawValue)?.value
            callback(Result.failure(TrustSDKError(from: error, value: message) ?? TrustSDKError.unknown))
            return
        }
        
        guard let addresses = components.queryItem(for: QueryItems.addresses.rawValue)?.value else {
            callback(Result.failure(TrustSDKError.invalidResponse))
            return
        }
        
        callback(Result.success(addresses.components(separatedBy: ":")))
    }
}
