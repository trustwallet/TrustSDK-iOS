// Copyright © 2018 Trust.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation

public final class TrustSDK {

    let schemeManager = SchemeManager()

    public init() {

    }

    public func signTransaction(in viewController: UIViewController) {
        guard schemeManager.isTrustInstalled else {
            return fallbackToInstall(in: viewController)
        }
        open(for: Command(type: .signTransaction))
    }

    public func signMessage(in viewController: UIViewController) {
        guard schemeManager.isTrustInstalled else {
            return fallbackToInstall(in: viewController)
        }
        open(for: Command(type: .signMessage))
    }

    private func open(for command: Command) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: "\(schemeManager.current.key)://\(command.name)")!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(<#T##url: URL##URL#>)
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
