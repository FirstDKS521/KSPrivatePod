Pod::Spec.new do |s|

  s.name         = "KSPrivatePod"
  #当前的版本号，如果后面需要更新，更改这个
  s.version      = "0.0.2" 
  #一个简单的描述
  s.summary      = "一个简单实用的创建边框、圆角的库" 

  #详细的描述
  s.description  = <<-DESC 
             iOS开发：给视图添加圆角、边框
                   DESC

  #项目主页地址
  s.homepage     = "https://git.coding.net/FirstDKS521/KSPrivatePod.git"

  #开源许可证
  s.license      = { :type => "MIT", :file => "LICENSE" }
  #作者名字、邮箱
  s.author             = { "FirstDKS521" => "870815325@qq.com" }
  #支持最低的iOS版本
  s.platform     = :ios, '8.0'

  #仓库的路径，tag对应的是版本号
  s.source       = { :git => "https://git.coding.net/FirstDKS521/KSPrivatePod.git", :branch => "xyz", :tag => s.version.to_s}

  #资源文件路径(**表示匹配所有子目录；*表示匹配所有文件)
  s.source_files  = "KSPrivatePod/*.{h,m}"
  #依赖的库
  s.framework    = 'UIKit'

  #若有依赖的库，要填写s.dependency：
  #s.dependency "JSONKit", "~> 1.4"
  #s.dependency "Masonry", "~> 1.0.0"

end
