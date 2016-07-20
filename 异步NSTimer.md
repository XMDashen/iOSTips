##异步NSTimer

```
        //************自动滚动timer************
        NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    
    //添加到RunLoop中
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
```

