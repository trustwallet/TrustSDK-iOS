//  Copyright © 2018 Trust.
//
//	This file is part of TrustSDK. The full TrustSDK copyright notice, including
//	terms governing use, modification, and redistribution, is contained in the
//	file LICENSE at the root of the source code distribution tree.
	

import Foundation

public enum TrustSDKError: Swift.Error {
    case notInitialized
    case coinNotSupported
    case invalidResponse
    case rejected
    case signError(message: String)
    case unknown
    
    init?(from name: String, value: String? = nil) {
        switch name {
        case "notInitialized":
            self = .notInitialized
        case "coinNotSupported":
            self = .coinNotSupported
        case "invalidResponse":
            self = .invalidResponse
        case "rejected":
            self = . rejected
        case "signError":
            self = .signError(message: value ?? "")
        case "unknown":
            self = .unknown
        default:
            return nil
        }
    }
    
    init?(components: URLComponents) {
        guard let name = components.queryItem(for: "error")?.value else { return nil }
        self.init(from: name, value: components.queryItem(for: "message")?.value)
    }
        
    public var description: String {
        switch self {
        case .notInitialized:
            return "notInitialized"
        case .coinNotSupported:
            return "coinNotSupported"
        case .invalidResponse:
            return "invalidResponse"
        case .rejected:
            return "rejected"
        case .signError:
            return "signError"
        case .unknown:
            return "unknown"
        }
    }
    
    public var params: [String: String] {
        var params = [
            "error": self.description
        ]
        
        switch self {
        case .signError(let message):
            params["message"] = message
        default:
            break
        }
        
        return params
    }
}
