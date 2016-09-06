##webView上加载其它内容


```
//设置webView的contentInset向下偏移一定的距离
_webView.scrollView.contentInset=UIEdgeInsetsMake(80, 0, 0, 0);

//将其它内容加载到这段偏移的距离的空间上
//labelY为负值
labelY=-80；
UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, labelY, labelW, labelH)];

//这样就可以跟随webView的scrollView一起滚动了
```



