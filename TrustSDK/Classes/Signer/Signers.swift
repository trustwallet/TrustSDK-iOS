//  Copyright © 2018 Trust.
//
//	This file is part of TrustSDK. The full TrustSDK copyright notice, including
//	terms governing use, modification, and redistribution, is contained in the
//	file LICENSE at the root of the source code distribution tree.
	

import Foundation
import TrustWalletCore

public struct Signers {
    public var aeternity: Signer<AeternitySigningOutput> {
        return Signer(coin: .aeternity)
    }
    
    public var aion: Signer<AionSigningOutput> {
        return Signer(coin: .aion)
    }
    
    public var algorand: Signer<AlgorandSigningOutput> {
        return Signer(coin: .algorand)
    }
    
    public var eos: Signer<EOSSigningOutput> {
        return Signer(coin: .eos)
    }
    
    public var filecoin: Signer<FilecoinSigningOutput> {
        return Signer(coin: .filecoin)
    }
    
    public var fio: Signer<FIOSigningOutput> {
        return Signer(coin: .fio)
    }
    
    public var harmony: Signer<HarmonySigningOutput> {
        return Signer(coin: .harmony)
    }
    
    public var icon: Signer<IconSigningOutput> {
        return Signer(coin: .icon)
    }
    
    public var ioTeX: Signer<IoTeXSigningOutput> {
        return Signer(coin: .ioTeX)
    }
    
    public var near: Signer<NEARSigningOutput> {
        return Signer(coin: .near)
    }
    
    public var neo: Signer<NEOSigningOutput> {
        return Signer(coin: .neo)
    }
        
    public var nuls: Signer<NULSSigningOutput> {
        return Signer(coin: .nuls)
    }
    
    public var nano: Signer<NanoSigningOutput> {
        return Signer(coin: .nano)
    }
    
    public var nebulas: Signer<NebulasSigningOutput> {
        return Signer(coin: .nebulas)
    }
    
    public var nimiq: Signer<NimiqSigningOutput> {
        return Signer(coin: .nimiq)
    }
    
    public var ontology: Signer<OntologySigningOutput> {
        return Signer(coin: .ontology)
    }
    
    public var xrp: Signer<RippleSigningOutput> {
        return Signer(coin: .xrp)
    }
    
    public var solana: Signer<SolanaSigningOutput> {
        return Signer(coin: .solana)
    }
    
    public var theta: Signer<ThetaSigningOutput> {
        return Signer(coin: .theta)
    }
    
    public var tezos: Signer<TezosSigningOutput> {
        return Signer(coin: .tezos)
    }
    
    public var tron: Signer<TronSigningOutput> {
        return Signer(coin: .tron)
    }
    
    public var veChain: Signer<VeChainSigningOutput> {
        return Signer(coin: .veChain)
    }
    
    public var waves: Signer<WavesSigningOutput> {
        return Signer(coin: .waves)
    }
    
    public var zilliqa: Signer<ZilliqaSigningOutput> {
        return Signer(coin: .zilliqa)
    }
}

// Bitcoin based chains
public extension Signers {
    var bitcoin: Signer<BitcoinSigningOutput> {
        return Signer(coin: .bitcoin)
    }
    
    var bitcoinCash: Signer<BitcoinSigningOutput> {
        return Signer(coin: .bitcoinCash)
    }
    
    var dash: Signer<BitcoinSigningOutput> {
        return Signer(coin: .dash)
    }
    
    var decred: Signer<BitcoinSigningOutput> {
        return Signer(coin: .decred)
    }
    
    var digiByte: Signer<BitcoinSigningOutput> {
        return Signer(coin: .digiByte)
    }
    
    var dogecoin: Signer<BitcoinSigningOutput> {
        return Signer(coin: .dogecoin)
    }
    
    var groestlcoin: Signer<BitcoinSigningOutput> {
        return Signer(coin: .groestlcoin)
    }
    
    var litecoin: Signer<BitcoinSigningOutput> {
        return Signer(coin: .litecoin)
    }
    
    var monacoin: Signer<BitcoinSigningOutput> {
        return Signer(coin: .monacoin)
    }
    
    var qtum: Signer<BitcoinSigningOutput> {
        return Signer(coin: .qtum)
    }
    
    var ravencoin: Signer<BitcoinSigningOutput> {
        return Signer(coin: .ravencoin)
    }
    
    var viacoin: Signer<BitcoinSigningOutput> {
        return Signer(coin: .viacoin)
    }
    
    var zcoin: Signer<BitcoinSigningOutput> {
        return Signer(coin: .zcoin)
    }
    
    var zcash: Signer<BitcoinSigningOutput> {
        return Signer(coin: .zcash)
    }
    
    var zelcash: Signer<BitcoinSigningOutput> {
        return Signer(coin: .zelcash)
    }
}

// Ethereum based chains
public extension Signers {
    var ethereum: Signer<EthereumSigningOutput> {
        return Signer(coin: .ethereum)
    }
    
    var ethereumClassic: Signer<EthereumSigningOutput> {
        return Signer(coin: .ethereumClassic)
    }
    
    var callisto: Signer<EthereumSigningOutput> {
        return Signer(coin: .callisto)
    }
    
    var goChain: Signer<EthereumSigningOutput> {
        return Signer(coin: .goChain)
    }
    
    var poanetwork: Signer<EthereumSigningOutput> {
        return Signer(coin: .poanetwork)
    }
    
    var tomoChain: Signer<EthereumSigningOutput> {
        return Signer(coin: .tomoChain)
    }
    
    var thunderToken: Signer<EthereumSigningOutput> {
        return Signer(coin: .thunderToken)
    }
    
    var wanchain: Signer<EthereumSigningOutput> {
        return Signer(coin: .wanchain)
    }
}

// Cosmos based chains
public extension Signers {
    var cosmos: Signer<CosmosSigningOutput> {
        return Signer(coin: .cosmos)
    }
    
    var kava: Signer<CosmosSigningOutput> {
        return Signer(coin: .kava)
    }
    
    var terra: Signer<CosmosSigningOutput> {
        return Signer(coin: .terra)
    }
}

// Polkador based chains
public extension Signers {
    var polkadot: Signer<PolkadotSigningOutput> {
        return Signer(coin: .polkadot)
    }
    
    var kusama: Signer<PolkadotSigningOutput> {
        return Signer(coin: .kusama)
    }
}

// Stellar based chains
public extension Signers {
    var stellar: Signer<StellarSigningOutput> {
        return Signer(coin: .stellar)
    }
    
    var kin: Signer<StellarSigningOutput> {
        return Signer(coin: .kin)
    }
}
