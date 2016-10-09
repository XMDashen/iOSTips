##cell自适应高度

###cell上加载text等非耗时操作

方法一:
先调用估计cell高度代理方法
```
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
```

创建cell并在cell里计算cell正确高度然后保存到cell的属性里
```
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
```

调用cell设置高度方法,返回cell的正确高度
```
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
```
***
方法二:
请求到数据后,直接算出高度保存在model里,在cell设置高度代理方法中直接返回这个高度,适用于与视图不想关的简单计算
***

方法三
通过设置约束自适应高度
***

http://www.jianshu.com/p/38a52a53fb8e?utm_campaign=hugo&utm_medium=reader_share&utm_content=note&utm_source=qq



***
###cell上加载webView/图片等耗时操作
eg:加载webView内容自适应高度,加载图片但后台没有传图片尺寸过来

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