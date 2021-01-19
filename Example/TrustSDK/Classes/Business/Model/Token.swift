//
//  Token.swift
//  Portfolio
//
//  Created by Artur Guseinov on 14.01.2021.
//

import Foundation

struct Token: Codable {
	let asset: String
    let address: Address
	let name: String
	let symbol: String
	let decimals: Int
}
