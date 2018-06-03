// Copyright © 2018 Trust.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

@testable import TrustSDK
import XCTest

class SignPersonalMessageCommandTests: XCTestCase {

    func testRequestURL() {
        let message = Data(hexString: "1234")!
        let command = SignPersonalMessageCommand(message: message, address: nil, callbackScheme: "app") { _ in
            // Ignore
        }
        let url = command.requestURL(scheme: "trust")

        XCTAssertEqual(url.absoluteString, "trust://sign-personal-message?message=EjQ%3D&callback=app://sign-personal-message")
    }

    func testHandleCallback() {
        let message = Data(hexString: "1234")!
        let commandCompletedExpectation = expectation(description: "Command completed")
        let command = SignPersonalMessageCommand(message: message, address: nil, callbackScheme: "app") { result in
            commandCompletedExpectation.fulfill()
            guard case .success(let data) = result else {
                XCTFail("Expected success")
                return
            }
            XCTAssertEqual(data, message)
        }

        let url = URL(string: "app://sign-personal-message?result=EjQ%3D")!
        let handled = command.handleCallback(url: url)
        XCTAssertTrue(handled)

        wait(for: [commandCompletedExpectation], timeout: 0.1)
    }
}
