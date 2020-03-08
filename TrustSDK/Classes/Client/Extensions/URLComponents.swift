// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation

extension URLComponents {
    func queryItem(for key: String) -> URLQueryItem? {
        return queryItems?.first(where: { $0.name == key })
    }

    func containsQueryItem(for key: String) -> Bool {
        guard let items = queryItems else { return false }
        return items.contains(where: { $0.name == key })
    }
}
