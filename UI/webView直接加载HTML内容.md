##webView可以直接加载HTML内容



添加代码：
使用loadHTMLString方法

```
//加载webView上的内容
        [_webView loadHTMLString:htmlContent baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];

```




