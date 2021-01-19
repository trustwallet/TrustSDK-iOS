// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.
	

import Combine
import TrustSDK

protocol WalletService {
	func getAccounts() -> AnyPublisher<[Address], Error>
}

final class TrustSDKService: WalletService {
	
	// MARK: Methods
	
	func getAccounts() -> AnyPublisher<[Address], Error> {
		#if targetEnvironment(simulator)
		return Just(["0x458fC1CB7e18331F696Dc38d3D15B5f4a52F5DE3"])
			.setFailureType(to: Error.self)
			.eraseToAnyPublisher()
		
		#else
		return Future { completion in
			TrustSDK.getAccounts(for: [.smartChain]) { result in
				switch result {
				case .success(let accounts): completion(.success(accounts))
				case .failure(let error): completion(.failure(error))
				}
			}
		}.eraseToAnyPublisher()
		#endif
	}
	
}
