//
//  ViewController.swift
//  TrustSDK
//
//  Created by Leone Parise on 02/18/2020.
//  Copyright (c) 2020 Leone Parise. All rights reserved.
//

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
            $0.toAddress = "0x3D60643Bf82b928602bce34EE426a7d392157b69"
            $0.chainID = BigInt("1").serialize()!
            $0.nonce = BigInt("464").serialize()!
            $0.gasPrice = BigInt("11500000000").serialize()!
            $0.gasLimit = BigInt("21000").serialize()!
            $0.amount = BigInt("1000000000000000").serialize()!
        }
        
        TrustSDK.signers.ethereum.sign(input: input) { result in
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
        TrustSDK.getAddress(for: [.ethereum, .bitcoin]) { result in
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

