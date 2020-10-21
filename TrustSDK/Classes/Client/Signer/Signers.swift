// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation
import WalletCore

extension TrustSDK {
    public struct Signers { }
}

public extension TrustSDK.Signers {
    var aeternity: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .aeternity)
    }

    var aion: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .aion)
    }

    var algorand: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .algorand)
    }

    var binance: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .binance)
    }

    var eos: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .eos)
    }

    var filecoin: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .filecoin)
    }

    var fio: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .fio)
    }

    var harmony: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .harmony)
    }

    var icon: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .icon)
    }

    var ioTeX: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .ioTeX)
    }

    var near: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .near)
    }

    var neo: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .neo)
    }

    var nuls: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .nuls)
    }

    var ontology: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .ontology)
    }

    var nano: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .nano)
    }

    var nebulas: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .nebulas)
    }

    var nimiq: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .nimiq)
    }

    var xrp: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .xrp)
    }

    var solana: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .solana)
    }

    var theta: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .theta)
    }

    var tezos: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .tezos)
    }

    var tron: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .tron)
    }

    var veChain: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .veChain)
    }

    var waves: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .waves)
    }

    var zilliqa: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .zilliqa)
    }
}

// Ethereum based chains
public extension TrustSDK.Signers {
    var ethereum: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .ethereum)
    }

    var ethereumClassic: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .ethereumClassic)
    }

    var callisto: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .callisto)
    }

    var goChain: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .goChain)
    }

    var poanetwork: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .poanetwork)
    }

    var tomoChain: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .tomoChain)
    }

    var thunderToken: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .thunderToken)
    }

    var wanchain: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .wanchain)
    }

    var smartChain: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .smartChain)
    }
}

// Cosmos based chains
public extension TrustSDK.Signers {
    var cosmos: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .cosmos)
    }

    var kava: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .kava)
    }

    var terra: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .terra)
    }

    var band: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .bandChain)
    }
}

// Polkador based chains
public extension TrustSDK.Signers {
    var polkadot: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .polkadot)
    }

    var kusama: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .kusama)
    }
}

// Stellar based chains
public extension TrustSDK.Signers {
    var stellar: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .stellar)
    }

    var kin: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .kin)
    }
}

public extension TrustSDK.Signers {
    var elrond: TrustSDK.Signer {
        return TrustSDK.Signer(coin: .elrond)
    }
}
