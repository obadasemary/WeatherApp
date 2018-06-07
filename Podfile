source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '10.0'
use_modular_headers!
inhibit_all_warnings!
def common_pods

    pod 'ReSwift'
    pod 'R.swift'
    pod 'Moya'
    pod 'SwiftyJSON'
    pod 'SwiftLint', :configurations => ['Debug']
    pod 'Firebase/Core'
    pod 'Firebase/Database', '4.0.0'
    pod 'UIColor_Hex_Swift', '~> 4.0.1'
    pod 'Changeable'
    pod 'Kingfisher'
    pod 'DeepLinkKit'
    pod 'PullToRefreshKit'

end

target :'WeatherTest' do
    common_pods
end

target :'WeatherTestTests' do
    common_pods

    # Pods for testing
    pod 'Quick'
    pod 'Nimble', :inhibit_warnings => true
    pod 'SwiftHamcrest'
end






