##NSCache

###NSCache使用方法、机制和NSMutableDictionary类似
NSCache可以保存任意类型的对象(object)
NSMutableDictionary只能保存基本数据类型（value）

```
//获取
- (nullable ObjectType)objectForKey:(KeyType)key;

//保存
- (void)setObject:(ObjectType)obj forKey:(KeyType)key; // 0 cost
```



 ####1.NSCache是专门用来进行缓存处理的，
 ####2.NSCache简单介绍：
    2-1 NSCache是苹果官方提供的缓存类，具体使用和NSMutableDictionary类似，==在AFN和SDWebImage框架中被使用来管理缓存==
    2-2 苹果官方解释NSCache在系统内存很低时，会自动释放对象（但模拟器演示不会释放）
        建议：接收到内存警告时主动调用removeAllObject方法释放对象
    2-3 NSCache是线程安全的，在多线程操作中，不需要对NSCache加锁
    2-4 NSCache的Key只是对对象进行Strong引用，不是拷贝
 ####3 属性介绍：
 ```
    name:名称
    delegete:设置代理
    totalCostLimit：缓存空间的最大总成本，超出上限会自动回收对象。默认值为0，表示没有限制
    countLimit：能够缓存的对象的最大数量。默认值为0，表示没有限制
    evictsObjectsWithDiscardedContent：标识缓存是否回收废弃的内容
    ```
    
 ####4 方法介绍
 ```
- (void)setObject:(ObjectType)obj forKey:(KeyType)key;//在缓存中设置指定键名对应的值，0成本

- (void)setObject:(ObjectType)obj forKey:(KeyType)key cost:(NSUInteger)g;//在缓存中设置指定键名对应的值，并且指定该键值对的成本，用于计算记录在缓存中的所有对象的总成本，出现内存警告或者超出缓存总成本上限的时候，缓存会开启一个回收过程，删除部分元素

- (void)removeObjectForKey:(KeyType)key;//删除缓存中指定键名的对象

- (void)removeAllObjects;//删除缓存中所有的对象
```