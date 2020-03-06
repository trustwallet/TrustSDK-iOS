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
        let signCommand = TrustSDK.Command.sign(coin: .ethereum, input: Data(), metadata: .dApp(name: "Test", url: URL(string: "https://dapptest.com")))
        let getAccountsCommand = TrustSDK.Command.getAccounts(coins: [.ethereum, .bitcoin])

        XCTAssertEqual("sdk_sign", signCommand.name)
        XCTAssertEqual("sdk_get_accounts", getAccountsCommand.name)

        XCTAssertEqual(["meta": "metaname~dapp|name~Test|url~https://dapptest.com", "coin": "60", "data": ""], signCommand.params)
        XCTAssertEqual(["coins": "60,0"], getAccountsCommand.params)
    }

    func testSignCommandInit() {
        let command = TrustSDK.Command.init(name: "sdk_sign", params: ["coin": "60", "data": "", "meta": "metaname~dapp|name~TestDApp|url~https://dapptest.com"])
        switch command {
        case let .sign(coin, data, meta):
            XCTAssertEqual(CoinType.ethereum, coin)
            XCTAssertEqual(Data(), data)
            XCTAssertEqual(TrustSDK.SignMetadata.dApp(name: "TestDApp", url: URL(string: "https://dapptest.com")), meta)
        default:
            XCTFail()
        }
    }

    func testGetAccountsCommandInit() {
        let command = TrustSDK.Command.init(name: "sdk_get_accounts", params: ["coins": "60,0"])
        switch command {
        case let .getAccounts(coins):
            XCTAssertEqual([CoinType.ethereum, CoinType.bitcoin], coins)
        default:
            XCTFail()
        }
    }
}
