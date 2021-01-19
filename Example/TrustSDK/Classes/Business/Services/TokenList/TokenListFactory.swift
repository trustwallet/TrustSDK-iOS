// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.


import Foundation

protocol TokenListFactory {
	func create() -> [Token]
}

final class TokenListBundleFactory: TokenListFactory {
	
	// MARK: Methods
	
	func create() -> [Token] {
		do {
			guard let url = Bundle.main.url(forResource: "tokenList", withExtension: "json") else {
				throw URLError(.badURL)
			}
			
			let data = try Data(contentsOf: url)
			return try JSONDecoder().decode([Token].self, from: data)
			
		} catch {
			preconditionFailure(error.localizedDescription)
		}
	}
}
