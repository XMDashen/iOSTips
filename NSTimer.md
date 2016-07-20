##NSTimer


    //自动滚动timer
    ```
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
```

//立即执行
//    [timer fire];
//废除定时器
 [timer invalide] 
    ```
    
    //NSDefaultRunLoopMode：拖动时timer暂停,同步runloop
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    //NSDefaultRunLoopMode：拖动时timer继续，异步runloop
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
 

 
 
### 暂停和继续定时器的方法
```
            //暂停定时器
        [timer setFireDate:[NSDate distantFuture]];
        //立即启动定时器
        [timer setFireDate:[NSDate date]];
```