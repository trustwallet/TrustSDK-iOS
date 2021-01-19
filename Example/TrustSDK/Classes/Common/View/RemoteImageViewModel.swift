// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation
import Combine
import UIKit

final class RemoteImageViewModel: ObservableObject {
	
	@Published
	var image: UIImage
	
	// MARK: Dependencies
	
	private let url: URL
	private let imageLoader: ImageLoaderProtocol
	
	// MARK: Properties
	
	private var cancellables = Set<AnyCancellable>()
	
	// MARK: Initialization
	
	init(imageLoader: ImageLoaderProtocol, url: URL, placeholder: String?) {
		self.imageLoader = imageLoader
		self.url = url
		
		self.image = placeholder.flatMap { UIImage(named: $0) } ?? UIImage()
	}
	
	// MARK: Methods
	
	func loadImage() {
		imageLoader.load(from: url)
			.assertNoFailure()
			.assign(to: \.image, on: self)
			.store(in: &cancellables)
	}
	
}
