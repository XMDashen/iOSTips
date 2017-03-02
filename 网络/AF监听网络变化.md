AF监听网络变化

if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus==-1 || [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus==0) {
            [NSObject showHudTipStr:@"请检查网络连接！"];
            
        }

#pragma mark - 开始监听网络
+ (void)networkStatusWithBlock:(NetworkStatus)networkStatus
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status)
            {
                case AFNetworkReachabilityStatusUnknown:
                    networkStatus ? networkStatus(PPNetworkStatusUnknown) : nil;
                    _isNetwork = NO;
                    PPLog(@"未知网络");
                    [NSObject showHudTipStr:@"未知网络"];
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    networkStatus ? networkStatus(PPNetworkStatusNotReachable) : nil;
                    _isNetwork = NO;
                    PPLog(@"无网络");
                    [NSObject showHudTipStr:@"无网络连接"];
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    networkStatus ? networkStatus(PPNetworkStatusReachableViaWWAN) : nil;
                    _isNetwork = YES;
                    PPLog(@"手机自带网络");
                    [NSObject showHudTipStr:@"您正在使用移动蜂窝数据"];
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    networkStatus ? networkStatus(PPNetworkStatusReachableViaWiFi) : nil;
                    _isNetwork = YES;
                    PPLog(@"WIFI");
                    [NSObject showHudTipStr:@"WIFI网络连接"];
                    break;
            }
        }];
        
        [manager startMonitoring];
    });
}


//请求网络时左上角转小菊花
[AFNetworkActivityIndicatorManager sharedManager].enabled = YES;