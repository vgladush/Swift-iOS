#
# Be sure to run `pod lib lint vgladush2018.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'vgladush2018'
  s.version          = '0.1.0'
  s.summary          = 'NO EVALUATION YET NO EVALUATION YET'
  s.swift_version    = '4.0.3'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
NO EVALUATION YET NO EVALUATION YET NO EVALUATION YET NO EVALUATION YET NO EVALUATION YET NO EVALUATION YET NO EVALUATION YET NO EVALUATION YET
                       DESC

  s.homepage         = 'https://github.com/Dude-Rocker/vgladush2018'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Dude-Rocker' => 'vgladush@student.unit.ua' }
  s.source           = { :git => 'https://github.com/Dude-Rocker/vgladush2018.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'vgladush2018/Classes/**/*'
  s.resource = 'vgladush2018/Assets/*'
  
  # s.resource_bundles = {
  #   'vgladush2018' => ['vgladush2018/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'CoreData'
  # s.dependency 'AFNetworking', '~> 2.3'
end
