//  Copyright © 2018 Trust.
//
//	This file is part of TrustSDK. The full TrustSDK copyright notice, including
//	terms governing use, modification, and redistribution, is contained in the
//	file LICENSE at the root of the source code distribution tree.
	

import Foundation

enum TrustSDKError: Error {
    case notInitialized
    case coinNotSupported
    case invalidResult
    case rejected
    case signError(message: String)
    case unknown
    
    init?(from key: String, value: String? = nil) {
        switch key {
        case "notInitialized": self = .notInitialized
        case "coinNotSupported": self = .coinNotSupported
        case "invalidResult": self = .invalidResult
        case "rejected": self = . rejected
        case "signError": self = .signError(message: value ?? "")
        case "unknown": self = .unknown
        default: return nil
        }
    }
}
