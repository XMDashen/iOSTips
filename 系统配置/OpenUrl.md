##OpenUrl

【iOS】[UIApplication sharedApplication] openURL:常用方法


###拨号(Phone Number)
```
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://10086"]];
```

###调用短信(SMS)
```
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms:10086"]];
```

###调用浏览器(Safari Browser)
```
NSURL *url= [NSURL URLWithString:@"http://eyecm.com"];
[[UIApplication sharedApplication] openURL:url];
```

###调用应用商店(AppStore)
```
NSURL *appStoreUrl= [NSURL URLWithString:@"http://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=291586600&amp;mt=8"];
[[UIApplication sharedApplication] openURL:appStoreUrl];
```

###调用谷歌地图(Google Maps)
```
NSString *searchQuery = @"1 Infinite Loop, Cupertino, CA 95014";  

searchQuery = [addressText stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];  

NSString *urlString=[NSString stringWithFormat:@"http://maps.google.com/maps?q=%@", searchQuery];  

[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlText]];
```

###调用邮件客户端(Apple Mail)
```
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://admin@eyecm.com"]];
```

调用appstore中程序的评论
```
NSString *str = [NSString stringWithFormat:
                         @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d",
                         m_appleID ];  
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
```