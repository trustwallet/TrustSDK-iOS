platform :ios, '10.0'
use_frameworks!

target 'TrustSDK' do
  pod 'TrustCore', :git=>'https://github.com/TrustWallet/trust-core', :branch=>'swift-4.2', inhibit_warnings: true
  pod 'Result', '~> 3.0.0'
  pod 'SwiftLint'

  target 'TrustSDKTests'
  target 'TrustWalletSDK'
  target 'TrustWalletSDKTests'
end
