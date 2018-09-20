
Pod::Spec.new do |s|
s.name         = "SHChineseSort"
s.version      = "1.0.0"
s.summary      = "中文排序：支持模型一个、多个键值排序"
s.license      = "MIT"
s.authors      = { "CSH" => "624089195@qq.com" }
s.platform     = :ios, "7.0"
s.homepage     = "https://github.com/CCSH/SHChineseSort"
s.source       = { :git => "https://github.com/CCSH/SHChineseSort.git", :tag => s.version }
s.source_files = "SHChineseSort/*.{h,m}"
s.requires_arc = true
s.dependency    "MJExtension"
end
