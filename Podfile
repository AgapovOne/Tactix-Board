platform :ios, '9.0'
use_frameworks!

target 'TactixBoard' do

  pod 'ChameleonFramework/Swift', :git => 'https://github.com/ViccAlexander/Chameleon.git'
  pod 'SnapKit'
  pod 'SwiftyAttributes'
  #pod 'StatusBarNotificationCenter', :git => 'https://github.com/36Kr-Mobile/StatusBarNotificationCenter.git'
  pod 'PopupDialog'

  pod 'RealmSwift'

  pod 'Fabric'
  pod 'Crashlytics'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
