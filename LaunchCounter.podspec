#
# Be sure to run `pod lib lint LaunchCounter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LaunchCounter'
  s.version          = '0.1.0'
  s.summary          = 'Keep track of the number of times an app was launched. '

  s.description      = <<-DESC
  Add a call to this class on app launch to increment the app launch count. Query it to find out if it's the first launch or get the specific number of launches.
                       DESC

  s.homepage         = 'https://github.com/megatron1000/LaunchCounter'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'megatron1000' => 'mark@bridgetech.io' }
  s.source           = { :git => 'https://github.com/megatron1000/LaunchCounter.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/MarkBridgesApps'

  s.platforms = { :ios => "8.0", :osx => "10.9", :watchos => "2.0", :tvos => "9.0" }

  s.source_files = 'LaunchCounter/Classes/**/*'
  s.swift_version = '4.1'


  # s.resource_bundles = {
  #   'LaunchCounter' => ['LaunchCounter/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'Cocoa'
  # s.dependency 'AFNetworking', '~> 2.3'
  
end
