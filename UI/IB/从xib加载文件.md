##从xib加载文件

###新建xib文件,==选择empty空文件==,自己拖view进去

选view的xib文件尺寸会出问题

```
XMStockInfoCell *cell=[[[NSBundle mainBundle] loadNibNamed:@"XMStockInfoCell" owner:nil options:nil] firstObject];
```