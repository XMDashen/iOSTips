GCD Timer

```
@property (nonatomic, strong) dispatch_source_t timer;
```

1.创建类型为 定时器类型的 Dispatch Source
```
    //1.1将定时器设置在主线程
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    //1.2设置定时器每一秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1 * NSEC_PER_SEC, 0);
    //1.3设置定时器执行的动作
    dispatch_source_set_event_handler(_timer, ^{
        //在这里实现业务逻辑...
        NSLog(@"来打我吖！！！");
    });
    //2.启动定时器
    dispatch_resume(_timer);
    // Do any additional setup after loading the view.
```
```
dispatch_source_create(dispatch_source_type_t type,
 uintptr_t handle,
 unsigned long mask,
 dispatch_queue_t _Nullable queue)
 ```
第一个参数：dispatch_source_type_t type为设置GCD源方法的类型，前面已经列举过了。
第二个参数：uintptr_t handle Apple的API介绍说，暂时没有使用，传0即可。
第三个参数：unsigned long mask Apple的API介绍说，使用DISPATCH_TIMER_STRICT，会引起电量消耗加剧，毕竟要求精确时间，所以一般传0即可，视业务情况而定。
第四个参数：dispatch_queue_t _Nullable queue 队列，将定时器事件处理的Block提交到哪个队列之上。可以传Null，默认为全局队列。注意：当提交到全局队列的时候，时间处理的回调内，需要异步获取UI线程，更新UI...不过这好像是常识，又啰嗦了...


调度源提供了源事件的处理回调，同时也提供了取消源事件处理的回调，使用非常方便。
```
dispatch_source_set_cancel_handler(dispatch_source_t source,
 dispatch_block_t _Nullable handler)
 ```