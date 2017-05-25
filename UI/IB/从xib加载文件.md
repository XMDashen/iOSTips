##从xib加载文件

###新建xib文件,==选择empty空文件==,自己拖view进去

选view的xib文件尺寸会出问题

```
XMStockInfoCell *cell=[[[NSBundle mainBundle] loadNibNamed:@"XMStockInfoCell" owner:nil options:nil] firstObject];
```

连线时报错的话,记得要删除连线

最好不要改xib的名字

###从xib加载控制器 initWithNibName
XMSuggestionController *suggestionVc=[[XMSuggestionController alloc] initWithNibName:NSStringFromClass([XMSuggestionController class]) bundle:nil];

###xib里的File's owner 中ountlet 的view需连上主要视图view，否则会崩溃（复制主页面view时需注意）