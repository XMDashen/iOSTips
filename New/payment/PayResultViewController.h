//
//  PayResultViewController.h
//  DongDongWedding
//
//  Created by gyz on 16/8/25.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "DongDongBaseViewController.h"

@interface PayResultViewController : DongDongBaseViewController
@property(nonatomic,strong)IBOutlet UILabel *payResult;
@property(nonatomic,strong)IBOutlet UILabel *payAmount;
@property(nonatomic,strong)IBOutlet UILabel *orderNumber;
@property(nonatomic,strong)IBOutlet UILabel *orderTime;
@property(nonatomic,strong)IBOutlet UILabel *payWay;
@property(nonatomic,strong) NSString *orderId;
@property(nonatomic,assign) NSInteger pay;
@property(nonatomic,strong)IBOutlet UIImageView *fullisImage;
@property(nonatomic,strong)IBOutlet UIButton *detail;
@property(nonatomic, strong) NSString *dismiss;
@property(nonatomic, strong) NSString *order_pay_price;
@end
