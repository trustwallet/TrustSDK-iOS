// Copyright © 2018 Trust.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation
import TrustCore
import BigInt

@objc(TrustSDK)
public extension TrustSDK {
    @objc
    public func signMessage(_ message: Data, address: String? = nil, completion: @escaping (Data) -> Void) {
        guard WalletAppManager.hasWalletApp else {
            return fallbackToInstall()
        }
        let addr = Address(string: address!)
        let command = SignMessageCommand(message: message, address: addr, callbackScheme: callbackScheme, completion: completion)
        execute(command: command)
    }
    @objc
    public func signTransaction(_ gasPrice: String, _ gasLimit: UInt64, _ address: String, amount: String, completion: @escaping (Data) -> Void) {
        guard WalletAppManager.hasWalletApp else {
            return fallbackToInstall()
        }
        let gasP = BigInt(gasPrice)
        let addr = Address(string: address)
        var transaction = Transaction(gasPrice: gasP!, gasLimit: gasLimit, to: addr!)
        let am = BigInt(amount)
        transaction.amount = am!

        let command = SignTransactionCommand(transaction: transaction, callbackScheme: callbackScheme, completion: completion)
        execute(command: command)
    }
    @objc
    public func signPersonalMessage(_ message: Data, address: String? = nil, completion: @escaping (Data) -> Void) {
        guard WalletAppManager.hasWalletApp else {
            return fallbackToInstall()
        }
        let addr = Address(string: address!)
        let command = SignPersonalMessageCommand(message: message, address: addr, callbackScheme: callbackScheme, completion: completion)
        execute(command: command)
    }
}
