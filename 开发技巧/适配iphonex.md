适配iphonex

```
iphoneX 屏幕尺寸 812 * 375

屏幕像素  2436px * 1125px

iphoneX 状态栏：44 导航栏：44 底部黑条：34

常用宏定义
#define kIOS_11 @available(iOS 11.0, *) 判断ios版本（XCODE9以后）

#define kDeviceIsX (SCREEN_HEIGHT == 812) 判断是否iphoneX

#define kStatusBarAndNaviBarHeight (kDeviceIsX ? 88 : 64)
#define kStatusBarHeight (kDeviceIsX ? 44 : 20)
#define kSafeAreaBottomDistance (kDeviceIsX ? 34 : 0)

scrollView自动布局

self.automaticallyAdjustsScrollViewInsets=NO; iOS11以前

if (kIOS_11) {   scrollView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    }

xib适配：
xib show the file inspector选项卡中打开 Use Safe Area Layout Guides
在约束中选择约束到safeArea(***iOS11以上***)

```