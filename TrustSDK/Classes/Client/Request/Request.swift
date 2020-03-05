// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation

protocol Request {
    var command: TrustSDK.Command { get }
    func resolve(with components: URLComponents)
}

protocol CallbackRequest: Request {
    associatedtype Response

    typealias Callback = ((Result<Response, Error>) -> Void)
    var callback: Callback { get }
}
