//
//  String+0x.swift
//  Portfolio
//
//  Created by Guseinov Artur on 18.01.2021.
//

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
