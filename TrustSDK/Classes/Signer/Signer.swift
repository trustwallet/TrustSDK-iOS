//  Copyright © 2018 Trust.
//
//	This file is part of TrustSDK. The full TrustSDK copyright notice, including
//	terms governing use, modification, and redistribution, is contained in the
//	file LICENSE at the root of the source code distribution tree.
	

import Foundation
import TrustWalletCore
import SwiftProtobuf

public typealias SigningOutput = SwiftProtobuf.Message

public struct Signer<Output: SigningOutput> {
    let coin: CoinType
    
    public func sign(input: SigningInput, callback: @escaping SignCallback<Output>) {
        do {
            let command = try SignCommand(coin: coin, input: input, callback: callback)
            try TrustWalletApp.send(command: command)
        } catch {
            callback(Result.failure(error))
        }
    }
}
