// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.


import XCTest
@testable import TrustSDK_Example

final class TokenListServiceTests: XCTestCase {
	
	var _tokenListService: TokenListService!

	override func setUp() {
		_tokenListService = TokenListStoreService(factory: MockTokenListFactory())
	}
	
	override func tearDown() {
		_tokenListService = nil
	}
	
	func testTokenListService() {
		let token = _tokenListService.getToken(for: "c20000714_t0x4B0F1812e5Df2A09796481Ff14017e6005508003")
		XCTAssertNotNil(token)
		XCTAssertEqual(token?.address, token?.address)
	}
	
}
