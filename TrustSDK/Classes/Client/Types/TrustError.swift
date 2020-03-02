// Copyright DApps Platform Inc. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.
	

import Foundation

public enum TrustSDKError: Swift.Error {
    case notInitialized
    case coinNotSupported
    case invalidResponse
    case rejectedByUSer
    case signError(message: String)
    case unknown
    case invalidWallet
    
    init?(from name: String, value: String? = nil) {
        switch name {
        case "notInitialized":
            self = .notInitialized
        case "coinNotSupported":
            self = .coinNotSupported
        case "invalidResponse":
            self = .invalidResponse
        case "rejectedByUSer":
            self = .rejectedByUSer
        case "signError":
            self = .signError(message: value ?? "")
        case "unknown":
            self = .unknown
        case "invalidWallet":
            self = .invalidWallet
        default:
            return nil
        }
    }
    
    init?(components: URLComponents) {
        guard let name = components.queryItem(for: "error")?.value else { return nil }
        self.init(from: name, value: components.queryItem(for: "message")?.value)
    }
        
    public var name: String {
        switch self {
        case .notInitialized:
            return "notInitialized"
        case .coinNotSupported:
            return "coinNotSupported"
        case .invalidResponse:
            return "invalidResponse"
        case .rejectedByUSer:
            return "rejectedByUSer"
        case .signError:
            return "signError"
        case .unknown:
            return "unknown"
        case .invalidWallet:
            return "invalidWallet"
        }
    }
    
    public var params: [String: String] {
        var params = [
            "error": self.name
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
