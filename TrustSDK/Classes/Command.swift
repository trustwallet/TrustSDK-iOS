//
//  Command.swift
//  Pods
//
//  Created by Viktor on 5/9/18.
//

import Foundation

public struct Command {
    let type: CommandType

    var name: String {
        return type.name
    }
}
