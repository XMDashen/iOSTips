##cell坐标转换为屏幕坐标

```
//获取cell在tableView上的坐标
CGRect cellRect=[tableView rectForRowAtIndexPath:indexPath];
    
//转换为屏幕上的坐标
    CGRect cellRectInScreen=[tableView convertRect:cellRect toView:[tableView superview]];


```





