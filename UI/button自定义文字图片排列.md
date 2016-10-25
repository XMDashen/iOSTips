##
```
-(void)convertLabelAndImageWithButton:(UIButton *)button{
    
    CGFloat labelWidth;
    CGFloat imageWidth=button.imageView.bounds.size.width;
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        
        labelWidth=button.titleLabel.intrinsicContentSize.width;
    } else {
        
        labelWidth=button.titleLabel.bounds.size.width;
    }
    
    button.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
}
```
