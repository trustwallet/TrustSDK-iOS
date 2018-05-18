// Copyright © 2018 Trust.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import BigInt
import TrustCore
@testable import TrustSDK
import XCTest

class SignTransactionCommandTests: XCTestCase {
    let address = Address(string: "5aaeb6053f3e94c9b9a09f33669435e7ef1beaed")!

    func testRequestURL() {
        var transaction = Transaction(gasPrice: BigInt(), gasLimit: 10, to: address)
        transaction.amount = BigInt("100")

        let command = SignTransactionCommand(transaction: transaction, callbackScheme: "app") { _ in
            // Ignore
        }
        let url = command.requestURL(scheme: "trust")

        XCTAssertEqual(url.absoluteString, "trust://sign-transaction?gasPrice=0&gasLimit=10&to=0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed&amount=100&callback=app://sign-transaction")
    }

    func testHandleCallback() {
        var transaction = Transaction(gasPrice: BigInt(), gasLimit: 10, to: address)
        transaction.amount = BigInt("100")

        let commandCompletedExpectation = expectation(description: "Command completed")
        let command = SignTransactionCommand(transaction: transaction, callbackScheme: "app") { transaction in
            commandCompletedExpectation.fulfill()
            XCTAssertEqual(transaction.v, BigInt(1))
            XCTAssertEqual(transaction.r, BigInt(2))
            XCTAssertEqual(transaction.s, BigInt(3))
        }

        let url = URL(string: "app://sign-transaction?v=1&r=2&s=3")!
        let handled = command.handleCallback(url: url)
        XCTAssertTrue(handled)

        wait(for: [commandCompletedExpectation], timeout: 0.1)
    }
}
