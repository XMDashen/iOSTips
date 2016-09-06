##两个scrollView的联动



在scrollView的代理事件中监听滑动，在一定范围内二者联动，超出范围则各自滚动
```
#pragma mark - 滑动代理方法(实现在一定范围内联动)
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

if (self.superViewController.tableView.contentOffset.y<800) {

//联动
self.superViewController.tableView.contentOffset=CGPointMake(0, self.superViewController.tableView.contentOffset.y+scrollView.contentOffset.y);

//scrollView的offset不动
scrollView.contentOffset=CGPointMake(0, 0);
}else{

if (scrollView.contentOffset.y<0) {
//联动
self.superViewController.tableView.contentOffset=CGPointMake(0, self.superViewController.tableView.contentOffset.y+scrollView.contentOffset.y);

//scrollView的offset不动
scrollView.contentOffset=CGPointMake(0, 0);
}
}

}
```
一定要判断是否为导航控制器首页
如果是navigationController push出的首页会出bug




