##3DTouch

###应用程序图标上的3DTouch


 1.首先我们需要在Info.plist文件中加上一项
    UIApplicationShortcutItems---[array]
        Item0---[dict]
        UIApplicationShortcutItemIconType---[string]---(值)
        UIApplicationShortcutItemTitle---[string]---(值)
		//必须的
        UIApplicationShortcutItemType---[string]---(值)
    [/dict]
 [/array]
 

 #####UIApplicationShortcutItemIconType(系统图标){
     UIApplicationShortcutIconTypeSearch
     UIApplicationShortcutIconTypeShare
     UIApplicationShortcutIconTypeAdd
     ...
 }
 
  #####UIApplicationShortcutItemTitle(3DTouch触发时显示的活动名称）{
	
    
 }
 
 #####UIApplicationShortcutItemType（相当于项目中的Bundle Identifier唯一的，通过这个标示我们可以判断点相应的那一项触发相应的操作，可以多设置几个）{
	
    操作的标识
    
 }
 #####UIApplicationShortcutItemIconFile（自定义图标）{
     //图片名
     action_bar_icon_scanner_dark.png

 }


####pragma mark - 3DTouch响应事件

-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    
    //在这里判断touch类型type，打开对应界面
    
    if ([shortcutItem.type isEqualToString:@"scanning"]) {
        
        //创建要跳转的控制器
        ScanningViewController *scanVc=[[ScanningViewController alloc] init];
        
        //跳转到对应页面
        [(UINavigationController *)self.window.rootViewController pushViewController:scanVc animated:YES];
        
    }
    
    
}




###程序内的3DTouch

协议
```
 <UIViewControllerPreviewingDelegate>
```

    //*********判断是否支持3D Touch***********
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
    
    //支持则注册3DTouch功能
        [self registerForPreviewingWithDelegate:self sourceView:self.tableView];
    }



###pragma mark - 3DTouch代理方法
```
-(UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    
    //将点击的屏幕坐标转换成tableView的cell位置
    NSInteger indexPath=[_tableView indexPathForRowAtPoint:location].row;
    
    UIViewController *vc=nil;
    
    AddViewController *addVc=[[AddViewController alloc] init];
    
    ScanningViewController *scanVc=[[ScanningViewController alloc] init];
    
    if (indexPath==0) {
        vc=scanVc;
        
    }else{
        vc=addVc;
        
    }
    
    //预览页的位置、尺寸，按比例计算的长宽
    vc.preferredContentSize=CGSizeMake(375, 667);
    
    //返回预览页对应的控制器
    return vc;
    
}
```

//在预览页存在的情况下，继续按压屏幕，就会调用此方法
//此时可以直接显示出对应的页面
```
-(void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit{
    
    //完全展示预览页面
    [self showViewController:viewControllerToCommit sender:self];
    
}
```


###预览页操作选项（在对应的控制器里添加）
```
//预览页可以进行的操作
/**  ************需要添加在对应预览页的控制器里************
 *  3DTouch触发时，向上滑动预览页的菜单栏
 *
 *  @return
 */
-(NSArray<id<UIPreviewActionItem>> *)previewActionItems{
    
    //添加对应预览页的action
    UIPreviewAction *action1=[UIPreviewAction actionWithTitle:@"分享" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
    }];
    
    UIPreviewAction *action2=[UIPreviewAction actionWithTitle:@"评论" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
    }];
    
    UIPreviewAction *action3=[UIPreviewAction actionWithTitle:@"取消" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
    }];
    
    //group可以展开
    UIPreviewActionGroup *group=[UIPreviewActionGroup actionGroupWithTitle:@"group" style:UIPreviewActionStyleDefault actions:@[action2,action3]];
    
    return @[action1,group];
}
```

一些资料
http://www.cocoachina.com/ios/20151019/13812.html
http://www.jianshu.com/p/74fe6cbc542b