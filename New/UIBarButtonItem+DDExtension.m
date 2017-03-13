//
//  UIBarButtonItem+DDExtension.m
//  DongDongWedding(origin)
//
//  Created by 懂懂科技--xiexi on 16/8/4.
//  Copyright © 2016年 DDKJ. All rights reserved.
//

#import "UIBarButtonItem+DDExtension.h"

@implementation UIBarButtonItem (DDExtension)

#pragma mark  ImageBarButton .
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
//    UITrackingRunLoopMode
   
    // 设置尺寸
    //btn.size = btn.currentBackgroundImage.size;
    btn.bounds = CGRectMake(0, 0, btn.currentBackgroundImage.size.width, btn.currentBackgroundImage.size.height);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}


+(UIBarButtonItem *)itemWithRedArrowImagewithTarget:(id)obj action:(SEL)selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:obj action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[DDSkin DDThemeRedBackImage] forState:UIControlStateNormal];
//    btn.bounds = CGRectMake(0, 0, 30, 30);
//    [btn setImageEdgeInsets:UIEdgeInsetsMake(3, 0, 0, 22)];
    //让btn保持图片大小
      btn.bounds = CGRectMake(0, 0, btn.currentBackgroundImage.size.width, btn.currentBackgroundImage.size.height);
    return [[UIBarButtonItem alloc] initWithCustomView:btn];

    
    
}
+(UIBarButtonItem *)itemWithWhiteArrowImagewithTarget:(id)obj action:(SEL)selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:obj action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
       btn.bounds = CGRectMake(0, 0, btn.currentBackgroundImage.size.width, btn.currentBackgroundImage.size.height);
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    
    
}

+(UIBarButtonItem *)itemWithRedBtnTitle:(NSString *)title target:(id)obj action:(SEL)selector
{
      UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:obj action:selector forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font=[UIFont systemFontOfSize:15];
    [btn setTitleColor:[DDSkin DDThemeRedColor] forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn sizeToFit];
      return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+(UIBarButtonItem *)itemWithRedBackArrow
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
       [btn setBackgroundImage:[UIImage imageNamed:@"back_red"] forState:UIControlStateNormal];
    btn.bounds = CGRectMake(0, 0, btn.currentBackgroundImage.size.width, btn.currentBackgroundImage.size.height);
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+(UIBarButtonItem *)itemWithWhiteBackArrow
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
    btn.bounds = CGRectMake(0, 0, btn.currentBackgroundImage.size.width, btn.currentBackgroundImage.size.height);
    return [[UIBarButtonItem alloc] initWithCustomView:btn];}
@end
