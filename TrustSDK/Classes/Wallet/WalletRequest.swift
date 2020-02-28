//  Copyright © 2018 Trust.
//
//	This file is part of TrustSDK. The full TrustSDK copyright notice, including
//	terms governing use, modification, and redistribution, is contained in the
//	file LICENSE at the root of the source code distribution tree.
	

import Foundation

public extension WalletSDK {
    struct Request {
        public let command: TrustSDK.Command
        public let app: String
        public let callback: String
        public let id: String                
    }
}
