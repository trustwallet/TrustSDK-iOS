//
//  Decimal+Base.swift
//  Portfolio
//
//  Created by Guseinov Artur on 18.01.2021.
//

import Foundation

extension Decimal {
	init?(_ string: String, base: Int) {
		
		var hexString = string
		
		if hexString.starts(with: "0x") {
			hexString.removeFirst(2)
		}
		
		var decimal: Decimal = 0

		let digits = hexString
			.map { String($0) }
			.map { Int($0, radix: base)! }

		for digit in digits {
			decimal *= Decimal(base)
			decimal += Decimal(digit)
		}

		self.init(string: decimal.description)
	}
}
