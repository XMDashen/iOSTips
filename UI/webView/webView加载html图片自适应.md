##webView加载html图片自适应

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *jsStr = @"function reSetImgFrame() { \
                       var imgs = document.getElementsByTagName('img'); \
                        for (var i = 0; i < imgs.length; i++) {\
                           var img = imgs[i];   \
                           img.style.maxWidth = %f;   \
                        } \
                   }";
    jsStr = [NSString stringWithFormat:jsStr, [UIScreen mainScreen].bounds.size.width - 20];

    [webView stringByEvaluatingJavaScriptFromString:jsStr];
    [webView stringByEvaluatingJavaScriptFromString:@"reSetImgFrame()"];
}


