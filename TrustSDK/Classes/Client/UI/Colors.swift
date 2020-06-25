// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import UIKit

extension TrustSDK {
    public struct Colors {
        static let white = color(light: .white, dark: .white)
        static let light = color(light: .white, dark: .black)
        static let black = color(light: .black, dark: .black)
        static let blue = color(light: UIColor(hex: 0x2e91db), dark: UIColor(hex: 0x4390E2))

        internal static func color(light: UIColor, dark: UIColor) -> UIColor {
            if #available(iOS 13.0, *) {
                return UIColor { (traits) -> UIColor in
                    return traits.userInterfaceStyle == .dark ? dark : light
                }
            } else {
                return light
            }
        }
    }
}
