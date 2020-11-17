// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation

enum TrustSDKErrorName: String {
    case notInitialized = "not_initialized"
    case coinNotSupported = "coin_not_supported"
    case invalidResponse = "invalid_response"
    case rejectedByUser = "rejected_by_user"
    case signError = "sign_error"
    case accountError = "account_error"
    case unknown
}

public enum TrustSDKError: Error {
    case notInitialized
    case coinNotSupported
    case invalidResponse
    case rejectedByUser
    case signError(message: String)
    case accountError
    case unknown

    init?(from name: String, value: String? = nil) {
        switch TrustSDKErrorName(rawValue: name) {
        case .notInitialized:
            self = .notInitialized
        case .coinNotSupported:
            self = .coinNotSupported
        case .invalidResponse:
            self = .invalidResponse
        case .rejectedByUser:
            self = .rejectedByUser
        case .signError:
            self = .signError(message: value ?? "")
        case .accountError:
            self = .accountError
        case .unknown:
            self = .unknown
        default:
            return nil
        }
    }

    init?(components: URLComponents) {
        guard let name = components.queryItem(for: "error")?.value else { return nil }
        self.init(from: name, value: components.queryItem(for: "message")?.value)
    }

    public var name: String {
        let name = { () -> TrustSDKErrorName in
            switch self {
            case .notInitialized:
                return .notInitialized
            case .coinNotSupported:
                return .coinNotSupported
            case .invalidResponse:
                return .invalidResponse
            case .rejectedByUser:
                return .rejectedByUser
            case .signError:
                return .signError
            case .accountError:
                return .accountError
            case .unknown:
                return .unknown
            }
        }()

        return name.rawValue
    }

    public var params: [String: String] {
        var params = [
            "error": self.name,
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
