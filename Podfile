# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def ui_pods
    pod 'SnapKit', '~> 4.0.0'
end

def helper_pods
    pod 'Swinject', '~> 2.1.0'
    pod 'SwinjectStoryboard', '1.1.2'
    pod 'R.swift'
end

def net_pods
	pod 'Moya'
    pod 'Moya/RxSwift'
	pod 'Kingfisher', '~> 4.0'
end

def test_pods
    pod 'Nimble', '~> 7.0.0'
end

target 'GithubGists' do
	# Comment the next line if you're not using Swift and don't want to use dynamic frameworks
	use_frameworks!
	
	# Pods for GithubGists
	ui_pods
	net_pods
    helper_pods
end

target 'GithubGistsTests' do
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!
    
    # Pods for GithubGists
    net_pods
    test_pods
end






