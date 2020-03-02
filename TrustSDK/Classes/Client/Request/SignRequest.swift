// Copyright DApps Platform Inc. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.
	

import Foundation
import TrustWalletCore

struct SignRequest<Output: SigningOutput>: CallbackRequest {
    enum QueryItems: String {
        case error, message, coin, data
    }
    
    typealias Response = Output
    
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
        
        guard let coin = components.queryItem(for: QueryItems.coin.rawValue)?.coinValue,
              let data = components.queryItem(for: QueryItems.data.rawValue)?.dataValue
            else {
                callback(Result.failure(TrustSDKError.invalidResponse))
            return
        }
        
        do {
            if let output = try SigningOutputDecoder.decode(data: data, for: coin) as? Output {
                callback(Result.success(output))
            } else {
                callback(Result.failure(TrustSDKError.invalidResponse))
            }
        } catch {
            callback(Result.failure(error))
        }
    }
}
