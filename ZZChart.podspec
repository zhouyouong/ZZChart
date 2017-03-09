#
#  Be sure to run `pod spec lint ZZChart.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "ZZChart"
  s.version      = "1.0.0"
  s.summary      = "A short description of ZZChart."

  s.description  = <<-DESC
                   DESC

  s.homepage     = "https://github.com/zhouyouong/ZZChart"
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  s.author             = { "zy" => "zy311311@163.com" }
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/zhouyouong/ZZChart.git", :tag => s.version.to_s }

  s.source_files  = "ZZChart", "ZZChart/**/*.{h,m}"

  s.frameworks = 'Foundation', 'UIKit' 

  s.requires_arc = true

end
