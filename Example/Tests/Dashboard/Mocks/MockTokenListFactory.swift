//
//  MockTokenListFactory.swift
//  PortfolioTests
//
//  Created by Guseinov Artur on 19.01.2021.
//

@testable import TrustSDK_Example

final class MockTokenListFactory: TokenListFactory {
	
	func create() -> [Token] {
		return [Token(asset: "c20000714_t0x4B0F1812e5Df2A09796481Ff14017e6005508003", address: "0x4B0F1812e5Df2A09796481Ff14017e6005508003", name: "Trust Wallet", symbol: "TWT", decimals: 18)]
	}
}
