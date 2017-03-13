//
//  UIBarButtonItem+DDExtension.h
//  DongDongWedding(origin)
//
//  Created by 懂懂科技--xiexi on 16/8/4.
//  Copyright © 2016年 DDKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (DDExtension)
//custom btn
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;
//red btn
+ (UIBarButtonItem *)itemWithRedBtnTitle:(NSString *)title target:(id)obj action:(SEL)selector;
//red arrow btn
+ (UIBarButtonItem *)itemWithRedArrowImagewithTarget:(id)obj action:(SEL)selector;
//white arrow
+(UIBarButtonItem *)itemWithWhiteArrowImagewithTarget:(id)obj action:(SEL)selector;

+(UIBarButtonItem *)itemWithRedBackArrow;
+(UIBarButtonItem *)itemWithWhiteBackArrow;

@end
