ENV['SWIFT_VERSION'] = '4'
platform :ios, '11.0'
use_frameworks!
inhibit_all_warnings!
source 'https://github.com/CocoaPods/Specs.git'

def shared_pods
  
  pod 'MultithreadingKnowledge',:git => 'https://github.com/Andrew5/MultithreadingKnowledge.git' #,:path => '../MultithreadingKnowledge'
  pod 'BlockKnowledge',:git => 'https://github.com/Andrew5/BlockKnowledge.git'#, :path => '../BlockKnowledge'
  pod 'DHBasicKnowledge',:git => 'https://github.com/Andrew5/BlockKnowledge.git'#, :path => '../DHBasicKnowledge'

  #  pod 'SwiftDemo',:path => '../SwiftDemo'
  #  pod 'WaterMarkAssemble',:path => '../WaterMarkAssemble'
  pod 'GlobalButtonSwift'#,:git => 'https://github.com/Andrew5/GlobalButtonSwift.git'
  pod 'GlobalButton'#,:path => '../GlobalButton',:subspecs => ['complex']
  pod 'MyPodTestPro'#,:path => '../MyPodTestPro',:subspecs => ['Pro'] #:configurations => ['Pro']#:podspec => 'https://example.com/JSONKit.podspec'
#  pod 'MyPodTestPro/Pro',:path => '../MyPodTestPro'
  pod 'MVVMTableViewDemo'#,:path => '../MVVMTableViewDemo'
  
  pod 'MyHelloWord',      :path => '../MyHelloWord'
  pod 'LearnRAC',         :path => '../LearnRAC'
  pod 'IMChatKeyboards',  :path => '../IMChatKeyboards'
  pod 'MVPGrowthModel',   :path => '../MVPGrowthModel'
  pod 'CustomerScroller', :path => '../CustomerScroller'
  pod 'CategoryRelyon',   :path => '../CategoryRelyon'
  pod 'DHUIKitModule',    :path => '../DHUIKitModule'
  pod 'TouchBut',         :path => '../TouchBut'
  pod 'FliqloClick',      :path => '../FliqloClick'
  pod 'DHTabBar',         :path => '../DHTabBar'
  #待修复
  pod 'RHScan',           :path => '../RHScan'
  pod 'QRCode',           :path => '../QRCode'
  pod 'VTAntiScreenCapture',:path => '../VTAntiScreenCapture'
end

def commonlyUsed
  # 内存
  # pod 'AMLeaksFinder',            :git => 'https://github.com/liangdahong/AMLeaksFinder.git', :tag => '2.1.3',:branch => 'Debug'
  # 腾讯内存管理
  # pod 'OOMDetector',:git  => 'https://github.com/Tencent/OOMDetector.git
  
#  pod 'XCTestMetrics', '~> 0.0.8'
#  pod 'UITestKit', '~> 0.1.2'
#  pod 'UIFastKit', '~> 1.1.19'
#  pod 'UITestUtils', '~> 1.0.2'
  pod 'fishhook', '0.2'
  pod 'WHDebugTool',:inhibit_warnings => true
  # 权限配置
  pod 'ECPrivacyCheckTools',      :path => '../ECPrivacyCheckTools'
  pod 'PermissionKit',            :path => '../PermissionKit'
  pod 'TKPermissionKit'
  #  pod 'PermissionKit',:git => 'https://github.com/lixiang1994/PermissionKit.git',:tag => '1.4.0'
  pod 'SDWebImage'
  pod 'SDWebImageWebPCoder'
  pod 'YBImageBrowser', '~> 3.0.9'
  #  pod 'FLAnimatedImage','~> 1.0.16'
  #  pod 'YQImageCompressor'
  pod 'YYCategories'
  pod 'YYText'
  pod 'SVProgressHUD'
  pod 'MBProgressHUD'
  pod 'IQKeyboardManager'
  pod "BeeHive", '1.1.1'#https://github.com/alibaba/BeeHive/blob/master/README-CN.md
  pod 'ZYGCDTimer'
  pod 'Debugo'
  # swift
  pod 'SwiftyJSON','5.0.0'
  pod 'RxSwift','6.2.0'
  pod 'SnapKit','5.0.1'
  pod 'Moya'
  pod 'ObjectMapper','~> 3.5.2'
  pod 'HandyJSON'
  pod 'SwiftyJSON'
  pod 'Kingfisher'
  # 数据库
  pod 'FMDB' ,:git =>'https://github.com/ccgus/fmdb.git'#,             :source =>'https://github.com/CocoaPods/Specs.git'
  # 文件保存
  pod 'SAMKeychain',      '1.5.3',:source =>'https://github.com/CocoaPods/Specs.git'
  # 路由
  pod 'MGJRouter', :git => "https://github.com/lyujunwei/MGJRouter.git"
  pod 'CTMediator'
  # 布局
  pod 'Masonry'
  pod 'SDAutoLayout','~>2.2.1'
  pod 'YogaKit' #提供给Objective-C和Swift使用
  pod 'IGListKit','2.1.0'
  pod 'ComponentKit', '~> 0.31'#https://github.com/facebook/ComponentKit.git #一个受 React 启发的 iOS 视图框架
  pod 'BlocksKit'
#  pod 'AsyncDisplayKit'
#  pod 'Texture', '~> 3.1.0'
  pod 'OpenUDID'#,:git=>'https://github.com/ylechelle/OpenUDID.git'#,                 :source =>'https://github.com/CocoaPods/Specs.git'
  # Reactivecocoa 是git上面的一个开源框架,讲究的是万物皆信号
  pod 'ReactiveObjC'
  # 非越狱插件
  #  pod 'WechatPod'
  pod 'JKKVOHelper', '~> 0.1.29'
  pod 'RCLighting'
  pod 'MJExtension'
  pod 'SwipeView'
  pod 'GCDWebServer'
  pod 'AFNetworking'
  #iOS防截屏/录屏的实现https://m.weibo.cn/status/4738671431911826?wm=3333_2001&from=10C2093010&sourcetype=weixin
  #  https://mp.weixin.qq.com/s/L8Bv7GmZ7uKYgeGCEX9lXA
  pod 'FDFullscreenPopGesture', '~> 1.1'
  # nsf_oc_demo
  #  iOS开发-图片离线鉴黄 基于TensorFlow nsfw oc版
  #  下载地址
  #  https://github.com/linzida6688/nsf_oc_demo
  #  代码入侵
  #  pod 'Aspects',                  :git => 'https://github.com/steipete/Aspects.git'
  #  pod 'ZHMethodSwizzingDemo',:git => 'https://github.com/2446886848/ZHMethodSwizzingDemo.git'
  #  pod 'ZLPhotoBrowser-objc',      :git => 'https://github.com/longitachi/ZLPhotoBrowser-objc.git'
  #  pod 'JSPatch'
  #  pod 'PromisesObjC'
  #  pod 'RyukieSwifty/ScreenShield'
  pod 'FloatingButton',:git => 'https://github.com/DanboDuan/FloatingButton.git',:branch => 'master'
  #  pod 'SocketRocket'              #WebSocket  OC      推荐
  #  pod 'CocoaAsyncSocket'          #WebSocket
  #  pod 'Starscream'                #WebSocket  Swift   推荐
  #  pod 'SwiftWebSocket'            #WebSocket  Swift
  #  pod 'PusherSwift'               #websocket  Swift
  #  pod 'Socket.IO-Client-Swift'    #Socket.IO
  #  pod 'ZYNetworkAccessibity'      # iOS网络权限的监控和判断
  #  pod 'CocoaHTTPServer'           # HTTP服务器
  #  pod 'GCDWebServer'              # HTTP server for iOS, macOS & tvOS
  #  pod 'XMPPFramework'             #
  #  pod 'MQTTClient'                #MQTT Client Framework
  #  pod 'BabyBluetooth'             #一个非常容易使用的蓝牙库,适用于ios和os
  #  #动画与转场
  pod 'lottie-ios'                    #优秀动画库 -> 直接加载动画设计资文件
  pod 'Spring'                        #一个在 Swift 中简化 iOS 动画的库。
  pod 'Hero'                          #适用于 iOS 和 tvOS 的优雅过渡库
  pod 'WXSTransition'                 #界面转场动画         ->  推荐
  pod 'HHTransition'                  #主流转场动画，无侵入，API简单易用。        ->  推荐
  pod 'RBBAnimation'                  #基于块的动画制作简单，带有简化功能和一个 CASpringAnimation 替换。
  pod 'TABAnimated'                   #-> 很不错(TableView Cell加载动画)  ->一个由iOS原生组件映射出骨架屏的框架，包含快速植入，低耦合，兼容复杂视图等特点，提供国内主流骨架屏动画的加载方案，同时支持上拉加载更多、定制动画。
  pod 'VCTransitionsLibrary'          #vc push, tabvc 转场动画
  pod 'SXWaveAnimate'                 #水波纹,圆圈进度条与动画  ->  不错
  pod 'PopupDialog'                   #弹窗动画
  pod 'PopMenu'                       #PopMenu 是受新浪微博/网易应用启发的弹出动画菜单。
  pod 'pop'                           #facebook开源的一套动画，有卡片动画效果，类似陌陌首页发现动画
  pod 'IBAnimatable'                  #使用 IBAnimatable 在 Interface Builder 中为 App Store 就绪的应用程序设计和原型定制 UI、交互、导航、过渡和动画。
  #  popping                             #动画集 ->https://github.com/schneiderandre/popping
  #  ShareOfCoreAnimation                #一些基础动画 -> https://github.com/rjinxx/ShareOfCoreAnimation
  #  pod 'iOSAnimation',:git  => 'https://github.com/opooc/iOSAnimation.git'
  #  https://github.com/caferrara/img-to-video.git  #图片转视频
  #  https://github.com/YanLYM/YMTransitionDemo.git #转场动画
  #  LearniOSAnimations                  #系统学习iOS动画，有很多代码示例  -> 很不错      -> https://github.com/andyRon/LearniOSAnimations
  #  LearniOSAnimations动画详细讲解地址 ->  ttps://blog.devtang.com/2016/03/13/iOS-transition-guide/
  #  IOSAnimationDemo                    #IOS动画总结     ->  https://github.com/yixiangboy/IOSAnimationDemo
  #  pod 'VGGradientSwitch',          :git => 'https://github.com/VeinGuo/VGGradientSwitch.git'
  #  swift 教学 https://github.com/YvanLiu/SwiftDemo.git
  #  LLDynamicLaunchScreen https://www.jianshu.com/p/d8d2145c6333
  #  https://github.com/cyq1162/Sagit
  pod 'HHTimeProfiler'

end

target 'testSingature_N' do
  shared_pods
  commonlyUsed
  
end

#pre_install do |installer|
#puts "==================做一些安装之前的更改"
#end
#post_install

#post_install do |installer|
#    myTargets = ['ObjectMapper', 'SnapKit']
#    #设置预编译宏
#    installer.pods_project.targets.each do |target|
#      if myTargets.include? target.name
#          target.build_configurations.each do |config|
#              config.build_settings['SWIFT_VERSION'] = '4.0'
#              puts "===================>config is #{config.build_settings['SWIFT_VERSION']}"
#      puts "====解释 #{config.build_settings['Swift_Language_Version']}"
#          end
#      end
#        puts "===================>⬆️target name #{target.name}"
#        target.build_configurations.each do |config|
#            config.build_settings['ENABLE_BITCODE'] = 'NO'
##            config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)', 'SIT=1']
#            puts "===================>⬆️config is #{config.build_settings['GCC_PREPROCESSOR_DEFINITIONS']}"
#
### CocoaPods 每次执行 pod update 的时候都会把 Pods 项目重新生成一遍，如果直接在 Xcode 里面修改 Pods 项目里面的 Enable Modules 选项，下次执行pod update的时候又会被改回来。我们需要在 Podfile 里面加入下面的代码，让生成的项目关闭 Enable Modules 选项，同时加入 CC 参数，否则 pod 在编译的时候就无法使用 CCache 加速：
##            if config.name == 'MyHelloWord'
##
##                config.build_settings['CLANG_ENABLE_MODULES'] = 'NO'
##                config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] = '$(inherited) SIT'
##
##            end
#        end
#    end
#end
#  post_install do |installer_representation|
#    installer_representation.pods_project.targets.each do |target|
#      puts "===================>⬇️target name #{target.name}"
#      target.build_configurations.each do |config|
#        if target.name == 'testSingature_Debug'
#          config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] = '$(inherited) UAT_PRO'
#        end
#        if target.name == 'testSingature'
#          config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] = '$(inherited) PROD'
#        end
#      end
#    end
#  end


## add settings needed to generate test coverage data
#post_install do |installer|
#
#  COV_TARGET_NAME = "Pods-MasonryTestsLoader-Masonry"
#  EXPORT_ENV_PHASE_NAME = "Export Environment Vars"
#  EXPORT_ENV_PHASE_SCRIPT = "export | egrep '( BUILT_PRODUCTS_DIR)|(CURRENT_ARCH)|(OBJECT_FILE_DIR_normal)|(SRCROOT)|(OBJROOT)' > $SRCROOT/../script/env.sh"
#
#  # find target
#  classy_pods_target = installer.project.targets.find{ |target| target.name == COV_TARGET_NAME }
#  unless classy_pods_target
#   raise ::Pod::Informative, "Failed to find '" << COV_TARGET_NAME << "' target"
#  end
#
#  # add build settings
#  classy_pods_target.build_configurations.each do |config|
#    config.build_settings['GCC_GENERATE_TEST_COVERAGE_FILES'] = 'YES'
#    config.build_settings['GCC_INSTRUMENT_PROGRAM_FLOW_ARCS'] = 'YES'
#  end
#
## add build phase
# phase = classy_pods_target.shell_script_build_phases.select{ |bp| bp.name == EXPORT_ENV_PHASE_NAME }.first ||
#   classy_pods_target.new_shell_script_build_phase(EXPORT_ENV_PHASE_NAME)
#
# phase.shell_path = "/bin/sh"
# phase.shell_script = EXPORT_ENV_PHASE_SCRIPT
# phase.show_env_vars_in_log = '0'
#end

#这个钩子允许你对pod在下载完成之后，但是在install之前做一些操作
#pre_install do |installer|
# Do something fancy!
#  installer.pods_project.targets.each do |target|
#      target.build_configurations.each do |config|
#          config.build_settings['SWIFT_VERSION'] = '4.0'
#      end
#  end
#end
#该钩子允许您在将项目写入磁盘之前进行更改。
#pre_integrate do |installer|
# perform some changes on dependencies
#end
#这个钩子允许你在生成的Xcode项目被写入磁盘之前对它做任何最后的修改，或者任何你想要执行的任务
#post_install do |installer|
#  installer.pods_project.targets.each do |target|
#    target.build_configurations.each do |config|
#      config.build_settings['GCC_ENABLE_OBJC_GC'] = 'supported'
#    end
#  end
#end
#这个钩子允许您在项目被写入磁盘后进行更改。
#post_integrate do |installer|
# some change after project write to disk
#end
#def find_and_replace(dir, findstr, replacestr)
#
#  Dir[dir].each do |name|
#
#      text = File.read(name)
#
#      replace = text.gsub(findstr,replacestr)
#
#      if text != replace
#
#          puts "Fix: " + name
#
#          File.open(name, "w") { |file| file.puts replace }
#
#          STDOUT.flush
#
#      end
#
#  end
#
#  Dir[dir + '*/'].each(&method(:find_and_replace))
#
#end
#post_install do |installer|
#  find_and_replace("Pods/A/A/A/AViewController.m","printf('apple');","printf('apple1');")
#设置预编译宏
#    installer.pods_project.targets.each do |target|
#        puts "===================>⬆️   target name #{target.name}"
#        target.build_configurations.each do |config|
#          puts "===================>⬆️  config name #{config.name}"
#          targets = installer.pods_project.targets.select { |target| target.name == 'CategoryRelyon' }
#          config.build_settings['Enable Strict Checking of objc_msgSend Calls'] = 'NO'
#            if target.name == 'CategoryRelyon'
#                config.build_settings["ENABLE_STRICT_CHECKING_OF_OBJC_MSGSEND_CALLS"] = 'NO'
#            end
#
#            if config.name == 'Debug_UAT'
#                config.build_settings['ENABLE_BITCODE'] = 'NO'
#                config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)', 'UAT=1']
#            end
#
#            if config.name == 'Debug_SIT'
#                config.build_settings['ENABLE_BITCODE'] = 'NO'
#                config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)', 'SIT=1']
#
#            end
#
#            if config.name == 'Debug'
#                config.build_settings['ENABLE_BITCODE'] = 'NO'
#                config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)', 'DEV=1']
#            end
#
#            if config.name == 'Release'
#
#                config.build_settings['ENABLE_BITCODE'] = 'NO'
#                config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)', 'PRO=1']
#            end
#
#        end
#    end
#end

#def find_and_replace(dir, findstr, replacestr)
#  puts "===================>⬆️  dir #{dir}"
#  puts "===================>⬆️  findstr #{findstr}"
#  puts "===================>⬆️  replacestr #{replacestr}"
#  Dir[dir].each{
#    |x|
#    text = File.read(x)
#    replace = text.gsub(findstr,replacestr)
#    puts "代码  #{text}"
#    puts "替换  #{replace}"
#    puts "变量值  #{x}"
#    puts "Fix: " + x
#    File.open(x, "w") {
#      |file|
#      file.puts
##    replace
#    puts "文件  #{file}"
#
#    100.times do |i|
#      set_progress(i + 1)
#      $stdout.flush
#      sleep 0.05
#    end
#    puts
#    puts "替换  #{replace}"
#    }
#    print x,"哈哈"
#  }
#  puts "\n"
#  Dir[dir + '*/'].each(&method(:find_and_replace))
#  puts "目录重写: " + Dir[dir + '*/']
##  puts "方法重写: " + (&method(:find_and_replace))
#
#  puts "========我是分割线==========="
#
#end
#
#def set_progress(index, char = '*')
#  print (char * (index / 2.5).floor).ljust(40, " "), " #{index}%\r"
#end






