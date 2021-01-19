// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.


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
