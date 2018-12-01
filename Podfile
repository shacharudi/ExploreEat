# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def installPods
  pod 'Swinject'
  pod 'SwinjectAutoregistration'
  pod 'PureLayout'
  pod 'SwiftLint'
  pod 'SwiftIcons'
  pod 'HydraAsync'
  pod 'Alamofire'
  pod 'SwiftyJSON'
  pod "RxSwift"
  pod "RxCocoa"
end

Swift4Targets = [
    'SwiftIcons'
]

target 'RestaurantsExplorer' do
  use_frameworks!

  installPods

  target 'RestaurantsExplorerTests' do
    inherit! :search_paths
  end

  target 'RestaurantsExplorerUITests' do
    inherit! :search_paths
  end

end

def versionForPod(targetName)
  if Swift4Targets.include? targetName
      return '4.0'
  else
      return '4.2'
  end  
end


post_install do |installer|
  installer.pods_project.targets.each do |target|
      targetName = target.name
      podVersion = versionForPod(targetName)
      target.build_configurations.each do |config|
          config.build_settings['SWIFT_VERSION'] = podVersion
          config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = "YES"
      end
  end
end