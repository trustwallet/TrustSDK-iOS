// Copyright © 2018 Trust.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation

public class SchemeManager {

    let schemes = [
        Scheme(
            name: "Trust",
            key: "trust",
            installURL: URL(string: "https://itunes.apple.com/ru/app/trust-ethereum-wallet/id1288339409")!
        )
    ]

    public var current: Scheme {
        return schemes.first!
    }

    public var availableSchemes: [Scheme] {
        return schemes.filter { UIApplication.shared.canOpenURL(URL(string: "\($0.key)://")!) }
    }

    public var isTrustInstalled: Bool {
        return !availableSchemes.isEmpty
    }
}
