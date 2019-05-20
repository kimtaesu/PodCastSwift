# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
platform :ios, '10.0'
inhibit_all_warnings!

target 'PodCastSwift' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'SwiftLint', '~> 0.27'
  pod 'Then', '~> 2.4.0'
  pod 'SwiftGen'
  pod 'Crashlytics'
  pod 'RxSwift',    '~> 4.0'
  pod 'RxCocoa',    '~> 4.0'
  pod 'ReactorKit'
  pod 'Moya', '~> 13.0'
  pod 'Moya/RxSwift', '~> 13.0'
  pod 'Moya/ReactiveSwift', '~> 13.0'
  pod 'RxDataSources', '~> 3.0'
  pod 'RxOptional'
  # Pods for PodCastSwift
  def testing_pods
  pod 'Quick', '~> 1.3'
  pod 'Nimble', '~> 7.3'
  pod 'RxExpect'
  pod 'RxBlocking', '~> 4.0'
  pod 'RxTest', '~> 4.0'
end
  target 'PodCastSwiftTests' do
    inherit! :search_paths
    testing_pods
    # Pods for testing
  end

end
