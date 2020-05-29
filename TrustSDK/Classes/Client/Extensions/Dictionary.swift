// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation

extension Dictionary {
    init<C: Collection>(_ collection: C, transform: (_ element: C.Iterator.Element) -> [Key: Value]) {
        self.init()
        collection.forEach { (element) in
            for (k, v) in transform(element) {
                self[k] = v
            }
        }
    }
}

extension Dictionary where Key == String, Value: Any {
    public func queryItems() -> [URLQueryItem] {
        return queryItems(parentKey: nil)
    }

    private func queryItems(parentKey: String?) -> [URLQueryItem] {
        var items: [URLQueryItem] = []

        for (_key, _value) in self {
            let key = { () -> String in
                if let parent = parentKey {
                    return "\(parent).\(_key)"
                } else {
                    return _key
                }
            }()

            if let value = _value as? [String: Any] {
                items.append(contentsOf: value.queryItems(parentKey: key))
            } else if let value = _value as? [CustomStringConvertible] {
                items.append(
                    contentsOf: value
                        .enumerated()
                        .map { URLQueryItem(name: "\(key).\($0.offset)", value: $0.element.description) }
                )
            } else if let value = _value as? CustomStringConvertible {
                items.append(URLQueryItem(name: key, value: value.description))
            }
        }

        return items.sorted { $0.name < $1.name }
    }
}

extension Dictionary where Key == String, Value: Any {
    public init(queryItems items: [URLQueryItem]) {
        var dict: [String: Any] = [:]
        for item in items {
            Dictionary.fill(&dict, key: item.name, value: item.value ?? "")
        }

        self = (dict as? [String: Value]) ?? [:]
    }

    private static func fill(_ dict: inout [String: Any], key: String, value: Any) {
        if key.contains(".") {
            let comps = key.components(separatedBy: ".")
            let head = comps.first!
            var subdict = (dict[head] as? [String: Any]) ?? [:]
            fill(&subdict, key: comps.dropFirst().joined(separator: "."), value: value)
            dict[head] = subdict
        } else {
            dict[key] = value
        }
    }
}

extension Dictionary {
    // swiftlint:disable syntactic_sugar
    func mapKeys<T>(transform: (_ key: Key) -> T?) -> [T: Value] {
        let entries = self.compactMap { entry -> (key: T, value: Value)? in
            guard let key = transform(entry.key) else {
                return nil
            }

            return (key, entry.value)
        }
        return Dictionary<T, Value>(uniqueKeysWithValues: entries)
    }
}
