##YYCache

// 建个小数据表
    YYCache *cache = [YYCache cacheWithName:@"userInfo"];

// 存(可存字典数组等)
    [cache setObject:@"张三" forKey:@"name"];

// 检查 读取（直接读取，不存在则是 nil）
    if ([cache containsObjectForKey:@"name"]) {
        NSString *name = (NSString *)[cache objectForKey:@"name"];
        NSLog(@"%@",[name class]);
    }

// 删
    [cache removeObjectForKey:@"name"];
    [cache removeAllObjects];
    

###存放模型的方法
遵循NSCoding协议
实现方法:
//  归档 - 对属性进行编码
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_uid forKey:@"uid"];
    [aCoder encodeObject:_type forKey:@"type"];
    [aCoder encodeObject:_username forKey:@"username"];
    [aCoder encodeObject:_sex forKey:@"sex"];
    [aCoder encodeObject:_nicname forKey:@"nicname"];
    [aCoder encodeObject:_mobile forKey:@"mobile"];
    [aCoder encodeObject:_password forKey:@"password"];
}
//  解归档
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _uid = [aDecoder decodeObjectForKey:@"uid"];
        _type = [aDecoder decodeObjectForKey:@"type"];
        _username = [aDecoder decodeObjectForKey:@"username"];
        _sex = [aDecoder decodeObjectForKey:@"sex"];
        _nicname = [aDecoder decodeObjectForKey:@"nicname"];
        _mobile = [aDecoder decodeObjectForKey:@"mobile"];
        _password = [aDecoder decodeObjectForKey:@"password"];
    }
    return self;
}
