# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def installPods
  pod 'Swinject'
  pod 'SwinjectAutoregistration'
  pod 'PureLayout'
  pod 'SwiftLint'
end

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
