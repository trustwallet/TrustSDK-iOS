// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.


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
