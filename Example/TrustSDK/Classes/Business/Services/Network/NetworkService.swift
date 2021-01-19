// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.


import Foundation
import Combine

protocol Networking {
	func loadObject<T: Decodable>(_ request: Request) -> AnyPublisher<T, Error>
	func loadData(request: URLRequest) -> AnyPublisher<Data, Error>
}

final class NetworkService: Networking {
	
	// MARK: Dependencies
	
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
