//
//  CountDownButton.m
//  Eoffice1.0
//
//  Created by gyz on 15/11/10.
//  Copyright (c) 2015年 gl. All rights reserved.
//

#import "CountDownButton.h"

@implementation CountDownButton

-(void)dealloc
{
    //销毁
    if ([_timer isValid]) {
        [_timer invalidate];
    }
}
//没有点击的时候的标题
-(instancetype)initWithFrame:(CGRect)frame WithBtnTitle:(NSString *)startTitle
{
    if (self=[super initWithFrame:frame]) {
        _startTitle=startTitle;
        self.titleLabel.font=[UIFont systemFontOfSize:12];
        [self setTitle:startTitle forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor redColor]];
    }
    return self;
}

- (void)buttonWithTitle:(NSString *) startTitle {
    
    [self setTitle:startTitle forState:UIControlStateNormal];
    _startTitle=startTitle;
    
    
}
//开始计时
-(void)startWithSecond:(int)totalSecond
{
    _totalSecond=totalSecond;
    _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChangeStart:) userInfo:nil repeats:YES];
    [_timer setFireDate:[NSDate distantPast]];
}
-(void)timeChangeStart:(NSTimer *)timer
{
    if (_totalSecond>1) {
        self.enabled=NO;
        _totalSecond--;
        [self setTitle:[NSString stringWithFormat:@"%d秒倒计时",_totalSecond] forState:UIControlStateNormal];
    }
    else
    {
        self.enabled=YES;
        [_timer setFireDate:[NSDate distantFuture]];
        [self setTitle:_startTitle forState:UIControlStateNormal];
    }
    
}

@end
