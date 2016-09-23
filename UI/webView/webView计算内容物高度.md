##计算webView上内容物的高度

计算加载好时的webView上的内容物高度
一般在webView加载完成时调用

```
-(void)webViewDidFinishLoad:(UIWebView *)webView{
//计算webView上内容物的高度
    CGFloat newHeight=[[self.detailWebView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    }
```



