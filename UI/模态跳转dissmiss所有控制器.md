###模态跳转dissmiss所有控制器

```
#pragma mark - 返回顶层
-(void)dismissAllController {
    
    UIViewController *vc = self.presentingViewController;
    
    //遍历寻找顶层present控制器
    while (vc.presentingViewController) {
        
        vc = vc.presentingViewController;
        
    }
    
    [vc dismissViewControllerAnimated:YES completion:nil];
    
}
```