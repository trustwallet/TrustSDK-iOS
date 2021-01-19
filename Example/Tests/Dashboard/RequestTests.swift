//
//  RequestTests.swift
//  PortfolioTests
//
//  Created by Guseinov Artur on 19.01.2021.
//

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
