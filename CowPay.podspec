
Pod::Spec.new do |spec|


  spec.name         = "CowPay"
  spec.version      = "2.2"
  spec.summary      = "ACOWPAY is a premium payment technology."

  spec.description  = "ACOWPAY is a premium payment technology enabler dedicated to helping businesses transform their operation collecting , splitting , and disbursing money digitally!"

  spec.homepage     = "https://github.com/cowpay/ios_sdk"
  
  spec.license      = "MIT"

  spec.author       = { "mohamed elmaazy" => "mohamed.mostafa.elmaazy@gmail.com" }

  spec.platform     = :ios, "10.0"

  spec.source       = { :git => "https://github.com/cowpay/ios_sdk.git" }

  #spec.source_files  = "CowPay/Frameworks/CowPay.framework"
  spec.vendored_frameworks = 'CowPay/CowPay.framework'


end
