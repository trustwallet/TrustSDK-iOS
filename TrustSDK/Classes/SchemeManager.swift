//
//  SchemeManager.swift
//  TrustSDK
//
//  Created by Viktor on 5/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

public class SchemeManager {

    let schemes = [
        Scheme(
            name: "Trust",
            key: "trust",
            installURL: URL(string: "https://itunes.apple.com/ru/app/trust-ethereum-wallet/id1288339409")!
        )
    ]

    public var current: Scheme {
        return schemes.first!
    }

    public var availableSchemes: [Scheme] {
        return schemes.filter { UIApplication.shared.canOpenURL(URL(string: "\($0.key)://")!) }
    }

    public var isTrustInstalled: Bool {
        return !availableSchemes.isEmpty
    }
}
