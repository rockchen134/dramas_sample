# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

def networking_pod
  pod 'ReachabilitySwift', '~> 5.0.0'
  pod 'Alamofire', '~> 5.2.2'
  pod 'Moya', '~> 14.0.0-'
end

def image_pod
  pod 'Kingfisher', '~> 5.15.0'
end

def ui_pod
   pod 'LCNibBridge', '~> 1.3.3'
   pod 'MBProgressHUD'
end

target 'dramas_sample' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!

  # Pods for dramas_sample
  networking_pod
  image_pod
  ui_pod

  target 'dramas_sampleTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'dramas_sampleUITests' do
    # Pods for testing
  end

end
