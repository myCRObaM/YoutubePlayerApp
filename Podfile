# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'
use_frameworks!

workspace 'YoutubeVideoPlayer'

def pods
  pod "youtube-ios-player-helper"
  pod 'Alamofire'
  pod 'RealmSwift'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Kingfisher'
end

def testing_pods
  pod 'Quick'
  pod 'Nimble'
  pod 'Cuckoo'
  pod 'RxTest'
end

target 'YoutubeVideoPlayer' do
  pods
  target 'YoutubeVideoPlayerTests' do
    testing_pods
  end
end

target 'YoutubeSingleVideo' do
  project 'YoutubeSingleVideo/YoutubeSingleVideo.project'
  pods
  target 'YoutubeSingleVideoTests' do
    testing_pods
  end
end


