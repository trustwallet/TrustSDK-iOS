//  Copyright © 2018 Trust.
//
//	This file is part of TrustSDK. The full TrustSDK copyright notice, including
//	terms governing use, modification, and redistribution, is contained in the
//	file LICENSE at the root of the source code distribution tree.
	

import Foundation
import TrustWalletCore
import SwiftProtobuf

public typealias SigningInput = SwiftProtobuf.Message
public typealias SigningOutput = SwiftProtobuf.Message

public extension TrustSDK {
    struct Signer<Output: SigningOutput> {
        let coin: CoinType
        
        public func sign(input: SigningInput, callback: @escaping ((Result<Output, Error>) -> Void)) {
            do {
                let command: TrustSDK.Command = .sign(coin: coin, input: try input.serializedData())
                try TrustSDK.send(request: SignRequest(command: command, callback: callback))
            } catch {
                callback(Result.failure(error))
            }
        }
    }
}
