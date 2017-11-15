AF整体提交JSON字符串Body

```
NSDictionary *paraDict=@{@"birthday":model.birthday,@"code":model.code,@"headUrl":model.headUrl,@"mobile":model.mobile,@"nickname":model.nickName,@"password":model.password,@"sex":@(0)};
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:paraDict options:0 error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:USER_REGIST_URL parameters:nil error:nil];
    
    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:data];
    
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            NSLog(@"Reply JSON: %@", responseObject);
            
            NSInteger code=[responseObject[@"code"] integerValue];
            if (code==1) {
                successBlock(responseObject);
            }
            
            [NSObject showHudTipStr:responseObject[@"message"]];
            
        } else {
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            
        }
    }] resume];
```