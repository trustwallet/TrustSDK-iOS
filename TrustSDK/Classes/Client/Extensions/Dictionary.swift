// Copyright DApps Platform Inc. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.
	

import Foundation

extension Dictionary {
    init<C: Collection>(_ collection: C, transform:(_ element: C.Iterator.Element) -> [Key : Value]) {
        self.init()
        collection.forEach { (element) in
            for (k, v) in transform(element) {
                self[k] = v
            }
        }
    }
}
