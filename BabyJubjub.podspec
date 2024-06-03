#
# Be sure to run `pod lib lint BabyJubjub.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BabyJubjub'
  s.version          = '0.0.1-alpha.1'
  s.summary          = 'Swift wrapper for the Baby Jubjub library.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This library is Swift wrapper for [Baby Jubjub](https://docs.iden3.io/publications/pdfs/Baby-Jubjub.pdf). 
It enables the creation of a public key from a Baby Jubjub private key and supports Poseidon hashing.
                       DESC

  s.homepage         = 'https://github.com/jrl351/BabyJubjub.git'
  s.license          = { :type => 'GNU', :file => 'COPYING' }
  s.author           = { 'Justin LeBlanc' => 'jleblanc@polygon.technology' }
  s.source           = { :git => 'https://github.com/jrl351/BabyJubjub.git', :tag => s.version.to_s }

  s.ios.deployment_target = '14.0'

  s.swift_versions = ['5']

  s.pod_target_xcconfig = {
    'ONLY_ACTIVE_ARCH' => 'YES',
    'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES'
  }
  s.user_target_xcconfig = {
    'ONLY_ACTIVE_ARCH' => 'YES',
    'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES'
  }

  s.subspec 'BabyJubjubBridge' do |babyjubjubbridge|
    babyjubjubbridge.source_files = 'Sources/Bridge/**/*'
    babyjubjubbridge.vendored_frameworks = "BabyJubjub.xcframework"
    babyjubjubbridge.ios.vendored_frameworks = "BabyJubjub.xcframework"
  end

  s.subspec 'BabyJubjub' do |babyjubjub|
    babyjubjub.source_files = 'Sources/BabyJubjub/**/*'
    babyjubjub.dependency 'BabyJubjub/BabyJubjubBridge'
    babyjubjub.ios.dependency 'BabyJubjub/BabyJubjubBridge'
  end

  s.default_subspec = 'BabyJubjub'
end

