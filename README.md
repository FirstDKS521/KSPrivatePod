#iOS开发：创建私有Pod库的步骤（图文）
>开发中，大部分的三方库我们都是通过Cocoapods来管理的，没有别的原因，就是应为管理方便；

>随着项目的扩展，有些功能模块儿可以单独拉出去，封装成framework或者是以源代码的形式管理；也可以让别人通过Cocoapods去拉取我们封装的代码，想想有没有很开森😂

Pod库分私有库、公有库，意思如同名字一样，以下我将说的是私有库的创建，如果需要参考，还请仔细阅读~

####1、创建私有代码仓库

1.1、由于GitHub创建私有仓库是收费的，所以我此处使用 [coding](https://coding.net/)，也可以使用码云或者其他平台

![创建仓库.png](https://upload-images.jianshu.io/upload_images/1840399-e706bb11c5b5dc97.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

1.2、将刚刚创建的库，`clone`到桌面上

```
git clone https://git.coding.net/FirstDKS521/KSPrivatePod.git
```
1.3、在刚刚clone的文件夹中创建一个`KSPrivatePod`文件夹，里面主要存放我们的私有库，此时的文件结构如下：

![文件目录.png](https://upload-images.jianshu.io/upload_images/1840399-26500adadb3a1cff.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

####2、在刚clone的文件下，生成.podspec文件

2.1、在终端执行命令`pod spec create 私有库名字`

```
pod spec create KSPrivatePod
```
创建成功终端会提示`Specification created at KSPrivatePod.podspec`，此时文件夹中会出现`KSPrivatePod.podspec`文件

2.2、打开这个.podspec文件，最终的编辑效果如下：

```
Pod::Spec.new do |s|

  s.name         = "KSPrivatePod"
  #当前的版本号，如果后面需要更新，更改这个
  s.version      = "0.0.1" 
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
```
####3、提交刚刚更改的所有内容
3.1、在刚刚clone的文件夹中，在终端执行如下命令：

```
//第一步：将更改的添加至暂存区不要忘了后面的.
git add .
//第二步：提交文件
git commit -m 'first commit'
//第三步：push文件到仓库
git push origin master
```
3.2、给刚刚提交的文件打tag标签

```
//第一步：tag标签.podspece文件中s.version保持一致
git tag '0.0.1'
//第二步：推送标签
git push --tags
```
####4、检验.podspec文件是否有错
在终端执行如下命令：

```
pod lib lint
```
如果有警告，可以执行如下命令去掉警告

```
pod lib lint --allow-warnings
```
如果里面有ERROR错误，则根据不同的错误去解决

>(1) - -verbose:表示显示全部的日志信息，建议加上这个，方便判断错误信息; 
>
>(2) - -sources:如果我们在podspec里面依赖到一些私有的库之后，直接进行校验是会报错的提示找不到，这里可以加上Spec仓库的地址告诉CocoaPods找不到的时候去哪里找; 
>
>(3) - -allow-warnings:表示允许警告; 
>
>(4) - -use-libraries:表示使用静态库或者是framework，这里主要是解决当我们依赖一些framework库后校验提示找不到库的时候用到

如果没有错误，则终端输出如果下结果：

![image.png](https://upload-images.jianshu.io/upload_images/1840399-2be096da5e7f119d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

####5、创建私有的索引库Spec Repo
5.1、终端执行如下命令

```
//第一步：添加Pod库到本地
pod repo add KSPrivatePod https://git.coding.net/FirstDKS521/KSPrivatePod.git
//第二步：推送Pod库到远端 
pod repo push KSPrivatePod KSPrivatePod.podspec
```
5.2、打开本地cocoapods仓库，验证是否有`KSPrivatePod`库

```
open ~/.cocoapods/repos/
```
可以通过在终端输入以下命令，来验证本地是否有新的库

```
pod repo
```
####6、使用刚刚创建的私有库
6.1、在桌面创建一个KSPrivateExample工程，然后cd到这个工程中执行

```
pod init
```
6.2、此时工程中会出现一个Podfile文件，编辑这个文件，最终的结果如下

```
# Uncomment the next line to define a global platform for your project

#iOS支持最低的版本
platform :ios, '8.0'

#共有的库
source 'https://github.com/CocoaPods/Specs.git'  

target 'KSPrivateExample' do

#git对应的地址就是你创建私有库的地址
pod 'KSView', :git => 'https://git.coding.net/FirstDKS521/KSPrivatePod.git'

end
```
6.3、然后执行`pod install`，此时工程中就出现了一个`.xcworkspace`文件，到此，私有库已完成创建

####7、版本更新维护步骤

7.1、将更新的好的私有库放入到创建的私有文件夹中，然后更新`.podspec`文件的`s.version = '0.0.2'`

7.2、然后cd到私有文件夹中，执行如下命令：

```
git add .
git commit -m '更新版本0.0.2'
git push origin master
git tag '0.0.2'
git push --tags
pod repo push KSPrivatePod KSPrivatePod.podspec
```

过程中主要遇到的问题：

```
1、cocoapods的环境搭建问题，git clone速度太慢，所有有个好点儿的VpiN还是很有必要的
2、出错率最高的就是podspec文件的配置问题，主要就是s.source_filesd的路径问题
```
####注意点：
在工程中的podfile文件中，一定加入下面的，不然在执行`pod install`时，提示`nable to find a specification for 'Masonry‘`错误

```
//共有的库
source 'https://github.com/CocoaPods/Specs.git'
```
原因主要是应为共有库、私有库混用时，找不到共有库的地址，如果工程中没有私有库，则不需要添加上面的代码，执行`pod install`依然会成功

####如果私有库引用了别的私有库，则需要做如下处理

在私有库中引用私有库，即在`Podspec`文件中依赖(dependency)`私有库` 这种情况就比较麻烦一点，因为毕竟Podspec文件中并没有指明私有仓库地址的地方。那么肯定就不在Podspec文件里面指明私有仓库的地方。而是在验证和上传私有库的时候进行指明。即在下面这两条命令中进行指明：

如下是在`KSThirdController`私有库中引入了`KSSecondController`私有库

```
#验证库时使用如下命令
pod lib lint --allow-warnings KSThirdController.podspec --sources=https://gitee.com/FirstDKS521/KSSecondController.git
#上传私有库时使用如下名令
pod repo push KSThirdController KSThirdController.podspec --sources=https://gitee.com/FirstDKS521/KSSecondController.git
```
在工程中使用`KSThirdController`私有库时，也要记得同时引入`KSSecondController`私有库，如下：

```
platform :ios, '8.0'

source 'https://github.com/CocoaPods/Specs.git'  
source 'https://gitee.com/FirstDKS521/KSSecondController.git'
source 'https://gitee.com/FirstDKS521/KSThirdController.git'

target 'KSThirdDemo' do

pod "KSSecondController"
pod "KSThirdController"

end
```

参考文章：[文章一](https://blog.csdn.net/DonnyDN/article/details/79823566)、[文章二](https://blog.csdn.net/DonnyDN/article/details/79823566)、[文章三](http://www.pluto-y.com/cocoapod-private-pods-and-module-manager)
