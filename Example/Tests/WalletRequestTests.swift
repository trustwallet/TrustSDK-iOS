// Copyright DApps Platform Inc. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import XCTest
import TrustWalletCore
@testable import TrustSDK

class WalletRequestTests: XCTestCase {
    func testResponseUrl() {
        let request = WalletSDK.Request(command: "sdk_get_accounts", params: ["coins": "60", "app": "trust", "callback": "callback", "id": "1"])!
        let response = WalletSDK.Response.accounts(["test"])

        XCTAssertEqual(URL(string: "trust://callback?accounts=test&id=1")!, request.callbackUrl(response: response)!)
    }
}
