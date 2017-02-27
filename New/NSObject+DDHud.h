//
//  NSObject+DDHud.h
//  DongDongWedding(origin)
//
//  Created by 懂懂科技--xiexi on 16/8/4.
//  Copyright © 2016年 DDKJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DDHud)
+ (void)showHudTipStr:(NSString *)tipStr;
+ (void)showHudTipStr:(NSString*)tipStr AndHideCallBackBlock:(void(^)())block;
+ (void)showHudWithCheckmark:(NSString*)hubString AndHideCallBackBlock:(void(^)())block;
- (BOOL)isExist;
@end
