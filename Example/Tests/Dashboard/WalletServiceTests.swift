// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.
	

import XCTest
@testable import TrustSDK_Example

final class TrustSDKServiceTests: XCTestCase {
	
	var _walletService: WalletService!
			
	override func setUp() {
		_walletService = MockWalletService()
	}
	
	override func tearDown() {
		_walletService = nil
	}
	
	func testGetAccounts() {
		let expect = expectation(description: "testGetAccounts")
		
		_ = _walletService.getAccounts()
			.sink { _ in } receiveValue: { accounts in
				XCTAssertEqual(accounts[0], "0x458fC1CB7e18331F696Dc38d3D15B5f4a52F5DE3")
				expect.fulfill()
			}
		
		wait(for: [expect], timeout: 1.0)
	}
	
}
