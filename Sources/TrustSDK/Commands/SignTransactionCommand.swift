// Copyright © 2018 Trust.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import BigInt
import TrustCore

public final class SignTransactionCommand: Command {
    public let name = "sign-transaction"

    /// Transaction to sign
    public var transaction: Transaction

    /// Completion closure
    public var completion: (Data) -> Void

    /// Callback scheme
    public var callbackScheme: String

    public var callback: URL {
        var components = URLComponents()
        components.scheme = callbackScheme
        components.host = name
        return components.url!
    }

    public init(transaction: Transaction, callbackScheme: String, completion: @escaping (Data) -> Void) {
        self.transaction = transaction
        self.completion = completion
        self.callbackScheme = callbackScheme
    }

    public func requestURL(scheme: String) -> URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = name
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "gasPrice", value: transaction.gasPrice.description))
        queryItems.append(URLQueryItem(name: "gasLimit", value: transaction.gasLimit.description))
        queryItems.append(URLQueryItem(name: "to", value: transaction.to.description))
        queryItems.append(URLQueryItem(name: "amount", value: transaction.amount.description))
        if let payload = transaction.payload {
            queryItems.append(URLQueryItem(name: "data", value: payload.base64EncodedString()))
        }
        queryItems.append(URLQueryItem(name: "nonce", value: transaction.nonce.description))
        queryItems.append(URLQueryItem(name: "callback", value: callback.absoluteString))
        components.queryItems = queryItems
        return components.url!
    }

    public func handleCallback(url: URL) -> Bool {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false), components.host == name else {
            return false
        }
        guard let result = components.queryItems?.first(where: { $0.name == "result" })?.value else {
            return false
        }
        guard let data = Data(base64Encoded: result) else {
            return false
        }

//        guard let vs = components.queryItems?.first(where: { $0.name == "v" })?.value, let v = BigInt(vs) else {
//            return false
//        }
//        guard let rs = components.queryItems?.first(where: { $0.name == "r" })?.value, let r = BigInt(rs) else {
//            return false
//        }
//        guard let ss = components.queryItems?.first(where: { $0.name == "s" })?.value, let s = BigInt(ss) else {
//            return false
//        }
//
//        transaction.v = v
//        transaction.r = r
//        transaction.s = s
//        if let nonce = components.queryItems?.first(where: { $0.name == "v" })?.value, let val = UInt64(nonce) {
//            transaction.nonce = val
//        }

        completion(data)
        return true
    }
}

public extension TrustSDK {
    public func signTransaction(_ transaction: Transaction, completion: @escaping (Data) -> Void) {
        guard WalletAppManager.hasWalletApp else {
            return fallbackToInstall()
        }
        let command = SignTransactionCommand(transaction: transaction, callbackScheme: callbackScheme, completion: completion)
        execute(command: command)
    }
}
