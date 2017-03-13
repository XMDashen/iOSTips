//
//  XMDatePickerView.h
//  furnitureSale
//
//  Created by apple on 16/9/18.
//  Copyright © 2016年 wxm. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XMDatePickerDelegate <NSObject>

@optional
//确认时期选择
-(void)datePickerDidFinishPickWithPickerView:(UIDatePicker *)datePicker;

//取消时期选择
-(void)datePickerDidCancel:(UIDatePicker *)datePicker;

@end

@interface XMDatePickerView : UIView

-(void)showDatePickerOnWindow;

-(void)configDatePickerWith:(UIDatePickerMode)mode initTime:(NSDate *)initTime maxTime:(NSDate *)maxTime minTime:(NSDate *)minTime;

@property(nonatomic,weak) id<XMDatePickerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end
