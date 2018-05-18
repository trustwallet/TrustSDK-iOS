// Copyright © 2018 Trust.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import TrustCore

/// Wallets should implement this delegate to handle requests
public protocol WalletDelegate: class {
    /// Signs a message with the specified address
    ///
    /// - Parameters:
    ///   - message: message data to sign
    ///   - address: address to use for signing
    /// - Returns: signed message
    /// - Throws: implementations can throw any error to indicate failure
    func signMessage(_ message: Data, address: Address?) throws -> Data

    /// Signs a transaction
    ///
    /// - Parameter transaction: transaction to sign
    /// - Returns: signed transaction
    /// - Throws: implementations can throw any error to indicate failure
    func signTransaction(_ transaction: Transaction) throws -> Transaction
}
