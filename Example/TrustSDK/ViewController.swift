// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import UIKit
import BigInt
import TrustSDK
import CryptoSwift
import TrustWalletCore

class ViewController: UIViewController {
    @IBOutlet var signButton: TrustButton!
    @IBOutlet var signButton1: TrustButton!
    @IBOutlet var signButton2: TrustButton!

    let meta = TrustSDK.SignMetadata.dApp(name: "Test", url: URL(string: "https://dapptest.com"))

    override func viewDidLoad() {
        super.viewDidLoad()
        signButton.apply(theme: TrustButtonTheme
            .blue
            .with(styles: .title(font: .systemFont(ofSize: 18, weight: .regular), icon: .trust))
        )
        signButton1.apply(theme: TrustButtonTheme
            .white
            .with(styles: .title(font: .systemFont(ofSize: 18, weight: .regular), icon: .shieldFilled))
        )
        signButton2.apply(theme: TrustButtonTheme
            .black
            .with(styles: .title(font: .systemFont(ofSize: 18, weight: .regular), icon: .shieldLined))
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signEthereumTx(_ sender: UIButton) {
        let input = EthereumSigningInput.with {
            $0.toAddress = "0x728B02377230b5df73Aa4E3192E89b6090DD7312"
            $0.chainID = BigInt("1").serialize()!
            $0.nonce = BigInt("477").serialize()!
            $0.gasPrice = BigInt("2112000000").serialize()!
            $0.gasLimit = BigInt("21000").serialize()!
            $0.amount = BigInt("100000000000000").serialize()!
        }
        
        TrustSDK.signers.ethereum.sign(input: input, metadata: meta) { result in
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

    @IBAction func signEthereumMessage(_ sender: UIButton) {
        let data = Data("Some message".utf8)
        let message = Data("\u{19}Ethereum Signed Message:\n\(data.count)".utf8)
        let hash = message.sha3(.keccak256)
        TrustSDK.signers.ethereum.sign(message: hash) { result in
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

    @IBAction func signThenSendEthereum(_ sender: UIButton) {
        let input = EthereumSigningInput.with {
            $0.toAddress = "0x728B02377230b5df73Aa4E3192E89b6090DD7312"
            $0.chainID = BigInt("1").serialize()!
            $0.amount = BigInt("100000000000000").serialize()!
        }
        
        TrustSDK.signers.ethereum.signThenSend(input: input, metadata: meta) { result in
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

    @IBAction func getAddress(_ sender: UIButton) {
        TrustSDK.getAccounts(for: [.ethereum, .binance]) { result in
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
