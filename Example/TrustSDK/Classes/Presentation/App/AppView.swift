// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.
	
import SwiftUI

struct AppView: View {
	var body: some View {
		TabView {
			OnboardModule.create()
				.tabItem {
					Image(systemName: "square.and.pencil")
					Text("Onboard")
				}
			
			DashboardModule.create()
				.tabItem {
					Image(systemName: "list.dash")
					Text("Dashboard")
				}
		}
	}
}
