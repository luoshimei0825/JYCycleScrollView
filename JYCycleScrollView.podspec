Pod::Spec.new do |spec|
  spec.name         = "JYCycleScrollView"
  spec.version      = "0.0.2"
  spec.license  = 'MIT'
  spec.summary      = "JYCycleScrollView"
  
  spec.description  = 'A simple and easy-to-use infinite loop image scroll view.'

  spec.homepage     = "https://github.com/luoshimei0825/JYCycleScrollView"

  spec.author       = { "luoshimei" => "452402a033v.me@gmail.com" }

  spec.ios.deployment_target = "8.0"
  spec.ios.frameworks = 'Foundation', 'UIKit'

  spec.source       = { :git => 'https://github.com/luoshimei0825/JYCycleScrollView.git',:branch=>'master', :tag => "v#{spec.version}" }

  # spec.source_files  = "JYCycleScrollView", "JYCycleScrollView/**/*.{h,m}"
  spec.source_files = 'JYCycleScrollView/**/*.{h,m}'

  spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # spec.dependency "JSONKit", "~> 1.4"

end
