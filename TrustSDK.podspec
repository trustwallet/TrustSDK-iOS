Pod::Spec.new do |s|
  s.name             = 'TrustSDK'
  s.version          = '0.1.0'
  s.summary          = 'Trust Wallet SDK'
  s.homepage         = 'https://github.com/TrustWallet/TrustSDK-iOS'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.authors          = { 'Leone Parise' => 'leoneparise', 'Viktor Radchenko' => 'vikmeup' }
  s.source           = { :git => 'https://github.com/TrustWallet/TrustSDK-iOS.git', :tag => s.version.to_s }
  s.ios.deployment_target = '11.0'

  s.source_files = 'TrustSDK/Classes/**/*'
  s.dependency 'TrustWalletCore/Types'
  s.dependency 'BigInt'
end
