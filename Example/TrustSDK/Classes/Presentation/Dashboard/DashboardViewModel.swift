//
//  Dashboard.swift
//  Portfolio
//
//  Created by Artur Guseinov on 14.01.2021.
//

import Foundation
import Combine

final class DashboardViewModel: ObservableObject {
	
	// MARK: Dependencies
	
	private let balanceService: BalanceService
	private let tokenService: TokenService
	
	@Published
	var balance: Balance
	
	@Published
	var tokenBalanceList: [TokenBalance]
	
	let address = "0x458fC1CB7e18331F696Dc38d3D15B5f4a52F5DE3"
	
	var cancellables = Set<AnyCancellable>()
	
	// MARK Initialization
	
	init(balanceService: BalanceService, tokenService: TokenService) {
		self.balanceService = balanceService
		self.tokenService = tokenService
		self.balance = Balance(value: 0)
		self.tokenBalanceList = []
		
		reloadBalance()
		reloadTokens()
	}
	
	func reloadBalance() {
		balanceService.balance(for: address)
			.replaceError(with: Balance(value: 0))
			.assign(to: \DashboardViewModel.balance, on: self)
			.store(in: &cancellables)
	}
	
	func reloadTokens() {
		tokenService.tokenList(for: address)
			.flatMap { [unowned self] tokens in
				Publishers.MergeMany(tokens.map {
					self.balanceService.tokenBalance(for: self.address, token: $0)
				})
			}
			.collect()
			.replaceError(with: [])
			.assign(to: \DashboardViewModel.tokenBalanceList, on: self)
			.store(in: &cancellables)
	}
}
