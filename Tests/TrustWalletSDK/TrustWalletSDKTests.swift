// Copyright © 2018 Trust.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import BigInt
import Result
import TrustCore
import TrustWalletSDK
import XCTest

class TrustWalletSDKTests: XCTestCase {
    var delegate: MockWalletDelegate! // swiftlint:disable:this weak_delegate

    override func setUp() {
        super.setUp()
        delegate = MockWalletDelegate()
    }

    func testHandleSignMessage() {
        let sdk = TrustWalletSDK(delegate: delegate)
        let url = URL(string: "trust://sign-message?message=EjQ%3D&callback=app://sign-message")!
        let handled = sdk.handleOpen(url: url)

        XCTAssertTrue(handled)
        XCTAssertEqual(delegate.providedMessage, Data(hexString: "1234"))
    }

    func testHandleSignPersonalMessage() {
        let sdk = TrustWalletSDK(delegate: delegate)
        let url = URL(string: "trust://sign-personal-message?message=EjQ%3D&callback=app://sign-personal-message")!
        let handled = sdk.handleOpen(url: url)

        XCTAssertTrue(handled)
        XCTAssertEqual(delegate.providedMessage, Data(hexString: "1234"))
    }

    func testHandleSignTransaction() {
        let sdk = TrustWalletSDK(delegate: delegate)
        let url = URL(string: "trust://sign-transaction?gasPrice=0&gasLimit=10&to=0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed&amount=100&nonce=123&data=0x8f834227000000000000000000000000000000005224&callback=app://sign-transaction")!
        let handled = sdk.handleOpen(url: url)

        XCTAssertTrue(handled)
        XCTAssertEqual(delegate.providedTransaction?.gasPrice, 0)
        XCTAssertEqual(delegate.providedTransaction?.gasLimit, 10)
        XCTAssertEqual(delegate.providedTransaction?.to, EthereumAddress(string: "0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed"))
        XCTAssertEqual(delegate.providedTransaction?.amount, 100)
        XCTAssertEqual(delegate.providedTransaction?.nonce, 123)
        XCTAssertEqual(delegate.providedTransaction?.payload, Data(hexString: "0x8f834227000000000000000000000000000000005224"))
    }

    func testHandleError() {
        delegate.shouldFail = true
        let sdk = TrustWalletSDK(delegate: delegate)
        let url = URL(string: "trust://sign-transaction?gasPrice=0&gasLimit=10&to=0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed&amount=100&callback=app://sign-transaction")!
        let handled = sdk.handleOpen(url: url)

        XCTAssertTrue(handled)
    }
}

class MockWalletDelegate: WalletDelegate {
    var providedMessage: Data?
    var providedTransaction: Transaction?
    var shouldFail = false

    func signMessage(_ message: Data, address: Address?, completion: @escaping (Result<Data, WalletError>) -> Void) {
        if shouldFail {
            completion(.failure(.cancelled))
            return
        }
        providedMessage = message
        completion(.success(message))
    }

    func signPersonalMessage(_ message: Data, address: Address?, completion: @escaping (Result<Data, WalletError>) -> Void) {
        if shouldFail {
            completion(.failure(.cancelled))
            return
        }
        providedMessage = message
        completion(.success(message))
    }

    func signTransaction(_ transaction: Transaction, completion: @escaping (Result<Data, WalletError>) -> Void) {
        if shouldFail {
            completion(.failure(.cancelled))
            return
        }
        providedTransaction = transaction
        completion(.success(Data()))
    }
}
