##KVO

###注册观察者

//参数一:被观察对象;参数二:观察者(在这里面监听方法)
keypath:被观察对象的属性
options:选项,新旧值等
context:上下文,做区分用

```
[self.shopTotalBar addObserver:cell forKeyPath:@"isGoodSelected" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:@"selectAll"];
```

###监听方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    //***监听自身是否被选中***
    if (context==@"selectSelf") {
        
        NSLog(@"自己被选中了");
        
        
    }
    
    //***监听全选***
    if (context==@"selectAll") {
        
        if ([change[@"new"] isEqual:@(1)]) {
            
            self.isGoodSelected=YES;
            
            [self.selectButton setImage:[UIImage imageNamed:@"Shape-128"] forState:UIControlStateNormal];
        }else{
            
            self.isGoodSelected=NO;
            
            [self.selectButton setImage:[UIImage imageNamed:@"forbidden-拷贝-5"] forState:UIControlStateNormal];
        }
    }
}

###移除观察者
-(void)dealloc{
    
    [self.observeObj removeObserver:self forKeyPath:@"isGoodSelected"];
}