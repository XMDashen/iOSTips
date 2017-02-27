//
//  SurePaymentViewController.h
//  DongDongWedding
//
//  Created by gyz on 16/8/7.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "DongDongBaseViewController.h"

@interface SurePaymentViewController : DongDongBaseViewController
@property(nonatomic, weak)IBOutlet UIButton *surePayBt;
@property (nonatomic, weak)IBOutlet UILabel *reminderLb;
@property (nonatomic, strong) NSString *order_id;
@property (nonatomic, strong) NSString *firstPay;
@property (nonatomic, strong) NSString *dismiss;
@property (nonatomic, strong) NSString *isDeatil;
@end
