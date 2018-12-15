Pod::Spec.new do |s|
  s.name         = "SWAutoSizeLabelView"
  s.version      = "1.0.4"
  s.summary      = "ARC and GCD Compatible SWAutoSizeLabelView Class for iOS"
  s.license      = "MIT"
  s.homepage     = "https://github.com/LongShengWen/SWAutoSizeLabelView"
  s.author             = { "LongShengWen" => "1142056181@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/LongShengWen/SWAutoSizeLabelView.git", :tag => "#{s.version}" }
  s.source_files  = "AutoSizeLabelView/*"
  s.dependency 'Masonry'
end
