//
//  Constants.swift
//  Portfolio
//
//  Created by Guseinov Artur on 18.01.2021.
//

import Foundation

	
struct URLs {
	static let trustApiBaseURl = "https://blockatlas.trustwallet.com"
	static let rpcBaseUrl = "https://bsc-dataseed.nariox.org"
	
	static func tokenAssetUrl(for token: Token) -> String {
		return "https://github.com/trustwallet/assets/blob/master/blockchains/smartchain/assets/\(token.address)/logo.png?raw=true"
	}
}
