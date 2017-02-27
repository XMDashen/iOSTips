//
//  CountDownButton.h
//  Eoffice1.0
//
//  Created by gyz on 15/11/10.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountDownButton : UIButton
{
    int _totalSecond;//总时间
    NSTimer *_timer;//定时器
    NSString *_startTitle;//点击开始计时
}


-(instancetype)initWithFrame:(CGRect)frame WithBtnTitle:(NSString *)startTitle;
- (void)buttonWithTitle:(NSString *) startTitle;
-(void)startWithSecond:(int)totalSecond;


@end
