##SDWebImage详解


###从网络加载图片
```
[_imageView sd_setImageWithURL: placeholderImage:];
```

1.运行时关联&imageURLKey, url
objc_setAssociatedObject(self, &imageURLKey, url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

2.判断并加载占位图片
dispatch_main_async_safe(^{
            self.image = placeholder;
        });

3.下载图片缓存到本地，加载图片



###将图片缓存到本地沙盒，用Key来对应图片
```
[[SDImageCache sharedImageCache] storeImage:[UIImage imageNamed:@"rainning.jpeg"] forKey:@"rain"];
```

###从沙盒获取图片，用Key来对应图片
```
UIImage *image=[[SDImageCache sharedImageCache] imageFromDiskCacheForKey:@"rain"];
```

###tips
1.SDWebImage图片下载操作使用了NSURLConnection类发送网络请求实现
2.SDWebImage内部使用NSCache类来进行缓存处理


###SDWebImage原理分析与常识
	 - SDWebImage的磁盘缓存, 是按照时间来处理的, 只要缓存数据超过了最大的缓存时间, 		就会自动删除
     - SDWebImage默认的磁盘缓存时间是多久? 
        + 1周
     - SDWebImage接收到内存警告会如何处理
        + 只要接收到内存警告就会调用 clearMemory 清空内存缓存
     - SDWebImage即将要被终结如何处理
        + 会调用 cleanDisk 方法, 删除过期的文件
     - SDWebImage存储到什么为止
        + caches文件夹下面
        + 新建一个default文件夹用于缓存
     - SDWebImage是如何清空缓存 ?
        + clearMemory
        + 移除NSCache中保存的所有图片对象

     - SDWebImage是如何清除磁盘
        + cleanDisk : 清除过期的
            * 遍历缓存目录, 找到所有过期的文件, 并删除
            * 查看当maxCacheSize的值, 如果删除之后缓存的大小, 还大于maxCacheSize, 那么就会从时间较早的开始继续删除, 直到缓存大小小于maxCacheSize为止
        + clearDisk : 清除所有
            * 直接干掉缓存文件夹
            * 重新创建一个新的文件夹, 作为缓存文件

     - SDWebImage可以直接播放GIF图片
        + 加载GIF图片, 然后取出GIF图片中所有的帧, 并且计算动画时间
        + 根据取出的帧和动画时间生产一张新的可动画的图片

     - SDWebImage它可以判断图片的类型
        + 图片的十六进制数据, 的前8个字节都是一样的, 所以可以同判断十六进制来判断图片的类型
        + PNG
        + JPG
        + ...
