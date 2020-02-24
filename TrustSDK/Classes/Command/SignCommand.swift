//  Copyright © 2018 Trust.
//
//	This file is part of TrustSDK. The full TrustSDK copyright notice, including
//	terms governing use, modification, and redistribution, is contained in the
//	file LICENSE at the root of the source code distribution tree.
	

import Foundation
import TrustWalletCore

public typealias SignCallback<Output : SigningOutput> = ((Result<Output, Error>) -> Void)

public struct SignCommand<Output: SigningOutput>: Command {
    enum QueryItems: String {
        case error, message, coin, data
    }
    
    private let coin: CoinType
    private let callback: SignCallback<Output>
    private let input: SigningInput
    
    let name: String = "sign"
    private(set) var data: [String: String] = [:]
    
    init(coin: CoinType, input: SigningInput, callback: @escaping SignCallback<Output>) throws {
        self.coin = coin
        self.callback = callback
        self.input = input
        
        data = [
            "coin": coin.rawValue.description,
            "data": try input.encode().base64UrlEncodedString()
        ]
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
            callback(Result.failure(TrustSDKError.invalidResult))
            return
        }
        
        do {
            let output = try SigningOutputDecoder.decode(data: data, for: coin) as! Output
            callback(Result.success(output))
        } catch {
            callback(Result.failure(error))
        }
    }
}
