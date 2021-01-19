//
//  Balance.swift
//  Portfolio
//
//  Created by Guseinov Artur on 18.01.2021.
//

import Foundation

struct Balance {
	let value: Decimal
}

extension Balance: Money {
	var decimals: Int { 18 }
	var symbol: String { "BNB" }
}
