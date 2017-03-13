//
//  XMDatePickerView.m
//  furnitureSale
//
//  Created by apple on 16/9/18.
//  Copyright © 2016年 wxm. All rights reserved.
//

#import "XMDatePickerView.h"

@interface XMDatePickerView ()

@property(nonatomic,strong) UIView *pickerBackgroundView;

@end

@implementation XMDatePickerView

-(void)showDatePickerOnWindow{
    
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    
    CGFloat pickerX=0;
    CGFloat pickerY=window.bounds.size.height*2/3.0;
    CGFloat pickerW=window.bounds.size.width;
    CGFloat pickerH=window.bounds.size.height/3.0;
    
    self.frame=CGRectMake(pickerX, pickerY, pickerW, pickerH);
    
    //***背景视图层***
    _pickerBackgroundView=[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    _pickerBackgroundView.alpha=0.3;
    _pickerBackgroundView.backgroundColor=[UIColor blackColor];
    
    [window addSubview:_pickerBackgroundView];
    [window addSubview:self];
}

-(void)configDatePickerWith:(UIDatePickerMode)mode initTime:(NSDate *)initTime maxTime:(NSDate *)maxTime minTime:(NSDate *)minTime{
    
    //***时间选择器***
    self.frame=CGRectZero;
    
    //属性设置
    //模式
    self.datePicker.datePickerMode=mode;
    
    //初始化时间
    self.datePicker.date=initTime;
    
    //最小时间(日期)
    if (minTime) {
        
        self.datePicker.minimumDate=minTime;
    }
    
    //最大时间
    if (maxTime) {
        
        self.datePicker.maximumDate=maxTime;
    }
    
    //设置地区
    self.datePicker.locale=[NSLocale localeWithLocaleIdentifier:@"zh"];
}

//取消按钮点击
- (IBAction)cancelButtonClick:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(datePickerDidCancel:)]) {
        [self.delegate datePickerDidCancel:self.datePicker];
    }
    
    [self.pickerBackgroundView removeFromSuperview];
    [self removeFromSuperview];
}

//确认按钮点击
- (IBAction)confirmButtonClick:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(datePickerDidFinishPickWithPickerView:)]) {
        [self.delegate datePickerDidFinishPickWithPickerView:self.datePicker];
    }
    
    [self.pickerBackgroundView removeFromSuperview];
    [self removeFromSuperview];
}

@end
