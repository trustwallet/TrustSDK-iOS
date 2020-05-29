// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation

public struct WalletSDK {
    public static var delegate: WalletSDKDelegate?

    public static func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        guard
            let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
            let request = WalletSDK.Request(components: components)else {
            return false
        }

        dispatch(request: request)

        return true
    }

    public static func dispatch(request: Request) {
        delegate?.didReceive(request: request, callback: { response in
            guard let url = request.callbackUrl(response: response) else { return }
            UIApplication.shared.open(url)
        })
    }
}

public protocol WalletSDKDelegate: class {
    func didReceive(request: WalletSDK.Request, callback: @escaping ((WalletSDK.Response) -> Void))
}
