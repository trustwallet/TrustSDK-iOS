// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.


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
