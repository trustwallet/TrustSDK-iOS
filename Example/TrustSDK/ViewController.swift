// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import UIKit
import TrustSDK
import BigInt
import TrustWalletCore

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signEthereum(_ sender: UIButton) {
        let input = EthereumSigningInput.with {
            $0.toAddress = "0x728B02377230b5df73Aa4E3192E89b6090DD7312"
            $0.chainID = BigInt("1").serialize()!
            $0.nonce = BigInt("477").serialize()!
            $0.gasPrice = BigInt("2112000000").serialize()!
            $0.gasLimit = BigInt("21000").serialize()!
            $0.amount = BigInt("100000000000000").serialize()!
        }
        
        let meta = TrustSDK.SignMetadata.dApp(name: "Test", url: URL(string: "https://dapptest.com"))
        
        TrustSDK.signers.ethereum.sign(input: input, metadata: meta) { result in
            switch result {
            case .success(let output):
                let alert = UIAlertController(
                    title: "Transaction",
                    message: try? output.jsonString(),
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
