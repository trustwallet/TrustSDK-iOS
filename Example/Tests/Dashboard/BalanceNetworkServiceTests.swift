//
//  BalanceNetworkServiceTests.swift
//  PortfolioTests
//
//  Created by Guseinov Artur on 19.01.2021.
//

import XCTest
@testable import TrustSDK_Example

final class BalanceNetworkServiceTests: XCTestCase {
	
	var _networking: MockNetworking<RPCResponse>!
	var _balanceNetworkService: BalanceService!
		
	override func setUp() {
		_networking = MockNetworking(value: RPCResponse(result: ""), data: Data())
		_balanceNetworkService = BalanceNetworkService(networking: _networking)
	}
	
	override func tearDown() {
		_balanceNetworkService = nil
	}
	
	func testBalance() {
		let expect = expectation(description: "testBalance")
		
		_networking.value = RPCResponse(result: "0xa5d23ceb03700")
		
		_ = _balanceNetworkService.balance(for: "")
			.sink { _ in } receiveValue: { balance in
				XCTAssertEqual(balance.value, 2917158140000000)
				expect.fulfill()
			}
		
		wait(for: [expect], timeout: 1.0)
	}
	
	func testTokenBalance() {
		let expect = expectation(description: "testTokenBalance")
		
		_networking.value = RPCResponse(result: "0x00000000000000000000000000000000000000000000000564d702d38f5e0000")
		
		let token = Token(asset: "c20000714_t0x4B0F1812e5Df2A09796481Ff14017e6005508003",
						  address: "0x4B0F1812e5Df2A09796481Ff14017e6005508003",
						  name: "Trust Wallet",
						  symbol: "TWT",
						  decimals: 18)
		
		_ = _balanceNetworkService.tokenBalance(for: "", token: token)
			.sink { _ in } receiveValue: { balance in
				XCTAssertEqual(balance.value, Decimal(string: "99500000000000000000")!)
				expect.fulfill()
			}
		
		wait(for: [expect], timeout: 1.0)
	}
	
}
