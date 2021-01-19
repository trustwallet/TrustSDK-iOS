// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.


import XCTest
@testable import TrustSDK_Example

final class MoneyTests: XCTestCase {

	func testBalance() {
		let balance = Balance(value: 2917158140000000)
		XCTAssertEqual(balance.localizedAmount, "BNB 0.00291715814")
	}
	
	func testTokenBalance() {
		let token = Token(asset: "c20000714_t0x4B0F1812e5Df2A09796481Ff14017e6005508003", address: "0x4B0F1812e5Df2A09796481Ff14017e6005508003", name: "Trust Wallet", symbol: "TWT", decimals: 18)
		let tokenBalance = TokenBalance(token: token, value: Decimal(string: "99500000000000000000")!)
		XCTAssertEqual(tokenBalance.localizedAmount, "TWT 99.5")
	}
	
}

