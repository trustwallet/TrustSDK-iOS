// Copyright © 2018 Trust.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Result
import TrustCore

/// Wallets should implement this delegate to handle requests
public protocol WalletDelegate: class {
    /// Signs a message with the specified address
    ///
    /// - Parameters:
    ///   - message: message data to sign
    ///   - address: address to use for signing
    ///   - completion: completing closure to call with the signed message or `nil` on failure
    func signMessage(_ message: Data, address: Address?, completion: @escaping (Result<Data, WalletError>) -> Void)

    /// Signs a personal message with the specified address
    ///
    /// - Parameters:
    ///   - message: message data to sign
    ///   - address: address to use for signing
    ///   - completion: completing closure to call with the signed message or `nil` on failure
    func signPersonalMessage(_ message: Data, address: Address?, completion: @escaping (Result<Data, WalletError>) -> Void)

    /// Signs a transaction
    ///
    /// - Parameters:
    ///   - transaction: transaction to sign
    ///   - completion: completing closure to call with the signed message or `nil` on failure
    func signTransaction(_ transaction: Transaction, completion: @escaping (Result<Data, WalletError>) -> Void)
}
