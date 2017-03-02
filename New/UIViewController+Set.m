//
//  UIViewController+Set.m
//  DongDongWedding
//
//  Created by sunny on 16/8/3.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "UIViewController+Set.h"
#import "XCDFormInputAccessoryView.h"
#import <objc/runtime.h>
@implementation UIViewController (Set)

+ (void)load {
    Method originMethod = class_getInstanceMethod(self, @selector(viewDidLoad));
    Method swizzingMethod = class_getInstanceMethod(self, @selector(customViewDidLoad));
    method_exchangeImplementations(originMethod, swizzingMethod);
}
- (void)customViewDidLoad {
    
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//    UIButton *btn = [UIButton ]
//    UIBarButtonItem *backButtonItem = [UIBarButtonItem alloc] initWithCustomView:<#(nonnull UIView *)#>
//    self.navigationItem.backBarButtonItem = [UIBarButtonItem alloc]
    
    
    if ([self isKindOfClass:NSClassFromString(@"_UIRemoteInputViewController")] || [self isKindOfClass:NSClassFromString(@"UIInputWindowController")]) {
        return;
    }
    if (self.navigationController.viewControllers.count > 0) {
        self.navigationController.hidesBottomBarWhenPushed = YES;
    }
    if ([self isKindOfClass:[NSClassFromString(@"WXOMessageInputMorePanelViewController") class]]) {
        return;
    }
    
//    for (UIView *subView in self.view.subviews) {
//        if ([subView isKindOfClass:[UITextField class]] || [subView isKindOfClass:[UITextView class]]) {
//            if ([subView isKindOfClass:[UITextField class]]) {
//                UITextField *textField = (UITextField *)subView;
//                textField.inputAccessoryView = [XCDFormInputAccessoryView new];
//            }
//            if ([subView isKindOfClass:[UITextView class]]) {
//                UITextView *textField = (UITextView *)subView;
//                textField.inputAccessoryView = [XCDFormInputAccessoryView new];
//            }
//        }
//    }
    
   
}

- (void)setupLeftButtonWithTitle:(NSString *)title selection:(SEL)clickAction {
    
    self.navigationItem.leftBarButtonItem = [self setUpBarButtonItemWithTitle:title action:clickAction];
}
- (void)setupLeftButtonWithImage:(NSString *)imageName selection:(SEL)clickAction {
    UIButton *button = [self configButton];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:self action:clickAction forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barbuttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barbuttonItem;
    
}
- (void)setupRightButtonWithTitle:(NSString *)title selection:(SEL)clickAction {
    self.navigationItem.rightBarButtonItem = [self setUpBarButtonItemWithTitle:title action:clickAction];
    
}

- (void)setupRightButtonselection:(NSArray <NSString *>*)actionNames withImages:(NSArray<NSString *> *)imageNames selectImages:(NSArray<NSString *> *)selectImageNames {
    NSMutableArray *barbuttonItems = @[].mutableCopy;
    for (int i = 0; i < actionNames.count; i ++) {
        UIBarButtonItem *barButtonItem = [self setUpBarButtonItemWithImage:imageNames[i] action:NSSelectorFromString(actionNames[i]) selectImageName:selectImageNames[i]];
        [barbuttonItems addObject:barButtonItem];
    }
    self.navigationItem.rightBarButtonItems = barbuttonItems;
    
   
}

- (void)setupRightButtonselection:(NSArray<NSString *> *)actionNames withTitles:(NSArray<NSString *> *)titles {
    NSMutableArray *barbuttonItems = @[].mutableCopy;
    for (int i = 0; i < actionNames.count; i ++) {
        UIBarButtonItem *barButtonItem = [self setUpBarButtonItemWithTitle:titles[i] action:NSSelectorFromString(actionNames[i])];
        [barbuttonItems addObject:barButtonItem];
    }
    self.navigationItem.rightBarButtonItems = barbuttonItems;
}

- (void)setupRightButtonWithImage:(NSString *)imageName selection:(SEL)clickAction {
    UIButton *button = [self configButton];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:self action:clickAction forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barbuttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barbuttonItem;
    
}



#pragma mark -- 设置 customview

- (UIBarButtonItem *)setUpBarButtonItemWithTitle:(NSString *)title action:(SEL)action{
    UIButton *btn = [self configButton];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = DDFONT(15);
    [btn setTitleColor:[DDSkin DDThemeRedColor] forState:UIControlStateNormal];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barbuttonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return barbuttonItem;
}
- (UIBarButtonItem *)setUpBarButtonItemWithImage:(NSString *)imageName action:(SEL)action{
    UIButton *btn = [self configButton];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barbuttonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return barbuttonItem;
}
- (UIBarButtonItem *)setUpBarButtonItemWithImage:(NSString *)imageName action:(SEL)action selectImageName:(NSString *)selectImageName {
    UIButton *btn = [self configButton];
    if (imageName.length != 0) {
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (selectImageName.length != 0) {
        [btn setImage:[UIImage imageNamed:selectImageName] forState:UIControlStateSelected];
    }
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barbuttonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return barbuttonItem;
}


- (UIButton *)configButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    return button;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [super touchesEnded:touches withEvent:event];
}

- (UIViewController *)currentController
{
    UIResponder *responder = [self nextResponder];
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}

+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}




@end
