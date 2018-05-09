//
//  ViewController.swift
//  TrustSDK
//
//  Created by Viktor Radchenko on 05/09/2018.
//  Copyright (c) 2018 Viktor Radchenko. All rights reserved.
//

import UIKit
import TrustSDK

class ViewController: UIViewController {

    let trust = TrustSDK()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signTransaction(_ sender: Any) {
        trust.signTransaction(in: self)
    }

    @IBAction func signMessage(_ sender: Any) {
        trust.signMessage(in: self)
    }
}

