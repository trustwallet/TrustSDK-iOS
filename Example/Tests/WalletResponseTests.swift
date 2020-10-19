// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import XCTest
import WalletCore
@testable import TrustSDK

class WalletResponseTests: XCTestCase {
    func testResponseAttributes() {
        let sign = WalletSDK.Response.sign(output: Data(hexEncoded: "0x123456")!)
        let accounts = WalletSDK.Response.accounts(["test1", "test2"])
        let failure = WalletSDK.Response.failure(error: TrustSDKError.unknown)

        XCTAssertEqual(["data": "EjRW"], sign.params)
        XCTAssertEqual(["accounts": "test1,test2"], accounts.params)
        XCTAssertEqual(["error": "unknown"], failure.params)
    }
}
