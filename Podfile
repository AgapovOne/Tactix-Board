# Uncomment this line to define a global platform for your project
platform :ios, '9.0'
use_frameworks!

target 'TactixBoard' do

  pod 'ChameleonFramework/Swift', :git => 'https://github.com/ViccAlexander/Chameleon.git', :branch => 'swift3'
  pod 'SnapKit', '~> 3.0.2'

  pod 'RealmSwift'

  pod 'Fabric'
  pod 'Crashlytics'

end

target 'TactixBoardTests' do

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
