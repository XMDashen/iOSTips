##环信EaseUI集成大法

导入环信完整SDK
pod ‘HyphenateFullSDK’ 

拖入EaseUI到工程中

在EaseUI中的EMUIKit-3rdparty中删除重复的第三方库(MJRefresh)（保留MBProgressHUD+Add）
删除EMSDWebImage，并将所有用到EMSDWebImage中的方法替换为SDWebImge的方法(去掉EM)

如果报runtime错误，在PCH文件中头文件添加（只用于OC文件编译）
```

在EaseUI-resources-EaseUIResource.bundle里的plist文件里删除 executable file 这个key（否则提交版本时会报错）

#ifdef __OBJC__
#import "EaseUI.h"
#endif
```

在AppDelegate中初始化环信
```
//*******************环信注册***********************
    
    //***初始化SDK***
    EMOptions *options = [EMOptions optionsWithAppkey:@"wxm872#alphago"];
    options.apnsCertName = @"AlphaGo";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    //***初始化easeUI***
    [[EaseSDKHelper shareHelper] hyphenateApplication:application didFinishLaunchingWithOptions:launchOptions appkey:@"wxm872#alphago" apnsCertName:@"AlphaGo" otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
```

登录和注册的方法
```
#pragma mark - 环信登录注册
-(void)emLogin{
    
    //***环信登录***
    [[EMClient sharedClient] loginWithUsername:@"username" password:@"123456"];
    
    [[EMClient sharedClient].options setIsAutoLogin:YES];
}

-(void)emRegist{

    //***环信注册***
    [[EMClient sharedClient] registerWithUsername:@"username"  password:@"123456"];
    
    //登录
    [self emLogin];
}
```

会话列表控制器
EaseConversationListViewController

联系人列表控制器
EaseUsersListViewController

聊天页面控制器
EaseMessageViewController

可继承后遵循协议，实现代理方法，然后实现页面的自定义


###会话列表控制器刷新问题
在viewWillAppear里加上刷新方法，会话列表就有数据了
```
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //刷新会话列表
    [self tableViewDidTriggerHeaderRefresh];
    
}
```



###聊天页面表情包问题

导入表情包资源，在继承自EaseMessageViewController(聊天会话控制器)的子类中实现下面的方法

```
#pragma mark - 表情包

- (NSArray*)emotionFormessageViewController:(EaseMessageViewController *)viewController
{
    NSMutableArray *emotions = [NSMutableArray array];
    for (NSString *name in [EaseEmoji allEmoji]) {
        EaseEmotion *emotion = [[EaseEmotion alloc] initWithName:@"" emotionId:name emotionThumbnail:name emotionOriginal:name emotionOriginalURL:@"" emotionType:EMEmotionDefault];
        [emotions addObject:emotion];
    }
    EaseEmotion *temp = [emotions objectAtIndex:0];
    EaseEmotionManager *managerDefault = [[EaseEmotionManager alloc] initWithType:EMEmotionDefault emotionRow:3 emotionCol:7 emotions:emotions tagImage:[UIImage imageNamed:temp.emotionId]];
    
    NSMutableArray *emotionGifs = [NSMutableArray array];
    _emotionDic = [NSMutableDictionary dictionary];
    NSArray *names = @[@"icon_002",@"icon_007",@"icon_010",@"icon_012",@"icon_013",@"icon_018",@"icon_019",@"icon_020",@"icon_021",@"icon_022",@"icon_024",@"icon_027",@"icon_029",@"icon_030",@"icon_035",@"icon_040"];
    int index = 0;
    for (NSString *name in names) {
        index++;
        EaseEmotion *emotion = [[EaseEmotion alloc] initWithName:[NSString stringWithFormat:@"[示例%d]",index] emotionId:[NSString stringWithFormat:@"em%d",(1000 + index)] emotionThumbnail:[NSString stringWithFormat:@"%@_cover",name] emotionOriginal:[NSString stringWithFormat:@"%@",name] emotionOriginalURL:@"" emotionType:EMEmotionGif];
        [emotionGifs addObject:emotion];
        [_emotionDic setObject:emotion forKey:[NSString stringWithFormat:@"em%d",(1000 + index)]];
    }
    EaseEmotionManager *managerGif= [[EaseEmotionManager alloc] initWithType:EMEmotionGif emotionRow:2 emotionCol:4 emotions:emotionGifs tagImage:[UIImage imageNamed:@"icon_002_cover"]];
    
    return @[managerDefault,managerGif];
}
```


###Push进入环信聊天页面tabBar黑边问题
环信聊天界面的frame计算时考虑了tabBar的大小
解决方法：隐藏tabBar，并将tabBar的尺寸大小设置为0，0，0，0
```
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    
    self.tabBarController.tabBar.bounds = CGRectMake(0, 0, 0, 0);


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
    
    self.tabBarController.tabBar.bounds = CGRectMake(0, self.view.frame.origin.y - 64, self.view.frame.size.width, 44);
```





