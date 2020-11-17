// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import XCTest
import WalletCore
@testable import TrustSDK

class CommandTests: XCTestCase {
    func testSignCommandAttributes() {
        let signCommand = TrustSDK.Command.sign(coin: .ethereum, input: Data(), send: true, metadata: .dApp(name: "Test", url: URL(string: "https://dapptest.com")))
        let signParams = signCommand.params
        
        let getAccountsCommand = TrustSDK.Command.getAccounts(coins: [.ethereum, .bitcoin])
        let getAccountsParams = getAccountsCommand.params
                
        XCTAssertEqual("sdk_get_accounts", getAccountsCommand.name.rawValue)
        XCTAssertEqual([60, 0], getAccountsParams["coins"] as? [UInt32])
        XCTAssertEqual([
            URLQueryItem(name: "coins.0", value: "60"),
            URLQueryItem(name: "coins.1", value: "0"),
        ], getAccountsParams.queryItems())
        
        XCTAssertEqual("sdk_sign", signCommand.name.rawValue)
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
        let command = TrustSDK.Command(
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
        let command = TrustSDK.Command(components: components)
        
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
        let command = TrustSDK.Command(name: "sdk_get_accounts", params: ["coins": ["0": "60", "1": "0"]])
        switch command {
        case let .getAccounts(coins):
            XCTAssertEqual([CoinType.ethereum, CoinType.bitcoin], coins)
        default:
            XCTFail()
        }
    }
    
    func testGetAccountsCommandInitFromURLComponents() {
        let components = URLComponents(string: "example://sdk_get_accounts?coins.0=60&coins.1=0")!
        let command = TrustSDK.Command(components: components)
        
        switch command {
        case let .getAccounts(coins):
            XCTAssertEqual([CoinType.ethereum, CoinType.bitcoin], coins)
        default:
            XCTFail()
        }
    }

    func testTransactionToURL() {
        let app = "trust"
        let wallet = WalletApp(scheme: app, installURL: URL(string: "https://trustwallet.com")!)
        let tx = TrustSDK.Transaction(
            asset: UniversalAssetID(coin: .ethereum),
            to: "0x728B02377230b5df73Aa4E3192E89b6090DD7312",
            amount: "0.01",
            action: .transfer,
            confirm: .sign,
            from: nil,
            nonce: 447,
            feePrice: "2112000000",
            feeLimit: "21000",
            meta: "0xasdf"
        )

        let command = TrustSDK.Command(name: CommandName.signSimple.rawValue, params: tx.params())!

        let url = wallet.build(
            command: command.name.rawValue,
            params: tx.params().queryItems(),
            app: app,
            callback: "callback_me",
            id: "123"
        )!

        XCTAssertEqual(url.absoluteString, "trust://sdk_transaction?action=transfer&amount=0.01&asset=c60&confirm_type=sign&fee_limit=21000&fee_price=2112000000&meta=0xasdf&nonce=447&to=0x728B02377230b5df73Aa4E3192E89b6090DD7312&app=trust&callback=callback_me&id=123")
    }

    func testTransactionFromURLComponents() {
        let url = "trust://sdk_transaction?action=transfer&asset=c60_t0x514910771af9ca656af840dff83e8264ecf986ca&to=0x514910771af9ca656af840dff83e8264ecf986ca&amount=0.01&app=sample_app&callback=sdk_sign_result&confirm_type=send&nonce=2&from=0xF36f148D6FdEaCD6c765F8f59D4074109E311f0c&meta=memo&fee_limit=21000&fee_price=123456&id=1"
        let command = TrustSDK.Command(components: URLComponents(string: url)!)

        guard case .signSimple(let tx) = command else {
            XCTFail()
            return
        }

        XCTAssertEqual(tx.asset.coin, .ethereum)
        XCTAssertEqual(tx.action, .transfer)
        XCTAssertEqual(tx.confirm, .send)
        XCTAssertEqual(tx.to, "0x514910771af9ca656af840dff83e8264ecf986ca")
        XCTAssertEqual(tx.amount, "0.01")
        XCTAssertEqual(tx.nonce, 2)
        XCTAssertEqual(tx.amount, "0.01")
        XCTAssertEqual(tx.from, "0xF36f148D6FdEaCD6c765F8f59D4074109E311f0c")
        XCTAssertEqual(tx.meta, "memo")
        XCTAssertEqual(tx.feeLimit, "21000")
        XCTAssertEqual(tx.feePrice, "123456")
    }
}
