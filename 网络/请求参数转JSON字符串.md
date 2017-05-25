//请求参数转JSON字符串

NSData *data = [NSJSONSerialization dataWithJSONObject:answerArray options:0 error:nil];

NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];