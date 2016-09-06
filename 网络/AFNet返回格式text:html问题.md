##AFNet返回格式text/html问题

####使用AFNetWorking中的manager请求获取的数据，默认会被做json解析，但是并不支持所有的json类型。默认只支持text/json, application/json类型。但是有的时候我们可以还会遇到text/html类型。所以需要手动让AFNetWorking还可以解析text/html类型的json数据:  

添加代码：

```
#pragma mark - 懒加载

-(AFHTTPSessionManager *)requestManager{

    if (_requestManager==nil) {
    
        _requestManager=[AFHTTPSessionManager manager];

        // 设置JSON数据序列化，将JSON数据转换为字典或者数组
        _requestManager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        // 在序列化器中追加一个类型，text/html这个类型是不支持的，text/json, application/json
        
        _requestManager.responseSerializer.acceptableContentTypes = [_requestManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    }

    return _requestManager;

}

```




