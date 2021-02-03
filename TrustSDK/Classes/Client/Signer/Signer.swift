// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation
import WalletCore
import SwiftProtobuf

public typealias SigningInput = SwiftProtobuf.Message

public extension TrustSDK {
    struct Signer {
        let coin: CoinType

        public init(coin: CoinType) {
            self.coin = coin
        }

        public func sign(_ tx: Transaction, callback: @escaping ((Result<String, Error>) -> Void)) {
            guard self.coin == .ethereum else {
                callback(.failure(TrustSDKError.coinNotSupported))
                return
            }
            do {
                let command = Command.signSimple(tx: tx)
                try TrustSDK.send(request: TransactionRequest(command: command, callback: callback))
            } catch {
                callback(.failure(error))
            }
        }

        public func sign(message: Data, metadata: SignMetadata? = nil, callback: @escaping ((Result<String, Error>) -> Void)) {
            if !TrustSDK.isSupported(coin: coin) {
                callback(.failure(TrustSDKError.coinNotSupported))
                return
            }
            do {
                let command = Command.signMessage(coin: coin, message: message, metadata: metadata)
                try TrustSDK.send(request: SignMessageRequest(command: command, callback: callback))
            } catch {
                callback(.failure(error))
            }
        }

        public func sign(input: SigningInput, metadata: SignMetadata? = nil, callback: @escaping ((Result<Data, Error>) -> Void)) {
            if !TrustSDK.isSupported(coin: coin) {
                callback(.failure(TrustSDKError.coinNotSupported))
                return
            }

            do {
                let command = Command.sign(coin: coin, input: try input.serializedData(), send: false, metadata: metadata)
                try TrustSDK.send(request: SignRequest(command: command, callback: callback))
            } catch {
                callback(.failure(error))
            }
        }

        public func signThenSend(input: SigningInput, metadata: SignMetadata? = nil, callback: @escaping ((Result<String, Error>) -> Void)) {
            if !TrustSDK.isSupported(coin: coin) {
                callback(.failure(TrustSDKError.coinNotSupported))
                return
            }

            do {
                let command: TrustSDK.Command = .sign(coin: coin, input: try input.serializedData(), send: true, metadata: metadata)
                try TrustSDK.send(request: SignThenSendRequest(command: command, callback: callback))
            } catch {
                callback(.failure(error))
            }
        }
    }
}
