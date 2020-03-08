// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import XCTest
import TrustWalletCore
@testable import TrustSDK

class CommandTests: XCTestCase {
    func testSignCommandAttributes() {
        let signCommand = TrustSDK.Command.sign(coin: .ethereum, input: Data(), send: true, metadata: .dApp(name: "Test", url: URL(string: "https://dapptest.com")))
        let signParams = signCommand.params
        
        let getAccountsCommand = TrustSDK.Command.getAccounts(coins: [.ethereum, .bitcoin])
        let getAccountsParams = getAccountsCommand.params
                
        XCTAssertEqual("sdk_get_accounts", getAccountsCommand.name)
        XCTAssertEqual([60, 0], getAccountsParams["coins"] as? [UInt32])
        XCTAssertEqual([
            URLQueryItem(name: "coins.0", value: "60"),
            URLQueryItem(name: "coins.1", value: "0"),
        ], getAccountsParams.queryItems())
        
        XCTAssertEqual("sdk_sign", signCommand.name)
        XCTAssertEqual("60", signParams["coin"] as? String)
        XCTAssertEqual("", signParams["data"] as? String)
        XCTAssertTrue(signParams["send"] as! Bool)
        
        let metaParams = signParams["meta"] as! [String: Any]
        XCTAssertEqual("dapp", metaParams["__name"] as? String)
        XCTAssertEqual("Test", metaParams["name"] as? String)
        XCTAssertEqual("https://dapptest.com", metaParams["url"] as? String)
                
        XCTAssertEqual([
            URLQueryItem(name: "coin", value: "60"),
            URLQueryItem(name: "data", value: ""),
            URLQueryItem(name: "meta.__name", value: "dapp"),
            URLQueryItem(name: "meta.name", value: "Test"),
            URLQueryItem(name: "meta.url", value: "https://dapptest.com"),
            URLQueryItem(name: "send", value: "true"),
        ], signParams.queryItems())
    }

    func testSignCommandInit() {
        let command = TrustSDK.Command.init(
            name: "sdk_sign",
            params: [
                "coin": "60",
                "data": "",
                "send": "true",
                "meta": [
                    "__name": "dapp",
                    "name": "Test",
                    "url": "https://dapptest.com"
                ]
            ]
        )
        
        switch command {
        case let .sign(coin, data, send, meta):
            XCTAssertEqual(CoinType.ethereum, coin)
            XCTAssertEqual(Data(), data)
            XCTAssertTrue(send)
            XCTAssertEqual(TrustSDK.SignMetadata.dApp(name: "Test", url: URL(string: "https://dapptest.com")), meta)
        default:
            XCTFail()
        }
    }
    
    func testSignCommandInitFromURLComponents() {
        let components = URLComponents(string: "example://sdk_sign?coin=60&data=&send=true&meta.__name=dapp&meta.name=Test&meta.url=https%3A%2F%2Fdapptest.com")!
        let command = TrustSDK.Command.init(components: components)
        
        switch command {
        case let .sign(coin, data, send, meta):
            XCTAssertEqual(CoinType.ethereum, coin)
            XCTAssertEqual(Data(), data)
            XCTAssertTrue(send)
            XCTAssertEqual(TrustSDK.SignMetadata.dApp(name: "Test", url: URL(string: "https://dapptest.com")), meta)
        default:
            XCTFail()
        }
    }

    func testGetAccountsCommandInit() {
        let command = TrustSDK.Command.init(name: "sdk_get_accounts", params: ["coins": ["0": "60", "1": "0"]])
        switch command {
        case let .getAccounts(coins):
            XCTAssertEqual([CoinType.ethereum, CoinType.bitcoin], coins)
        default:
            XCTFail()
        }
    }
    
    func testGetAccountsCommandInitFromURLComponents() {
        let components = URLComponents(string: "example://sdk_get_accounts?coins.0=60&coins.1=0")!
        let command = TrustSDK.Command.init(components: components)
        
        switch command {
        case let .getAccounts(coins):
            XCTAssertEqual([CoinType.ethereum, CoinType.bitcoin], coins)
        default:
            XCTFail()
        }
    }
}
