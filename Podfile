# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'luckrental' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for luckrental
  
  pod 'Masonry', '1.1.0'
  pod 'AFNetworking', '4.0.1'
  pod 'FMDB','2.7.5'
  pod 'GCDWebServer/Core','3.5.2'
  pod 'GCDWebServer/WebDAV','3.5.2'
  pod 'GCDWebServer/WebUploader','3.5.2'
  pod 'ZXingObjC', '3.6.5'
  pod 'MBProgressHUD', '1.1.0'
  pod 'SSZipArchive', '2.2.2'
  pod 'SDWebImage', '5.0.6'
  pod 'Bugly', '2.5.93'
  pod 'UMCCommon', '7.3.7'
  pod 'DQAlertView', '1.3.0'
  pod 'MMWormhole', '~> 2.0.0'
  pod 'MJRefresh'
  pod 'MJExtension'
  pod 'Toast', '~> 4.0.0'
  pod 'SDCycleScrollView','>= 1.82'
  pod 'BRPickerView'
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = ‘9.0’
      end
    end
  end

  end
