#
# Be sure to run `pod lib lint ${POD_NAME}.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |spec|
  
  spec.name             = 'ChindleShareKit'
  
  spec.version          = '1.0.1'
  
  spec.summary          = 'ChindleShareKit for cocoapods'

  spec.homepage            = 'https://github.com/zhuxiaod/ChindleShareKit'
  
  spec.license          =   { :type => 'MIT', :file => 'LICENSE' }
  
  spec.author              = { 'zhuxiaod' => 'zhuxiaod_183202114@qq.com' }
  
  spec.source              = { :git => 'https://github.com/zhuxiaod/ChindleShareKit.git', :tag => spec.version.to_s }
  
  spec.platform = :ios
  
  spec.ios.deployment_target = '11.0'
  
  spec.static_framework = true
  
  spec.frameworks = 'Security', 'SystemConfiguration', 'CoreGraphics', 'CoreTelephony', 'WebKit'

  spec.libraries = 'iconv', 'sqlite3', 'c++', 'z'
  
  spec.source_files = 'ChindleShareKit/**/*'
    
  spec.vendored_library = 'ChindleShareKit/WechatSDK/libWechatOpenSDK.a'
    
  spec.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
    'OTHER_LDFLAGS' => '$(inherited)',
  }

  spec.public_header_files = [
    'ChindleShareKit/**/*.h',
  ]

  spec.framework = 'WebKit'
  
  spec.swift_versions = ['5']
    
  spec.dependency 'TencentOpenApiHub'
  

end
