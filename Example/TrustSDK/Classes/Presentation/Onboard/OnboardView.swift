// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.
	

import SwiftUI

struct OnboardView: UIViewControllerRepresentable {
	
	func makeUIViewController(context: Context) -> UIViewController {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		return storyboard.instantiateInitialViewController()!
	}
	
	func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
		
	}
}
