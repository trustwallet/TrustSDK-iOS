//  Copyright © 2018 Trust.
//
//	This file is part of TrustSDK. The full TrustSDK copyright notice, including
//	terms governing use, modification, and redistribution, is contained in the
//	file LICENSE at the root of the source code distribution tree.
	

import Foundation

class CommandManager {
    private static var index: UInt64 = 0
    private var commands: [String: Command] = [:]
    
    func register(command: Command) -> String {
        let id = Self.nextId()
        commands[id] = command
        return id
    }
    
    func resolve(command id: String, with components: URLComponents) {
        guard let command = commands[id] else { return }
        command.resolve(with: components)
        commands.removeValue(forKey: id)
    }
    
    private static func nextId() -> String {
        index += 1
        return "\(index)"
    }
}
