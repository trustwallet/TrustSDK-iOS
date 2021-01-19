//
//  TokenBalance.swift
//  Portfolio
//
//  Created by Guseinov Artur on 18.01.2021.
//

import Foundation

struct TokenBalance {
	let token: Token
	let value: Decimal
}

extension TokenBalance: Identifiable {
	var id: String { return token.address }
}

extension TokenBalance: Money {
	var decimals: Int { token.decimals }
	var symbol: String { token.symbol }
}
