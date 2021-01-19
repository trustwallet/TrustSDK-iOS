// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.


@testable import TrustSDK_Example

final class MockTokenListFactory: TokenListFactory {
	
	func create() -> [Token] {
		return [Token(asset: "c20000714_t0x4B0F1812e5Df2A09796481Ff14017e6005508003", address: "0x4B0F1812e5Df2A09796481Ff14017e6005508003", name: "Trust Wallet", symbol: "TWT", decimals: 18)]
	}
}
