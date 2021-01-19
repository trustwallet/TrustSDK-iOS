// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.


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
