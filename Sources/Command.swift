// Copyright © 2018 Trust.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation

public protocol Command {
    /// Command name
    var name: String { get }

    /// Wallet request URL
    func requestURL(scheme: String) -> URL

    /// Handles a callback URL
    func handleCallback(url: URL) -> Bool
}
