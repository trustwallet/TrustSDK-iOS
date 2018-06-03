// Copyright © 2018 Trust.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation

public enum WalletError: String, LocalizedError {
    /// Error generated when the user cancells the sign request.
    case cancelled

    /// Error generated when the request is invalid.
    case invalidRequest
}
