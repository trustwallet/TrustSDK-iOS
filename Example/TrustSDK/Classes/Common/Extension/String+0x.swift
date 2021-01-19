// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.


import Foundation

extension String {
	func deleting0x() -> String {
		guard starts(with: "0x") else {
			return self
		}
		var string = self
		string.removeFirst(2)
		return string
	}
}
