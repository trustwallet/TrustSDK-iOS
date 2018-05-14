// Copyright © 2018 Trust.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation

/// Describes a wallet app supporting the trust deeplink spec
public struct WalletApp {
    /// Wallet app name
    var name: String

    /// App URL scheme
    var scheme: String

    /// App install URL
    var installURL: URL
}
