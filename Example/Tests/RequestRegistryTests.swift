// Copyright DApps Platform Inc. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import XCTest
@testable import TrustSDK

struct MockRequest: CallbackRequest {
    typealias Response = String

    let command: TrustSDK.Command
    var callback: ((Result<String, Error>) -> Void)

    func resolve(with components: URLComponents) {
        callback(Result.success("test"))
    }
}

class RequestRegistryTests: XCTestCase {
    var registry: RequestRegistry!

    override func setUp() {
        super.setUp()
        registry = RequestRegistry()
    }

    func testResolve() {
        let expect = expectation(description: "Command resolved")

        let key = registry.register(request: MockRequest(command: .getAccounts(coins: []), callback: { _ in
            expect.fulfill()
        }))

        registry.resolve(request: key, with: URLComponents(string: "http://trustwallet.com")!)

        wait(for: [expect], timeout: 1)
    }
}
