拦截返回按钮及右滑pop事件

加入代理 <UIGestureRecognizerDelegate>
#pragma mark - 拦截返回事件

//按钮返回
-(void)configBackButton{
    
    __weak typeof(&*self) __weakself = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //    backBtn.frame = CGRectMake(0, 6, 87, 23);
        [backBtn setBackgroundImage:[UIImage imageNamed:@"icon_return_red"] forState:UIControlStateNormal];
        backBtn.bounds = CGRectMake(0, 0, backBtn.currentBackgroundImage.size.width, backBtn.currentBackgroundImage.size.height);
        
        if (_isFromPayResult) {
            [backBtn addTarget:__weakself
                        action:@selector(jumpOut)
              forControlEvents:UIControlEventTouchUpInside];
        }else{
            [backBtn addTarget:__weakself
                        action:@selector(backToLastPage)
              forControlEvents:UIControlEventTouchUpInside];
        }
        
        UIBarButtonItem *leftButton =
        [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        [__weakself.navigationItem setLeftBarButtonItem:leftButton];
    });
}

//手势返回
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    //self.navigationController.interactivePopGestureRecognizer.enabled=NO;
    
    self.navigationController.interactivePopGestureRecognizer.delegate=self;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    //self.navigationController.interactivePopGestureRecognizer.enabled=YES;
    
    self.navigationController.interactivePopGestureRecognizer.delegate=(id<UIGestureRecognizerDelegate>)[self.navigationController topViewController];
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    if (_isFromPayResult==YES && gestureRecognizer==self.navigationController.interactivePopGestureRecognizer) {
        
        [self jumpOut];
    }else{
        
        [self backToLastPage];
    }
    
    return NO;
}

//普通返回
-(void)backToLastPage{
    
    [self.navigationController popViewControllerAnimated:YES];
}

//跳转到个人中心
-(void)jumpOut{
    
    self.tabBarController.selectedIndex=3;
    [self.navigationController popToRootViewControllerAnimated:YES];
}