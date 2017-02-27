//
//  PayResultViewController.m
//  DongDongWedding
//
//  Created by gyz on 16/8/25.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "PayResultViewController.h"
#import "PayResultViewModel.h"
#import "MyOrderDetailModel.h"
#import "OrderDetailViewController.h"
#import "GrabOrderDetailController.h"
#import "CompleteViewController.h"
#import "ServingOrderDetailViewController.h"
#import "ProgramDeatailController.h"
@interface PayResultViewController ()<UINavigationControllerDelegate>

@end

@implementation PayResultViewController
{
    NSInteger orderStatus;
    NSString *email;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [DDSkin DDThemeTableViewBacColor];
    self.payWay.hidden = YES;
    self.payAmount.hidden = YES;
    self.payResult.hidden = YES;
    self.orderTime.hidden = YES;
    self.orderNumber.hidden = YES;
    self.fullisImage.hidden = YES;
    self.detail.hidden = YES;
    self.payResult.textColor = [DDSkin DDThemeRedColor];
    self.payResult.textAlignment = NSTextAlignmentCenter;
    self.payResult.text = @"";
    [self.detail setTitle:@"查看订单详情" forState:UIControlStateNormal];
    [self.detail setTitleColor:[DDSkin DDThemeRedColor] forState:UIControlStateNormal];
    self.navigationController.delegate = self;
    self.view.userInteractionEnabled = YES;
//    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(backHandle:)];
//    [self.view addGestureRecognizer:panGesture];
    [self downData];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated {

    [self setupLeftButtonWithImage:@"back_red" selection:@selector(leftbt)];
}
//- (void)backHandle:(UIPanGestureRecognizer *)recognizer
//{
//    [self leftbt];
//}
- (void)leftbt{
    if (![email isEqualToString:@""]) {
       
        ProgramDeatailController *prodeVc = [[ProgramDeatailController alloc]init];
        prodeVc.order_id = self.orderId;
        prodeVc.dismiss = @"detail";
        [self.navigationController pushViewController:prodeVc animated:YES];
      
        
    }else {
    if (orderStatus == 0) {
        OrderDetailViewController *detail = [[OrderDetailViewController alloc]init];
        detail.order_id = self.orderId;
        detail.dismiss = @"detail";
        [self.navigationController pushViewController:detail animated:YES];
    }else if (orderStatus == 1) {
        
        GrabOrderDetailController *grab = [[GrabOrderDetailController alloc] init];
        grab.order_id = self.orderId;
        grab.dismiss = @"detail";
        [self.navigationController pushViewController:grab animated:YES];
    }else if (orderStatus == 2) {
        ServingOrderDetailViewController *serving = [[ServingOrderDetailViewController alloc] init];
        serving.order_id = self.orderId;
        serving.dismiss = @"detail";
        [self.navigationController pushViewController:serving animated:YES];
    }
    }
    
}
- (void)downData {

    PayResultViewModel *viewModel = [[PayResultViewModel alloc]init];
    
    viewModel.orderId = self.orderId;
    [viewModel DownDataWithSuccess:^(id successData) {
        NSLog(@"successData-->>%@",successData);
        self.payWay.hidden = NO;
        self.payAmount.hidden = NO;
        self.payResult.hidden = NO;
        self.orderTime.hidden = NO;
        self.orderNumber.hidden = NO;
        self.fullisImage.hidden = NO;
        self.detail.hidden = NO;
        self.payAmount.text = [NSString stringWithFormat:@"订单金额：%@",self.order_pay_price];
        self.orderNumber.text = [NSString stringWithFormat:@"订单号：%@",self.orderId];
        NSString *ordertime = [DateTimestamp date:successData[@"create_time"]];
        self.orderTime.text = [NSString stringWithFormat:@"下单时间：%@",ordertime];
        orderStatus = [successData[@"status"] integerValue];
        email = successData[@"email"] ;
        NSInteger paystatus = [successData[@"is_success"] integerValue];
        if (self.pay == 0) {
            self.payWay.text = @"支付方式：支付宝";
        }else {
        
            self.payWay.text = @"支付方式：微信";
        }
        if (paystatus == 0) {
            self.payResult.text = @"支付失败";
            self.fullisImage.highlighted = YES;
        }
        if (paystatus == 1) {
            self.payResult.text = @"支付成功";
        }
       
    } error:^BOOL(id errorData) {
        NSLog(@"%@",errorData);
        return YES;
    }];

}
- (IBAction)oderDetail:(id)sender {
    
    if (![email isEqualToString:@""]) {
        ProgramDeatailController *prodeVc = [[ProgramDeatailController alloc]init];
        prodeVc.order_id = self.orderId;
        prodeVc.dismiss = @"detail";
        [self.navigationController pushViewController:prodeVc animated:YES];

    }else {

    if (orderStatus == 0) {
        OrderDetailViewController *detail = [[OrderDetailViewController alloc]init];
        detail.order_id = self.orderId;
        detail.dismiss = @"detail";
        [self.navigationController pushViewController:detail animated:YES];
    }else if (orderStatus == 1) {
        
        GrabOrderDetailController *grab = [[GrabOrderDetailController alloc] init];
        grab.order_id = self.orderId;
        grab.dismiss = @"detail";
        [self.navigationController pushViewController:grab animated:YES];
    }else if (orderStatus == 2) {
        ServingOrderDetailViewController *serving = [[ServingOrderDetailViewController alloc] init];
        serving.order_id = self.orderId;
        serving.dismiss = @"detail";
        [self.navigationController pushViewController:serving animated:YES];
    }
    
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
