// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import UIKit

extension TrustSDK {
    public static let resourceBundle: Bundle = {
        let bundle = Bundle(for: TrustSDK.self)
        guard let resourceBundleUrl = bundle.url(forResource: "TrustSDK", withExtension: "bundle") else {
            fatalError("TrustSDK.bundle not found!")
        }
        guard let resourceBundle = Bundle(url: resourceBundleUrl) else {
            fatalError("Could not access TrustSDK.bundle")
        }
        return resourceBundle
    }()

    public enum Icon {
        case trust, shieldFilled, shieldLined

        public var image: UIImage? {
            switch self {
            case .trust:
                return UIImage(named: "trust", in: TrustSDK.resourceBundle, compatibleWith: nil)
            case .shieldFilled:
                return UIImage(named: "trust.shield.fill", in: TrustSDK.resourceBundle, compatibleWith: nil)
            case .shieldLined:
                return UIImage(named: "trust.shield", in: TrustSDK.resourceBundle, compatibleWith: nil)
            }
        }
    }

}
