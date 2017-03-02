//
//  UIViewController+Set.h
//  DongDongWedding
//
//  Created by sunny on 16/8/3.
//  Copyright © 2016年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>




@interface UIViewController (Set)


NS_ASSUME_NONNULL_BEGIN
/**
 *  @author zhaoming
 *
 *  设置左侧按钮的样式
 *
 *  @param title       title
 *  @param clickAction 点击事件
 */
- (void)setupLeftButtonWithTitle:(NSString *)title selection:(SEL)clickAction;
/**
 *  @author zhaoming
 *
 *  设置左侧按钮的样式
 *
 *  @param title       title
 *  @param clickAction 点击事件
 */
- (void)setupRightButtonWithTitle:(NSString *)title selection:(SEL)clickAction;
/**
 *  @author zhaoming
 *
 *  设置左侧按钮的样式
 *
 *  @param title       图片名
 *  @param clickAction 点击事件
 */
- (void)setupRightButtonWithImage:(NSString *)imageName selection:(SEL)clickAction;
//(nullable NSString *)otherButtonTitles, ...
- (void)setupRightButtonselection:(NSArray <NSString *> *)actionNames withImages:(NSArray <NSString *>*)imageNames selectImages:(NSArray <NSString *> *)selectImageNames;
- (void)setupRightButtonselection:(NSArray <NSString *> *)actionNames withTitles:(NSArray <NSString *>*)titles;
- (void)setupLeftButtonWithImage:(NSString *)imageName selection:(SEL)clickAction;
- (UIViewController *)currentController;
+ (UIViewController *)getCurrentVC;
NS_ASSUME_NONNULL_END
@end
