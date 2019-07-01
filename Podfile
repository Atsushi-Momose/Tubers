# Uncomment the next line to define a global platform for your project
# platform :ios, '12.0'

target 'Tubers' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
   pod "Alamofire"
   pod "XLPagerTabStrip"
   pod 'R.swift'
   pod 'RxSwift'#,    '~> 4.1.1'
   pod 'RxCocoa'#,    '~> 4.1.1'
   pod 'Kingfisher'
   pod "youtube-ios-player-helper", "~> 0.1.4"
   pod 'RealmSwift'

  # Pods for Tubers

  target 'TubersTests' do
   pod 'RxSwift',    '~> 4.1.1'
   pod 'RxCocoa',    '~> 4.1.1'
    inherit! :search_paths
    # Pods for testing
  end

  target 'TubersUITests' do
    inherit! :search_paths
    # Pods for testing
  end

plugin 'cocoapods-keys', {
  :project => "Tubers",
  :keys => [
    "youtubeAPIKey"
  ]}

end
