//
//  RemoteImage.swift
//  Portfolio
//
//  Created by Guseinov Artur on 18.01.2021.
//

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
