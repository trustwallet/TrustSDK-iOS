// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.


import Foundation
import Combine

protocol TokenService {
    func tokenList(for address: Address) -> AnyPublisher<[Token], Error>
}

final class TokenNetworkService: TokenService {
    
    // MARK: Dependencies
    
    private let networking: Networking
	private let tokenListService: TokenListService
    
    // MARK: Initialization
    
	init(networking: Networking, tokenListService: TokenListService) {
        self.networking = networking
		self.tokenListService = tokenListService
    }
    
    // MARK: Methods
    
    func tokenList(for address: Address) -> AnyPublisher<[Token], Error> {
		let baseUrl = URL(string: URLs.trustApiBaseURl)!
        var request = Request(baseUrl: baseUrl, method: .get)
        request.path = "/v2/smartchain/tokens/" + address

		return networking
			.loadObject(request)
			.map { [weak self] (response: [String]) -> [Token] in
				return response.compactMap { self?.tokenListService.getToken(for: $0) }
			}.eraseToAnyPublisher()
    }
}
