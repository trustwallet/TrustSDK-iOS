//
//  TokenNetworkServiceTests.swift
//  PortfolioTests
//
//  Created by Guseinov Artur on 19.01.2021.
//

import XCTest
@testable import TrustSDK_Example

final class TokenNetworkServiceTests: XCTestCase {
	
	var _tokenNetworkService: TokenService!
	
	let _assets = ["c20000714_t0x4B0F1812e5Df2A09796481Ff14017e6005508003"]
	
	override func setUp() {
		let networking = MockNetworking(value: _assets, data: Data())
		let tokenListFactory = MockTokenListFactory()
		let tokenListService = TokenListStoreService(factory: tokenListFactory)
		_tokenNetworkService = TokenNetworkService(networking: networking, tokenListService: tokenListService)
	}
	
	override func tearDown() {
		_tokenNetworkService = nil
	}
	
	func testTokenList() {
		let expect = expectation(description: "testTokenList")
		
		_ = _tokenNetworkService.tokenList(for: "")
			.sink { _ in } receiveValue: { tokens in
				XCTAssertEqual(tokens[0].address, "0x4B0F1812e5Df2A09796481Ff14017e6005508003")
				expect.fulfill()
			}
		
		wait(for: [expect], timeout: 1.0)
	}
	
}
