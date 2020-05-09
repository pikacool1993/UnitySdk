#
# Be sure to run `pod lib lint UnitySdk.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UnitySdk'
  s.version          = '0.0.2.5'
  s.summary          = 'Unity Game SDK'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/pikacool1993/UnitySdk'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'pikacool1993' => 'wanglei@palmax.cn' }
  s.source           = { :git => 'https://github.com/pikacool1993/UnitySdk.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'UnitySdk/Classes/**/*'
  
  # s.resource_bundles = {
  #   'UnitySdk' => ['UnitySdk/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.static_framework = true
  s.dependency 'SAMKeychain'
  
  s.dependency 'UMCCommon'
  s.dependency 'UMCAnalytics'
  s.dependency 'UMCCommonLog'
end
