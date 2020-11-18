// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import Foundation
import WalletCore

public class TrustSDK {
    enum QueryItems: String {
        case id
    }

    public static let signers = Signers()
    internal static var configuration: TrustSDK.Configuration?
    internal static let requestRegistry = RequestRegistry()

    public static func initialize(with configuration: TrustSDK.Configuration) {
        self.configuration = configuration
    }

    public static func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        guard
            let config = configuration,
            let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
            let scheme = components.scheme,
            let host = components.host,
            scheme == config.scheme && host == config.callback
        else {
            return false
        }

        guard let id = components.queryItem(for: QueryItems.id.rawValue)?.value else {
            return false
        }

        requestRegistry.resolve(request: id, with: components)
        return true
    }
}

extension TrustSDK {
    static func send(request: Request) throws {
        guard let config = configuration else {
            throw TrustSDKError.notInitialized
        }

        let id = requestRegistry.register(request: request)
        let command = request.command
        config.walletApp.open(
            command: command.name.rawValue,
            params: command.params.queryItems(),
            app: config.scheme,
            callback: config.callback,
            id: id
        )
    }
}

public extension TrustSDK {
    static func getAccounts(for coins: [CoinType], callback: @escaping ((Result<[String], Error>) -> Void)) {
        do {
            for coin in coins {
                if !isSupported(coin: coin) {
                    callback(.failure(TrustSDKError.coinNotSupported))
                    return
                }
            }

            let command: TrustSDK.Command = .getAccounts(coins: coins)
            try send(request: GetAccountsRequest(command: command, callback: callback))
        } catch {
            callback(.failure(error))
        }
    }
}

public extension TrustSDK {
    static func isSupported(coin: CoinType) -> Bool {
        switch coin {
        case .aeternity,
             .aion,
             .algorand,
             .binance,
             .cosmos,
             .bandChain,
             .kava,
             .terra,
             .ethereum,
             .ethereumClassic,
             .callisto,
             .goChain,
             .poanetwork,
             .smartChain,
             .tomoChain,
             .thunderToken,
             .wanchain,
             .eos,
             .elrond,
             .filecoin,
             .fio,
             .harmony,
             .icon,
             .ioTeX,
             .ontology,
             .near,
             .neo,
             .nuls,
             .nano,
             .nebulas,
             .nimiq,
             .polkadot,
             .kusama,
             .xrp,
             .solana,
             .stellar,
             .kin,
             .theta,
             .tezos,
             .tron,
             .veChain,
             .waves,
             .zilliqa:
            return true
        default:
            return false
        }
    }
}
