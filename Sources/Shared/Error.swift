// Copyright © 2018 Trust.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation

public enum WalletSDKError: Int {
    /// Unknown Error
    case unknown = -1

    /// No Error occurred
    case none = 0

    /// Error generated when the user cancells the sign request.
    case cancelled = 1

    /// Error generated when the request is invalid.
    case invalidRequest = 2

    /// Error generated when current wallet is watch only
    case watchOnly = 3
}

extension WalletSDKError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown Error"
        case .none:
            return "No Error"
        case .cancelled:
            return "User cancelled"
        case .invalidRequest:
            return "Signing request is invalid"
        case .watchOnly:
            return "Wallet is watch only"
        }
    }
}
