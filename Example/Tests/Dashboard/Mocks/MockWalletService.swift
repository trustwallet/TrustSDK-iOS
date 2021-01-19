// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.


import Foundation
import Combine
@testable import TrustSDK_Example

final class MockWalletService: WalletService {
	
	// MARK: Methods
	
	func getAccounts() -> AnyPublisher<[Address], Error> {
		return Just(["0x458fC1CB7e18331F696Dc38d3D15B5f4a52F5DE3"])
			.setFailureType(to: Error.self)
			.eraseToAnyPublisher()
		
	}
	
}
