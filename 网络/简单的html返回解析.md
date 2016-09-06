##简单的html返回解析

直接用NSString的stringWithContentsOfURL的方法请求解析（仅限内容简单的）
复杂的html解析用第三方库TFHpple、XPathQuery

添加代码：
```
NSString *dataStr=[NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://183.57.48.75/smartboxgtimg/s3/index_app.php?q=gh&t=all"] encoding:NSUTF8StringEncoding error:nil];

```





