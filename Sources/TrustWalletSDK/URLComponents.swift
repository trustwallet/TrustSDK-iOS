// Copyright © 2018 Trust.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation

extension URLComponents {
    func queryParameterValue(for key: String) -> String? {
        return queryItems?.first(where: { $0.name == key })?.value
    }

    mutating func append(queryItem: URLQueryItem) {
        if queryItems != nil {
            queryItems?.append(queryItem)
        } else {
            queryItems = [queryItem]
        }
    }
}
