// Copyright Trust Wallet. All rights reserved.
//
// This file is part of TrustSDK. The full TrustSDK copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.
	

import XCTest
@testable import TrustSDK

class DictionaryTests: XCTestCase {
    func testToQueryItems() {
        let dict: [String: Any] = [
            "key1": 0,
            "key2": [
                "key1": false,
                "key2": [
                    "value3",
                    "value4",
                ],
            ],
        ]
        
        XCTAssertEqual([
            URLQueryItem(name: "key1", value: "0"),
            URLQueryItem(name: "key2.key1", value: "false"),
            URLQueryItem(name: "key2.key2.0", value: "value3"),
            URLQueryItem(name: "key2.key2.1", value: "value4"),
        ], dict.queryItems())
    }
    
    func testInitFromQueryItems() {
        let items = [
            URLQueryItem(name: "key1", value: "value1"),
            URLQueryItem(name: "key2.key1", value: "value2"),
            URLQueryItem(name: "key2.key2.0", value: "value3"),
            URLQueryItem(name: "key2.key2.1", value: "value4"),
        ]
        
        let dict = Dictionary(queryItems: items)
        let subdict = dict["key2"] as! [String: Any]
        let subsubdict = subdict["key2"] as! [String: Any]
        
        XCTAssertEqual("value1", dict["key1"] as! String)
        XCTAssertEqual("value2", subdict["key1"] as! String)
        XCTAssertEqual("value3", subsubdict["0"] as! String)
        XCTAssertEqual("value4", subsubdict["1"] as! String)
    }
}
