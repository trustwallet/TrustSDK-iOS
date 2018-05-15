// Copyright © 2018 Trust.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.

import BigInt
import TrustCore
import TrustSDK
import UIKit

class ViewController: UIViewController {
    var trustSDK: TrustSDK!

    @IBOutlet private weak var addressTextField: UITextField!
    @IBOutlet private weak var amountTextField: UITextField!
    @IBOutlet private weak var messageTextField: UITextField!

    @IBAction func signTransaction(_ sender: Any) {
        guard let address = Address(eip55: addressTextField.text!) else {
            let alert = UIAlertController(title: "Invalid Address", message: nil, preferredStyle: .alert)
            alert.addAction(.init(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        guard let amount = BigInt(amountTextField.text!) else {
            let alert = UIAlertController(title: "Invalid Amount", message: nil, preferredStyle: .alert)
            alert.addAction(.init(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        var transaction = Transaction(gasPrice: BigInt(21), gasLimit: 21000, to: address)
        transaction.amount = amount

        trustSDK.signTransaction(transaction) { [weak self] signedTransaction in
            let alert = UIAlertController(title: "Signed Transaction", message: nil, preferredStyle: .alert)
            alert.addAction(.init(title: "OK", style: .default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
    }

    @IBAction func signMessage(_ sender: Any) {
        guard let message = Data(hexString: messageTextField.text!) else {
            let alert = UIAlertController(title: "Invalid Message", message: nil, preferredStyle: .alert)
            alert.addAction(.init(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        trustSDK.signMessage(message) { [weak self] signed in
            let alert = UIAlertController(title: "Signed Message", message: signed.hexString, preferredStyle: .alert)
            self?.present(alert, animated: true, completion: nil)
        }
    }
}

