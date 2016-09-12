##左滑Pop

navigationController自带左滑pop
如果对导航栏进行了自定义，则左滑pop失效

添加代码：
```
#pragma mark - 页面已经显示出来时添加左滑pop
-(void)viewDidAppear:(BOOL)animated{
    
    __weak typeof(self) weakself=self;
    
    //判断是否为导航控制器首页
    if (self.navigationController.viewControllers.count==1) {
        //关闭首页导航控制器Pop手势的交互
        self.navigationController.interactivePopGestureRecognizer.enabled=NO;
    }else{
        //打开Pop手势交互
        self.navigationController.interactivePopGestureRecognizer.enabled=YES;
        //设置Pop手势交互代理
        self.navigationController.interactivePopGestureRecognizer.delegate=weakself;
    }
}
```
一定要判断是否为导航控制器首页
如果是navigationController push出的首页会出bug




