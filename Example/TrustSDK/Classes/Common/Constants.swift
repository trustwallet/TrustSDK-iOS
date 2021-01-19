// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.


import Foundation

	
struct URLs {
	static let trustApiBaseURl = "https://blockatlas.trustwallet.com"
	static let rpcBaseUrl = "https://bsc-dataseed.nariox.org"
	
	static func tokenAssetUrl(for token: Token) -> String {
		return "https://github.com/trustwallet/assets/blob/master/blockchains/smartchain/assets/\(token.address)/logo.png?raw=true"
	}
}
