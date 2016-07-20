##从plist加载文件

```
    //获取plist文件路径
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Controllers" ofType:@"plist"];
    
    //获取数组
    NSArray *plistArray=[NSArray arrayWithContentsOfFile:path];
```