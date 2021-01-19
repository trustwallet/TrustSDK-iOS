// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.


import Foundation

enum RequestError: Error, LocalizedError {
    case wrongPath
    case wrongGetParameters
	case wrongPostParameters
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .wrongPath: return "Bad request url path reference"
        case .wrongGetParameters: return "Bad request GET parameters reference"
		case .wrongPostParameters: return "Bad request POST parameters reference"
        case .unknown: return "Unknown error"
        }
    }
}
