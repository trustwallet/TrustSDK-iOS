//
//  RequestError.swift
//  Portfolio
//
//  Created by Artur Guseinov on 17.01.2021.
//

import Foundation

enum RequestError: Error, LocalizedError {
    case wrongPath
    case wrongGetParameters
	case wrongPostParameters
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .wrongPath: return "Bad request url path reference"
        case .wrongGetParameters: return "Bad request GET parameters reference"
		case .wrongPostParameters: return "Bad request POST parameters reference"
        case .unknown: return "Unknown error"
        }
    }
}
