//
//  TokenListFactory.swift
//  Portfolio
//
//  Created by Guseinov Artur on 19.01.2021.
//

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
