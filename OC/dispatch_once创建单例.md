dispatch_once创建单例

+(BarrageRenderer *)sharedManager{
    
    static BarrageRenderer *sharedBarrageInstance = nil;
    
    //dispatch_once的标志参数,必须是全局变量或static变量
    static dispatch_once_t onceToken;
    //dispatch_once函数保证block在程序的生命周期范围内只执行一次。
    dispatch_once(&onceToken, ^{
        sharedBarrageInstance = [[BarrageRenderer alloc] init];
    });
    return sharedBarrageInstance;
}