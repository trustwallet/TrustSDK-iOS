Pod::Spec.new do |s|
  s.name         = 'TrustSDK'
  s.version      = '0.0.1'
  s.summary      = 'Trust Consumer SDK.'
  s.homepage     = 'https://github.com/TrustWallet/TrustSDK-iOS'
  s.authors      = { 'Alejandro Isaza' => 'al@isaza.ca', 'Viktor Radchenko' => 'yazexel@gmail.com' }

  s.ios.deployment_target = '10.0'
  s.swift_version = '4.0'

  s.source       = { git: 'https://github.com/TrustWallet/TrustSDK-iOS.git', tag: s.version }
  s.source_files = 'Sources/TrustSDK/**/*.{swift}'

  s.dependency 'TrustCore'
  s.dependency 'Result'
end
