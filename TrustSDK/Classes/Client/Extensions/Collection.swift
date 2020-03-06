// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation

extension Collection {
    func toDictionary<Key, Value>(transform: (_ element: Element) -> [Key: Value]) -> [Key: Value] {
        return Dictionary(self, transform: transform)
    }
}
