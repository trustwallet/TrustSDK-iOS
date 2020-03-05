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
        let signCommand = TrustSDK.Command.sign(coin: .ethereum, input: Data())
        let getAccountsCommand = TrustSDK.Command.getAccounts(coins: [.ethereum, .bitcoin])

        XCTAssertEqual("sdk_sign", signCommand.name)
        XCTAssertEqual("sdk_get_accounts", getAccountsCommand.name)

        XCTAssertEqual(["coin": "60", "data": ""], signCommand.params)
        XCTAssertEqual(["coins": "60,0"], getAccountsCommand.params)
    }

    func testSignCommandInit() {
        let command = TrustSDK.Command.init(name: "sdk_sign", params: ["coin": "60", "data": ""])
        switch command {
        case let .sign(coin, data):
            XCTAssertEqual(CoinType.ethereum, coin)
            XCTAssertEqual(Data(), data)
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
