// Copyright DApps Platform Inc. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.
	

import Foundation
import TrustWalletCore

public struct SigningOutputDecoder {
    private init() { }
    
    static func decode(data: Data, for coin: CoinType) throws -> SigningOutput {
        switch coin {
        case .aeternity:
            return try AeternitySigningOutput(serializedData: data)
        case .aion:
            return try AionSigningOutput(serializedData: data)
        case .algorand:
            return try AlgorandSigningOutput(serializedData: data)
        case .binance:
            return try BinanceSigningOutput(serializedData: data)
        case .bitcoin,
             .bitcoinCash,
             .dash,
             .decred,
             .digiByte,
             .dogecoin,
             .groestlcoin,
             .litecoin,
             .monacoin,
             .qtum,
             .ravencoin,
             .viacoin,
             .zcoin,
             .zcash,
             .zelcash:
            return try BitcoinSigningOutput(serializedData: data)
        case .ethereum,
             .ethereumClassic,
             .callisto,
             .goChain,
             .poanetwork,
             .tomoChain,
             .thunderToken,
             .wanchain:
            return try EthereumSigningOutput(serializedData: data)
        case .cosmos,
             .kava,
             .terra:
            return try CosmosSigningOutput(serializedData: data)
        case .eos:
            return try EOSSigningOutput(serializedData: data)
        case .filecoin:
            return try FilecoinSigningOutput(serializedData: data)
        case .fio:
            return try FIOSigningOutput(serializedData: data)
        case .harmony:
            return try HarmonySigningOutput(serializedData: data)
        case .icon:
            return try IconSigningOutput(serializedData: data)
        case .ioTeX:
            return try IoTeXSigningOutput(serializedData: data)
        case .near:
            return try NEARSigningOutput(serializedData: data)
        case .neo:
            return try NEOSigningOutput(serializedData: data)
        case .nuls:
            return try NULSSigningOutput(serializedData: data)
        case .nano:
            return try NanoSigningOutput(serializedData: data)
        case .nebulas:
            return try NebulasSigningOutput(serializedData: data)
        case .nimiq:
            return try NimiqSigningOutput(serializedData: data)
        case .ontology:
            return try OntologySigningOutput(serializedData: data)
        case .polkadot,
             .kusama:
            return try PolkadotSigningOutput(serializedData: data)
        case .xrp:
            return try RippleSigningOutput(serializedData: data)
        case .solana:
            return try SolanaSigningOutput(serializedData: data)
        case .stellar,
             .kin:
            return try StellarSigningOutput(serializedData: data)
        case .theta:
            return try ThetaSigningOutput(serializedData: data)
        case .tezos:
            return try TezosSigningOutput(serializedData: data)
        case .tron:
            return try TronSigningOutput(serializedData: data)
        case .veChain:
            return try VeChainSigningOutput(serializedData: data)
        case .waves:
            return try WavesSigningOutput(serializedData: data)
        case .zilliqa:
            return try ZilliqaSigningOutput(serializedData: data)
        case .cardano,
             .ton:
            throw TrustSDKError.coinNotSupported
        }
    }
}
