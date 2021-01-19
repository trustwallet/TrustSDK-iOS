// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.


import XCTest
@testable import TrustSDK_Example

final class RequestTests: XCTestCase {
	
	private let _baseUrl = URL(string: "https://www.some.com")!
	
	func testRequestAsUrlRequest() throws {
		var request = Request(baseUrl: _baseUrl, method: .get)
		request.path = "some"
		
		let urlRequest = try request.asUrlRequest()
		XCTAssertEqual("https://www.some.com/some", urlRequest.url?.absoluteString)
	}
	
	func testRequestAsUrlRequestSlash() throws {
		var request = Request(baseUrl: _baseUrl, method: .get)
		request.path = "/some"
		
		let urlRequest = try request.asUrlRequest()
		XCTAssertEqual("https://www.some.com/some", urlRequest.url?.absoluteString)
	}
	
	func testRequestWrongGetParams() {
		var request = Request(baseUrl: _baseUrl, method: .get)
		request.parameters = ["param1": 1]
				
		XCTAssertThrowsError(try request.asUrlRequest())
	}

}
