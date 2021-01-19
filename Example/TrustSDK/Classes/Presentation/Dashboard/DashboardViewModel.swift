// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.


import Foundation
import Combine

final class DashboardViewModel: ObservableObject {
	
	// MARK: Dependencies
	
	private let balanceService: BalanceService
	private let tokenService: TokenService
	private let walletService: WalletService
	
	@Published
	var balance: Balance
	
	@Published
	var tokenBalanceList: [TokenBalance]
	
	@Published
	var addresses: [Address] {
		didSet {
			reloadBalance()
			reloadTokens()
		}
	}
	
	var cancellables = Set<AnyCancellable>()
	
	// MARK Initialization
	
	init(balanceService: BalanceService, tokenService: TokenService, walletService: WalletService) {
		self.balanceService = balanceService
		self.tokenService = tokenService
		self.walletService = walletService
		
		self.balance = Balance(value: 0)
		self.tokenBalanceList = []
		self.addresses = []

		reloadAddress()
	}
	
	func reloadAddress() {
		walletService.getAccounts()
			.replaceError(with: [])
			.assign(to: \DashboardViewModel.addresses, on: self)
			.store(in: &cancellables)
	}
	
	func reloadBalance() {
		guard let address = addresses.first else { return }
		
		balanceService.balance(for: address)
			.replaceError(with: Balance(value: 0))
			.assign(to: \DashboardViewModel.balance, on: self)
			.store(in: &cancellables)
	}
	
	func reloadTokens() {
		guard let address = addresses.first else { return }
		
		tokenService.tokenList(for: address)
			.flatMap { [unowned self] tokens in
				Publishers.MergeMany(tokens.map {
					self.balanceService.tokenBalance(for: address, token: $0)
				})
			}
			.collect()
			.replaceError(with: [])
			.assign(to: \DashboardViewModel.tokenBalanceList, on: self)
			.store(in: &cancellables)
	}
}
