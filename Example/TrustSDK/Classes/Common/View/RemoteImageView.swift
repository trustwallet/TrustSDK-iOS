// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.


import SwiftUI


struct RemoteImage: View {
	
	@ObservedObject
	private var viewModel: RemoteImageViewModel
	
	// MARK: Initialization
	
	init(url: URL, placeholder: String? = nil) {
		self.viewModel = RemoteImageViewModel(imageLoader: ImageLoader.shared, url: url, placeholder: placeholder)
	}
	
	init?(urlString: String, placeholder: String? = nil) {
		guard let url = URL(string: urlString) else { return nil }
		self.init(url: url, placeholder: placeholder)
	}
	
	var body: some View {
		Image(uiImage: viewModel.image)
			.resizable()
			.aspectRatio(contentMode: .fit)
			.onAppear {
				viewModel.loadImage()
			}
	}
}
