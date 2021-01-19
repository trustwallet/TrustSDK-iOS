//
//  Money.swift
//  Portfolio
//
//  Created by Guseinov Artur on 18.01.2021.
//

import Foundation

protocol Money {
	var value: Decimal { get }
	var decimals: Int { get }
	var symbol: String { get }
}

extension Money {
	
	var amount: Decimal { value / pow(10, decimals) }
	
	var localizedAmount: String {
		let currencyFormatter = NumberFormatter()
		currencyFormatter.usesGroupingSeparator = true
		currencyFormatter.numberStyle = .currency
		currencyFormatter.locale = Locale(identifier: "en_US")
		currencyFormatter.maximumFractionDigits = decimals
		currencyFormatter.minimumFractionDigits = 0
		currencyFormatter.currencySymbol = symbol
		
		return currencyFormatter.string(from: amount as NSDecimalNumber) ?? "0 \(symbol)"
	}
}
