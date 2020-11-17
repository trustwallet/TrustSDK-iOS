// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import UIKit
import BigInt
import TrustSDK
import CryptoSwift
import WalletCore

class ViewController: UIViewController {
    @IBOutlet weak var signMesageButton: TrustButton!
    @IBOutlet weak var signTransactionButton: TrustButton!
    @IBOutlet weak var payWithTrustButton: TrustButton!
    @IBOutlet weak var getAccountsButton: TrustButton!
    @IBOutlet weak var signSimpleTxButton: UIButton!

    let meta = TrustSDK.SignMetadata.dApp(name: "Test", url: URL(string: "https://dapptest.com"))

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSignTransactionButton()
        setupSignMessageButton()
        setupGetAccountsButton()
        setupPayWithTrustButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupSignMessageButton() {
        let data = Data("Some message".utf8)
        let message = Data("\u{19}Ethereum Signed Message:\n\(data.count)".utf8) + data
        let hash = message.sha3(.keccak256)

        signMesageButton.apply(theme: TrustButtonTheme
            .blue
            .with(styles: .title(.plain("Sign Message")), .icon(.trust), .roundFull)
        )

        signMesageButton.action = .signMessage(hash) { result in
            switch result {
            case .success(let signature):
                let alert = UIAlertController(
                    title: "Signature",
                    message: signature,
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            case .failure(let error):
                print("Failed to sign: \(error)")
            }
        }
    }

    func setupSignTransactionButton() {
        let input = EthereumSigningInput.with {
            $0.toAddress = "0x728B02377230b5df73Aa4E3192E89b6090DD7312"
            $0.chainID = BigInt("1").serialize()!
            $0.nonce = BigInt("477").serialize()!
            $0.gasPrice = BigInt("2112000000").serialize()!
            $0.gasLimit = BigInt("21000").serialize()!
            $0.amount = BigInt("100000000000000").serialize()!
        }

        signTransactionButton.apply(theme: TrustButtonTheme
            .white
            .with(styles: .title(.plain("Sign Transaction")), .icon(.trust))
        )

        signTransactionButton.action = .sign(signer: TrustSDK.signers.ethereum, input: input, metadata: meta) { result in
            switch result {
            case .success(let output):
                let alert = UIAlertController(
                    title: "Transaction",
                    message: output.map({ String(format: "%02x", $0) }).joined(),
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            case .failure(let error):
                print("Failed to sign: \(error)")
            }
        }
    }

    @IBAction func signSimpleEthTx(sender: UIButton) {
        let tx = TrustSDK.Transaction(
            asset: UniversalAssetID(coin: .ethereum),
            to: "0x728B02377230b5df73Aa4E3192E89b6090DD7312",
            amount: "0.01",
            action: .transfer,
            confirm: .sign,
            from: nil,
            nonce: 447,
            feePrice: "2112000000",
            feeLimit: "21000"
        )
        TrustSDK.Signer(coin: .ethereum).sign(tx) { result in
            print(result)
        }
    }

    func setupPayWithTrustButton() {
        let input = EthereumSigningInput.with {
            $0.toAddress = "0x728B02377230b5df73Aa4E3192E89b6090DD7312"
            $0.chainID = BigInt("1").serialize()!
            $0.amount = BigInt("100000000000000").serialize()!
        }

        payWithTrustButton.apply(theme: TrustButtonTheme
            .black
            .with(styles: .title(.payWithTrust(icon: .shieldLined)))
        )

        payWithTrustButton.action = .signThenSend(signer: TrustSDK.signers.ethereum, input: input, metadata: meta) { (result) in
            switch result {
            case .success(let output):
                let alert = UIAlertController(
                    title: "Transaction Hash",
                    message: output,
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            case .failure(let error):
                print("Failed to sign: \(error)")
            }
        }
    }

    func setupGetAccountsButton() {
        getAccountsButton.apply(theme: TrustButtonTheme
            .white
            .with(styles: .title(.plain("Get Accounts")), .icon(.trust), .roundFull)
        )

        getAccountsButton.action = .getAccounts(coins: [.ethereum, .binance]) { result in
            switch result {
            case .success(let addresses):
                let alert = UIAlertController(
                    title: "Address",
                    message: addresses.joined(separator: ", "),
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            case .failure(let error):
                print("Failed to get addresses: \(error)")
            }
        }
    }
}
