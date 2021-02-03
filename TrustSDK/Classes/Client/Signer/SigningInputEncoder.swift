// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation
import WalletCore

public struct SigningInputEncoder {
    private init() { }

    public static func encode(data: Data, privateKey: Data, for coin: CoinType) throws -> SigningInput {
        switch coin {
        case .aeternity:
            var input = try AeternitySigningInput(serializedData: data)
            input.privateKey = privateKey
            return input
        case .aion:
            var input = try AionSigningInput(serializedData: data)
            input.privateKey = privateKey
            return input
        case .algorand:
            var input = try AlgorandSigningInput(serializedData: data)
            input.privateKey = privateKey
            return input
        case .binance:
            var input = try BinanceSigningInput(serializedData: data)
            input.privateKey = privateKey
            return input
        case .cosmos,
             .kava,
             .terra,
             .bandChain:
            var input = try CosmosSigningInput(serializedData: data)
            input.privateKey = privateKey
            return input
        case .ethereum,
             .ethereumClassic,
             .callisto,
             .goChain,
             .poanetwork,
             .tomoChain,
             .thunderToken,
             .wanchain,
             .smartChain:
            var input = try EthereumSigningInput(serializedData: data)
            input.privateKey = privateKey
            return input
        case .eos:
            var input = try EOSSigningInput(serializedData: data)
            input.privateKey = privateKey
            return input
        case .filecoin:
            var input = try FilecoinSigningInput(serializedData: data)
            input.privateKey = privateKey
            return input
        case .fio:
            var input = try FIOSigningInput(serializedData: data)
            input.privateKey = privateKey
            return input
        case .harmony:
            var input = try HarmonySigningInput(serializedData: data)
            input.privateKey = privateKey
            return input
        case .icon:
            var input = try IconSigningInput(serializedData: data)
            input.privateKey = privateKey
            return input
        case .ioTeX:
            var input = try IoTeXSigningInput(serializedData: data)
            input.privateKey = privateKey
            return input
        case .near:
            var input = try NEARSigningInput(serializedData: data)
            input.privateKey = privateKey
            return input
        case .neo:
            var input = try NEOSigningInput(serializedData: data)
            input.privateKey = privateKey
            return input
        case .nuls:
            var input = try NULSSigningInput(serializedData: data)
            input.privateKey = privateKey
            return input
        case .nano:
            var input = try NanoSigningInput(serializedData: data)
            input.privateKey = privateKey
            return input
        case .nebulas:
            var input = try NebulasSigningInput(serializedData: data)
            input.privateKey = privateKey
            return input
        case .nimiq:
            var input = try NimiqSigningInput(serializedData: data)
            input.privateKey = privateKey
            return input
        case .polkadot,
             .kusama:
            var input = try PolkadotSigningInput(serializedData: data)
            input.privateKey = privateKey
            return input
        case .xrp:
            var input = try RippleSigningInput(serializedData: data)
            input.privateKey = privateKey
            return input
        case .solana:
            var input = try SolanaSigningInput(serializedData: data)
            input.privateKey = privateKey
            return input
        case .stellar,
             .kin:
            var input = try StellarSigningInput(serializedData: data)
            input.privateKey = privateKey
            return input
        case .theta:
            var input = try ThetaSigningInput(serializedData: data)
            input.privateKey = privateKey
            return input
        case .tezos:
            var input = try TezosSigningInput(serializedData: data)
            input.privateKey = privateKey
            return input
        case .tron:
            var input = try TronSigningInput(serializedData: data)
            input.privateKey = privateKey
            return input
        case .veChain:
            var input = try VeChainSigningInput(serializedData: data)
            input.privateKey = privateKey
            return input
        case .waves:
            var input = try WavesSigningInput(serializedData: data)
            input.privateKey = privateKey
            return input
        case .zilliqa:
            var input = try ZilliqaSigningInput(serializedData: data)
            input.privateKey = privateKey
            return input
        case .ontology:
            var input = try OntologySigningInput(serializedData: data)
            input.payerPrivateKey = privateKey
            input.ownerPrivateKey = privateKey
            return input
        case .elrond:
            var input = try ElrondSigningInput(serializedData: data)
            input.privateKey = privateKey
            return input
        default:
            throw TrustSDKError.coinNotSupported
        }
    }
}
