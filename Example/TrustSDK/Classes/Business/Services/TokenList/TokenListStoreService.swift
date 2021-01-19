//
//  TokenListStoreService.swift
//  Portfolio
//
//  Created by Guseinov Artur on 19.01.2021.
//

import Foundation

protocol TokenListService {
	func getToken(for asset: String) -> Token?
}

final class TokenListStoreService: TokenListService {
	
	// MARK: Properties
	
	private let tokens: [Token]
	
	// MARK: Initialization
	
	init(factory: TokenListFactory) {
		self.tokens = factory.create()
	}
	
	// MARK: Methods
	
	func getToken(for asset: String) -> Token? {
		return tokens.first(where: { $0.asset == asset })
	}
	
}
