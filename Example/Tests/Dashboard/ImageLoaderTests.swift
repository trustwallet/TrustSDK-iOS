//
//  ImageLoaderTests.swift
//  PortfolioTests
//
//  Created by Guseinov Artur on 19.01.2021.
//

import XCTest
@testable import TrustSDK_Example

final class ImageLoaderTests: XCTestCase {
	
	var _imageLoader: ImageLoaderProtocol!
	
	var _image = UIImage(systemName: "multiply.circle.fill")!
		
	override func setUp() {
		let data = _image.pngData()
		let networking = MockNetworking(value: "", data: data!)
		_imageLoader = ImageLoader(networking: networking)
	}
	
	override func tearDown() {
		_imageLoader = nil
	}
	
	func testImageLoader() {
		let expect = expectation(description: "testImageLoader")
		
		_ = _imageLoader.load(from: URL(string: "https://www.some.com")!)
			.sink { _ in } receiveValue: { image in
				XCTAssertEqual(image.size.height.truncatingRemainder(dividingBy: self._image.size.height), 0)
				XCTAssertEqual(image.size.width.truncatingRemainder(dividingBy: self._image.size.width), 0)
				expect.fulfill()
			}
		
		wait(for: [expect], timeout: 1.0)
	}
	
}
