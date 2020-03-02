// Copyright DApps Platform Inc. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.
	

import Foundation
import TrustWalletCore

extension TrustSDK {
    public struct Signers { }
}

public extension TrustSDK.Signers {
    var aeternity: TrustSDK.Signer<AeternitySigningOutput> {
        return TrustSDK.Signer(coin: .aeternity)
    }
    
    var aion: TrustSDK.Signer<AionSigningOutput> {
        return TrustSDK.Signer(coin: .aion)
    }
    
    var algorand: TrustSDK.Signer<AlgorandSigningOutput> {
        return TrustSDK.Signer(coin: .algorand)
    }
    
    var binance: TrustSDK.Signer<BinanceSigningOutput> {
        return TrustSDK.Signer(coin: .binance)
    }
    
    var eos: TrustSDK.Signer<EOSSigningOutput> {
        return TrustSDK.Signer(coin: .eos)
    }
    
    var filecoin: TrustSDK.Signer<FilecoinSigningOutput> {
        return TrustSDK.Signer(coin: .filecoin)
    }
    
    var fio: TrustSDK.Signer<FIOSigningOutput> {
        return TrustSDK.Signer(coin: .fio)
    }
    
    var harmony: TrustSDK.Signer<HarmonySigningOutput> {
        return TrustSDK.Signer(coin: .harmony)
    }
    
    var icon: TrustSDK.Signer<IconSigningOutput> {
        return TrustSDK.Signer(coin: .icon)
    }
    
    var ioTeX: TrustSDK.Signer<IoTeXSigningOutput> {
        return TrustSDK.Signer(coin: .ioTeX)
    }
    
    var near: TrustSDK.Signer<NEARSigningOutput> {
        return TrustSDK.Signer(coin: .near)
    }
    
    var neo: TrustSDK.Signer<NEOSigningOutput> {
        return TrustSDK.Signer(coin: .neo)
    }
        
    var nuls: TrustSDK.Signer<NULSSigningOutput> {
        return TrustSDK.Signer(coin: .nuls)
    }
    
    var nano: TrustSDK.Signer<NanoSigningOutput> {
        return TrustSDK.Signer(coin: .nano)
    }
    
    var nebulas: TrustSDK.Signer<NebulasSigningOutput> {
        return TrustSDK.Signer(coin: .nebulas)
    }
    
    var nimiq: TrustSDK.Signer<NimiqSigningOutput> {
        return TrustSDK.Signer(coin: .nimiq)
    }
    
    var xrp: TrustSDK.Signer<RippleSigningOutput> {
        return TrustSDK.Signer(coin: .xrp)
    }
    
    var solana: TrustSDK.Signer<SolanaSigningOutput> {
        return TrustSDK.Signer(coin: .solana)
    }
    
    var theta: TrustSDK.Signer<ThetaSigningOutput> {
        return TrustSDK.Signer(coin: .theta)
    }
    
    var tezos: TrustSDK.Signer<TezosSigningOutput> {
        return TrustSDK.Signer(coin: .tezos)
    }
    
    var tron: TrustSDK.Signer<TronSigningOutput> {
        return TrustSDK.Signer(coin: .tron)
    }
    
    var veChain: TrustSDK.Signer<VeChainSigningOutput> {
        return TrustSDK.Signer(coin: .veChain)
    }
    
    var waves: TrustSDK.Signer<WavesSigningOutput> {
        return TrustSDK.Signer(coin: .waves)
    }
    
    var zilliqa: TrustSDK.Signer<ZilliqaSigningOutput> {
        return TrustSDK.Signer(coin: .zilliqa)
    }
}

// Ethereum based chains
public extension TrustSDK.Signers {
    var ethereum: TrustSDK.Signer<EthereumSigningOutput> {
        return TrustSDK.Signer(coin: .ethereum)
    }
    
    var ethereumClassic: TrustSDK.Signer<EthereumSigningOutput> {
        return TrustSDK.Signer(coin: .ethereumClassic)
    }
    
    var callisto: TrustSDK.Signer<EthereumSigningOutput> {
        return TrustSDK.Signer(coin: .callisto)
    }
    
    var goChain: TrustSDK.Signer<EthereumSigningOutput> {
        return TrustSDK.Signer(coin: .goChain)
    }
    
    var poanetwork: TrustSDK.Signer<EthereumSigningOutput> {
        return TrustSDK.Signer(coin: .poanetwork)
    }
    
    var tomoChain: TrustSDK.Signer<EthereumSigningOutput> {
        return TrustSDK.Signer(coin: .tomoChain)
    }
    
    var thunderToken: TrustSDK.Signer<EthereumSigningOutput> {
        return TrustSDK.Signer(coin: .thunderToken)
    }
    
    var wanchain: TrustSDK.Signer<EthereumSigningOutput> {
        return TrustSDK.Signer(coin: .wanchain)
    }
}

// Cosmos based chains
public extension TrustSDK.Signers {
    var cosmos: TrustSDK.Signer<CosmosSigningOutput> {
        return TrustSDK.Signer(coin: .cosmos)
    }
    
    var kava: TrustSDK.Signer<CosmosSigningOutput> {
        return TrustSDK.Signer(coin: .kava)
    }
    
    var terra: TrustSDK.Signer<CosmosSigningOutput> {
        return TrustSDK.Signer(coin: .terra)
    }
}

// Polkador based chains
public extension TrustSDK.Signers {
    var polkadot: TrustSDK.Signer<PolkadotSigningOutput> {
        return TrustSDK.Signer(coin: .polkadot)
    }
    
    var kusama: TrustSDK.Signer<PolkadotSigningOutput> {
        return TrustSDK.Signer(coin: .kusama)
    }
}

// Stellar based chains
public extension TrustSDK.Signers {
    var stellar: TrustSDK.Signer<StellarSigningOutput> {
        return TrustSDK.Signer(coin: .stellar)
    }
    
    var kin: TrustSDK.Signer<StellarSigningOutput> {
        return TrustSDK.Signer(coin: .kin)
    }
}
