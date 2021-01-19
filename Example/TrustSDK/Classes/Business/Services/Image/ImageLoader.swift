// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.


import Foundation
import Combine
import UIKit

protocol ImageLoaderProtocol {
	func load(from url: URL) -> AnyPublisher<UIImage, Error>
}

final class ImageLoader: ImageLoaderProtocol {
	
	static let shared: ImageLoaderProtocol = {
		let session = URLSession.shared
		let networking = NetworkService(session: session)
		return ImageLoader(networking: networking)
	}()
	
	// MARK: Dependencies
	
	private let networking: Networking
	
	// MARK: Properties
	
	private let queue = DispatchQueue(label: "ImageLoaderQueue")
	
	// MARK: Initialization
	
	init(networking: Networking) {
		self.networking = networking
	}
	
	// MARK: Methods
	
	func load(from url: URL) -> AnyPublisher<UIImage, Error> {
		let request = URLRequest(url: url)
		return networking
			.loadData(request: request)
			.compactMap { UIImage(data: $0) }
			.subscribe(on: queue)
			.receive(on: DispatchQueue.main)
			.eraseToAnyPublisher()
	}
}
