//
//  TokenService.swift
//  Portfolio
//
//  Created by Artur Guseinov on 14.01.2021.
//

import Foundation
import Combine

protocol TokenService {
    func tokenList(for address: Address) -> AnyPublisher<[Token], Error>
}

final class TokenNetworkService: TokenService {
    
    // MARK: Private properties
    
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
