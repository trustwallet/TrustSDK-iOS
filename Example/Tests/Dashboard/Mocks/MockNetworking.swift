//
//  MockNetworkService.swift
//  PortfolioTests
//
//  Created by Guseinov Artur on 19.01.2021.
//

@testable import TrustSDK_Example
import Combine
import Foundation

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
