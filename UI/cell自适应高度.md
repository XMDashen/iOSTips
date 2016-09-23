##cell自适应高度

###cell上加载text等非耗时操作

http://www.jianshu.com/p/38a52a53fb8e?utm_campaign=hugo&utm_medium=reader_share&utm_content=note&utm_source=qq

***
###cell上加载webView/图片等耗时操作


```
//重新计算的cell高度
@property(nonatomic,assign) CGFloat newCellHeight;

//是否重新计算了高度
@property(nonatomic,assign) BOOL isCalculateCellHeight;
```

####在创建cell的代理方法里

如果需要复用,则需要在cell里面单独判断
防止无限reload
```
 if (_isCalculateCellHeight) {
            
            //如果重新计算高度则不用再次传入model(不复用可用此法)
        }else{
            
            cell.model=self.model;
        }

        return cell;
```

####在cell高度设置代理方法里
```
        if (_isCalculateCellHeight) {
            
            //如果重新计算过高度则返回重新计算的高度
            return _newCellHeight;
            
        }else{
            
            //没有计算则返回默认高度
            return screenH*200/677;
        }
```

####通过代理方法返回计算的高度(其他内容可用自定义代理方法)
```
#pragma webView代理方法
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    //计算webView上内容物的高度
    CGFloat newHeight=[[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    
    _newCellHeight=newHeight;
    
    //计算标识设为yes
    _isCalculateCellHeight=YES;
    
    //刷新数据
    [self.tableView reloadData];
}
```