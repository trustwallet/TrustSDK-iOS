//
//  CommandType.swift
//  Pods
//
//  Created by Viktor on 5/9/18.
//

import Foundation

public enum CommandType {
    case signTransaction
    case signMessage

    var name: String {
        switch self {
        case .signMessage:
            return "signMessage"
        case .signTransaction:
            return "signTransaction"
        }
    }
}
