//
//  NetworkService.swift
//  Portfolio
//
//  Created by Artur Guseinov on 16.01.2021.
//

import Foundation
import Combine

protocol Networking {
	func loadObject<T: Decodable>(_ request: Request) -> AnyPublisher<T, Error>
	func loadData(request: URLRequest) -> AnyPublisher<Data, Error>
}

final class NetworkService: Networking {
	
	// MARK: Private properties
	
	private let session: URLSession
	
	// MARK: Initialization
	
	init(session: URLSession) {
		self.session = session
	}
	
	func loadObject<T: Decodable>(_ request: Request) -> AnyPublisher<T, Error> {
		do {
			let urlRequest = try request.asUrlRequest()
			
			return session
				.dataTaskPublisher(for: urlRequest)
				.tryMap { result -> T in
					return try JSONDecoder().decode(T.self, from: result.data)
				}
				.receive(on: DispatchQueue.main)
				.eraseToAnyPublisher()
		} catch {
			return Fail(error: error).eraseToAnyPublisher()
		}
	}
	
	func loadData(request: URLRequest) -> AnyPublisher<Data, Error> {
		return session
			.dataTaskPublisher(for: request)
			.tryMap { $0.data }
			.receive(on: DispatchQueue.main)
			.eraseToAnyPublisher()
	}
}
