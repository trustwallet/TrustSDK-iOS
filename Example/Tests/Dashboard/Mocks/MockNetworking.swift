// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.


import Combine
import Foundation
@testable import TrustSDK_Example

final class MockNetworking<AnyValue: Decodable>: Networking {
	
	var value: AnyValue
	let data: Data
	
	init(value: AnyValue, data: Data) {
		self.value = value
		self.data = data
	}
	
	func loadObject<T>(_ request: Request) -> AnyPublisher<T, Error> where T : Decodable {
		return Just(value as! T)
			.setFailureType(to: Error.self)
			.eraseToAnyPublisher()
	}
	
	func loadData(request: URLRequest) -> AnyPublisher<Data, Error> {
		return Just(data)
			.setFailureType(to: Error.self)
			.eraseToAnyPublisher()
	}
	
}
