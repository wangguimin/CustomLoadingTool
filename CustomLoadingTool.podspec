Pod::Spec.new do |s|
  s.name         = "CustomLoadingTool"
  s.version      = "1.0.0"
  s.summary      = "A Library for iOS to use for loading view."
  s.homepage     = "https://github.com/wangguimin/CustomLoadingTool"
  s.license      = "MIT"
  s.author             = { "wangguimin" => "870503894@qq.com" }
  s.source       = { :git => "https://github.com/wangguimin/CustomLoadingTool.git", :tag => "#{s.version}" }
  s.source_files  = "CustomLoadingTool/*.{h,m}"
  s.frameworks   = "Foundation"
  s.platform     = :ios, "8.0"
end
