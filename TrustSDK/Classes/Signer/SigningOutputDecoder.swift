//  Copyright © 2018 Trust.
//
//	This file is part of TrustSDK. The full TrustSDK copyright notice, including
//	terms governing use, modification, and redistribution, is contained in the
//	file LICENSE at the root of the source code distribution tree.
	

import Foundation
import TrustWalletCore

public struct SigningOutputDecoder {
    private init() { }
    
    static func decode(data: Data, for coin: CoinType) throws -> SigningOutput {
        switch coin {
        case .ethereum:
            return try EthereumSigningOutput(serializedData: data)
        default:
            throw TrustSDKError.coinNotSupported
        }
    }
}
