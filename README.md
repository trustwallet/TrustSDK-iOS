# TrustSDK

[![Version](https://img.shields.io/cocoapods/v/TrustSDK.svg?style=flat)](https://cocoapods.org/pods/TrustSDK)
[![License](https://img.shields.io/cocoapods/l/TrustSDK.svg?style=flat)](https://cocoapods.org/pods/TrustSDK)
[![Platform](https://img.shields.io/cocoapods/p/TrustSDK.svg?style=flat)](https://cocoapods.org/pods/TrustSDK)

## Getting Started

The TrustSDK lets you sign Ethereum transactions and messages so that you can bulid a native DApp without having to worry about keys or wallets. Follw these instructions to integrate TrustSDK in your native DApp.

## Demo

![Sign Message and Transaction](docs/demo.gif)


## Installation

TrustSDK is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'TrustSDK'
```

Run `pod install`.

## Configuration

Follow the next steps to configure `TrustSDK` in your app.

### Schema Configuration

Open Xcode an click on your project. Go to the 'Info' tab and expand the 'URL Types' group. Click on the **+** button to add a new scheme. Enter a custom scheme name in **'URL Scemes'**.

![Adding a scheme](docs/scheme.png)

### Initialization

Open `AppDelegate.swift` file and initialize TrustSDK in`application(_:didFinishLaunchingWithOptions:)` method:

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    TrustSDK.initialize(with: TrustConfiguration(scheme: "trustexample"))
    return true
}
```

### Handling Callbacks

Let TrustSDK capture deeplink responses by calling TrustSDK in `application(_:open:options:)` method:

```swift
func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
  return TrustSDK.application(app, open: url, options: options)
}
```

## API

To use TrustSDK you have to import `TrustSDK` and `TrustWalletCore` modules.

### Sign Transaction

TrustSDK comes with an easy to use generic API to sign transactions. Each blockchain accept a `SigningInput` object and respond with a `SigningOutput` that can be broadcasted directly to the node. Each input and output object is a Swift implementation of wallet-core's [ protobuf messages](https://github.com/trustwallet/wallet-core/tree/master/src/proto). To sign an Ethereum transaction you have the following `SigningInput`:

```swift
let input = EthereumSigningInput.with {
    $0.toAddress = "0x3D60643Bf82b928602bce34EE426a7d392157b69"
    $0.chainID = BigInt("1").serialize()!
    $0.nonce = BigInt("464").serialize()!
    $0.gasPrice = BigInt("11500000000").serialize()!
    $0.gasLimit = BigInt("21000").serialize()!
    $0.amount = BigInt("1000000000000000").serialize()!
}
```

 > TrustSDK comes with some handy extensions to handle `Data` and `BigInt` serialization with ease.

Once you have the input defined, you just have to call the blockchain signer to sign the transaction:

```swift
TrustSDK.signers.ethereum.sign(input: input) { result in
  switch result {
  case .success(let output):
      // Handle the signing output
  case .failure(let error):
      // Handle failres like user rejections
  }
}
```

### Get Addresses

To get users addresses, you just need to call `getAddress(for:)` directly from `TrustSDK` and pass an array of `CoinType`:

```swift
TrustSDK.getAddress(for: [.ethereum, .bitcoin]) { result in
    switch result {
    case .success(let addresses):
        // Handle the address array
    case .failure(let error):
        // Handle failure
    }
}
```

## Example

Trust SDK includes an example project with the above code. To run the example project clone the repo and run pod install from the `Example` directory. Open `TrustSDK.xcworkspace` and run. Make sure that you have Trust Wallet installed on the device or simulator to test the full callback flow.

## Author

* Leone Parise
* Viktor Radchenko

## License

TrustSDK is available under the MIT license. See the LICENSE file for more info.
