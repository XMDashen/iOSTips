//
//  NSObject+DDHud.m
//  DongDongWedding(origin)
//
//  Created by 懂懂科技--xiexi on 16/8/4.
//  Copyright © 2016年 DDKJ. All rights reserved.
//

#import "NSObject+DDHud.h"
#import "MBProgressHUD+MJ.h"
#import "MMPopupWindow.h"
@implementation NSObject (DDHud)
+ (void)showHudTipStr:(NSString *)tipStr{
    if (tipStr && tipStr.length > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIWindow *keyWindow=[UIApplication sharedApplication].keyWindow;
            for (UIView *subView in keyWindow.subviews) {
                if ([subView isKindOfClass:[MBProgressHUD class]]) {
                    [subView removeFromSuperview];
                    break;
                }
    
            }
            if ([keyWindow isKindOfClass:[MMPopupWindow class]]) {
                keyWindow=[UIApplication sharedApplication].windows.firstObject;

            }
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:keyWindow animated:YES];
            hud.cornerRadius = 5; // 圆角半径不对.
            hud.opacity = 0.6;
            hud.mode = MBProgressHUDModeText;
            hud.detailsLabelFont = [UIFont systemFontOfSize:14];//[UIFont boldSystemFontOfSize:14.0];  // ?
            hud.detailsLabelText = tipStr;
            hud.margin = 10.f;
            hud.removeFromSuperViewOnHide = YES;
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [hud hide:YES afterDelay:1.0];
                });
            });
        });
    }
   }

+ (void)showHudTipStr:(NSString*)tipStr AndHideCallBackBlock:(void(^)())block{
    if (tipStr && tipStr.length > 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
        hud.cornerRadius = 5; // 圆角半径不对.
        hud.opacity = 0.6;
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabelFont = [UIFont systemFontOfSize:14];//[UIFont boldSystemFontOfSize:14.0];
        hud.detailsLabelText = tipStr;
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud showAnimated:YES whileExecutingBlock:^{
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (block) {
                    block();
                }
            });
        }];
        
    }
}

+ (void)showHudWithCheckmark:(NSString*)hubString AndHideCallBackBlock:(void(^)())block{
    //    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    //    [self.navigationController.view addSubview:hud];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
    
    // The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
    // Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
    
    UIImageView *checkmarkView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tanchukuang_chenggong"]];
    checkmarkView.bounds = CGRectMake(0, 0, 37, 37);
    checkmarkView.contentMode = UIViewContentModeTop;
    hud.customView = checkmarkView;
    // Set custom view mode
    hud.mode = MBProgressHUDModeCustomView;
    
    
    hud.labelText = hubString;
    
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            // something
            if (block) {
                block();
            }
        });
    }completionBlock:^{
        
    }];
}

- (BOOL)isExist {
    if (self == nil || self == NULL || [self isKindOfClass:[NSNull class]]) {
        return NO;
    }
    return YES;
}

@end
