//
//  BalanceService.swift
//  Portfolio
//
//  Created by Guseinov Artur on 18.01.2021.
//

import Foundation
import Combine

protocol BalanceService {
	func balance(for address: Address) -> AnyPublisher<Balance, Error>
	func tokenBalance(for address: Address, token: Token) -> AnyPublisher<TokenBalance, Error>
}

final class BalanceNetworkService: BalanceService {
	
	// MARK: Dependencies
	
	private let networking: Networking
	
	// MARK: Properties
	
	private let baseUrl = URL(string: URLs.rpcBaseUrl)!
	
	// MARK: Initialization
	
	init(networking: Networking) {
		self.networking = networking
	}
	
	// MARK: Methods
	
	func balance(for address: Address) -> AnyPublisher<Balance, Error> {
		var request = Request(baseUrl: baseUrl, method: .post)
		request.headers = ["Content-Type": "application/json"]
		request.parameters = [
			"jsonrpc":"2.0",
			"method":"eth_getBalance",
			"id":9,
			"params":[
				address,
				"latest"
			]
		]
		
		return networking
			.loadObject(request)
			.map { (response: RPCResponse) -> Balance in
				let value = Decimal(response.result, base: 16)
				return Balance(value: value ?? 0)
			}
			.eraseToAnyPublisher()
	}
	
	func tokenBalance(for address: Address, token: Token) -> AnyPublisher<TokenBalance, Error> {
		var request = Request(baseUrl: baseUrl, method: .post)
		request.headers = ["Content-Type": "application/json"]
		request.parameters = [
			"jsonrpc":"2.0",
			"method":"eth_call",
			"id":9,
			"params":[
				[
					"to": token.address,
					"data": "0x70a08231" + "000000000000000000000000\(address.deleting0x())"
				],
				"latest"
			]
		]
		
		return networking
			.loadObject(request)
			.map { (response: RPCResponse) -> TokenBalance in
				let value = Decimal(response.result, base: 16)
				return TokenBalance(token: token, value: value ?? 0)
			}
			.eraseToAnyPublisher()
	}
}
