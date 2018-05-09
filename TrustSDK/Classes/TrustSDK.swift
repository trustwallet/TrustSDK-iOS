//
//  TrustSDK.swift
//  TrustSDK
//
//  Created by Viktor on 5/9/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

public final class TrustSDK {

    let schemeManager = SchemeManager()

    public init() {

    }

    public func signTransaction(in viewController: UIViewController) {
        guard schemeManager.isTrustInstalled else {
            return fallbackToInstall(in: viewController)
        }
        open()
    }

    public func signMessage(in viewController: UIViewController) {
        guard schemeManager.isTrustInstalled else {
            return fallbackToInstall(in: viewController)
        }
        open()
    }

    private func open() {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: "\(schemeManager.current.key)://")!, options: [:], completionHandler: nil)
        } else {
            // Fallback on earlier versions
        }
    }

    func fallbackToInstall(in viewController: UIViewController) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: "\(schemeManager.current.key)://")!, options: [:], completionHandler: nil)
        } else {
            // Fallback on earlier versions
        }
    }
}
