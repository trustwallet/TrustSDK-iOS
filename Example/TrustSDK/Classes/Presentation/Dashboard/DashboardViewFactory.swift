// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.
	

import Foundation

final class DashboardViewFactory {
	
	static func create() -> DashboardView {
		let session = URLSession.shared
		let networkService = NetworkService(session: session)
		let balanceService = BalanceNetworkService(networking: networkService)
		let tokenListFactory = TokenListBundleFactory()
		let tokenListService = TokenListStoreService(factory: tokenListFactory)
		let tokenService = TokenNetworkService(networking: networkService, tokenListService: tokenListService)
		let walletService = TrustSDKService()
		let viewModel = DashboardViewModel(balanceService: balanceService, tokenService: tokenService, walletService: walletService)
		return DashboardView(viewModel: viewModel)
	}
}
