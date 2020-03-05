// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation

class RequestRegistry {
    private static var index: UInt64 = 0
    private var requests: [String: Request] = [:]

    func register(request: Request) -> String {
        let id = Self.nextId()
        requests[id] = request
        return id
    }

    func resolve(request id: String, with components: URLComponents) {
        guard let request = requests[id] else { return }
        request.resolve(with: components)
        requests.removeValue(forKey: id)
    }

    private static func nextId() -> String {
        index += 1
        return "\(index)"
    }
}
