// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.
	

import Foundation

final class OnboardModule {
	
	static func create() -> OnboardView {
		let viewModel = OnboardViewModel()
		return OnboardView(viewModel: viewModel)
	}
}
