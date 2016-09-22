##scrollView加载不同页面自适应高度(电商类常用)

####scrollView总高度属性
```
//计算后总高度
@property(nonatomic,assign) CGFloat totalHeight;
```

####切换scrollView上页面时重新计算并改变scrollView的contentSize大小
```
//重新计算totalViewHeight
    _totalHeight=[XMCalculate calculateTotalHeightWithNumberOfProductData:self.productDataArray.count];
    
//改变scrollView的大小
    _scrollView.contentSize=CGSizeMake(self.view.bounds.size.width, _totalHeight);
```

####在专门的计算工具类中计算高度(用类方法便于调用),宏定义写好常量
```
#define width [UIScreen mainScreen].bounds.size.width

//其他视图固定高宽比
#define otherViewFixRation ((487+64)/375.0)

//商品参数单元格高度
#define productDataUnitHeight 44

@implementation XMCalculate

#pragma mark 计算加载样板图时的总高度
+(CGFloat)calculateTotalHeightWithNumberOfSamplePic:(NSInteger)number{
    
    //样板图总高度
     CGFloat sampleViewHeight=number * width*samplePicFixRation;
    
    //其他视图高度
    CGFloat otherViewHeight=width*otherViewFixRation;
    
    //总高度
    CGFloat totalHeight=sampleViewHeight+otherViewHeight;
    
    return totalHeight;
}
```