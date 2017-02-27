//
//  SurePaymentViewController.m
//  DongDongWedding
//
//  Created by gyz on 16/8/7.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "SurePaymentViewController.h"
#import "PlaceOrderTableViewCell.h"
#import "WeddingInformationCell.h"
#import "WeddingCaseCell.h"
#import "PayAmountCell.h"
#import "PayWayCell.h"
#import "OrderDetailViewModel.h"
#import "MyOrderDetailModel.h"
#import "NSString+md5String.h"
//APP端签名相关头文件
#import "payRequsestHandler.h"

//服务端签名只需要用到下面一个头文件
//#import "ApiXml.h"
#import <QuartzCore/QuartzCore.h>

#import "WXApiObject.h"
#import "WXApi.h"
#import "WXApiManager.h"

#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WechatViewModel.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "PayResultViewController.h"
#import "GoodsDetailedCell.h"
#import "SecondGoodsDeatialCell.h"
#import "AggregateAmountCell.h"
#import "OrderDetailViewController.h"
#import "ProgramDeatailController.h"
#import "GrabOrderDetailController.h"
#import "ServingOrderDetailViewController.h"
NSString * const SurePlaceOrderCellIdentifier = @"PlaceOrderTableViewCell";
NSString * const SureWeddingInformationIdentifier = @"WeddingInformationCell";

NSString * const SureWeddingCaseCellIdentifier = @"WeddingCaseCell";

NSString *const SurePayAmountCellIdentifier = @"AggregateAmountCell";
NSString *const SurePayWayCellIdentifier = @"PayWayCell";
NSString * const SureGoodsDetailedCellIdentifier = @"GoodsDetailedCell";
NSString * const SureSecondGoodsDeatialCellIdentifier = @"SecondGoodsDeatialCell";
NSString * const SureAggregateAmountCellIdentifier = @"AggregateAmountCell";

@interface SurePaymentViewController () <UITableViewDelegate,UITableViewDataSource,PayWayDelegate,WXApiDelegate,UIGestureRecognizerDelegate,UINavigationControllerDelegate,titlesDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@end

@implementation SurePaymentViewController
{
    NSInteger selectPayWay;
    NSString *order_id;
    NSMutableDictionary *weChat;
    BOOL isSelectDetail;
    BOOL isAply;
    NSString *order_pay_price;
    NSString *email;
    NSInteger orderStatus;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    selectPayWay = 0;
    isAply = YES;
    self.title = @"支付中心";
    _datas = [NSMutableArray array];
    weChat = [[NSMutableDictionary alloc] init];
    //向微信注册
    [WXApi registerApp:APP_ID withDescription:@"demo 2.0"];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    self.surePayBt.hidden = YES;
    self.reminderLb.text = @"订单已经提交，请在72个小时内完成支付，逾期订单将关闭！";
    self.reminderLb.textAlignment = NSTextAlignmentCenter;
    self.reminderLb.hidden = YES;
    self.navigationController.delegate = self;
    self.view.userInteractionEnabled = YES;
    UISwipeGestureRecognizer *panGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backHandle:)];
    [self.view addGestureRecognizer:panGesture];
    self.automaticallyAdjustsScrollViewInsets = NO;
    panGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self DownData];
    [self initUI];
    // Do any additional setup after loading the view from its nib.
}
- (void)backHandle:(UISwipeGestureRecognizer *)recognizer
{
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
       [self leftbt];
    }else {
        NSLog(@"sdf");
    }
    
}
- (void)customControllerPopHandle:(UIPanGestureRecognizer *)recognizer
{

}

- (void)leftbt
{
    if (![email isEqualToString:@""]) {
        
        ProgramDeatailController *prodeVc = [[ProgramDeatailController alloc]init];
        prodeVc.order_id = self.order_id;
        prodeVc.dismiss = @"detail";
        [self.navigationController pushViewController:prodeVc animated:YES];
        
        
    }else {
        if (orderStatus == 0) {
            OrderDetailViewController *detail = [[OrderDetailViewController alloc]init];
            detail.order_id = self.order_id;
            detail.dismiss = @"detail";
            [self.navigationController pushViewController:detail animated:YES];
        }else if (orderStatus == 1) {
            
            GrabOrderDetailController *grab = [[GrabOrderDetailController alloc] init];
            grab.order_id = self.order_id;
            grab.dismiss = @"detail";
            [self.navigationController pushViewController:grab animated:YES];
        }else if (orderStatus == 2) {
            ServingOrderDetailViewController *serving = [[ServingOrderDetailViewController alloc] init];
            serving.order_id = self.order_id;
            serving.dismiss = @"detail";
            [self.navigationController pushViewController:serving animated:YES];
        }
    }
    
    
}
- (void)DownData {
    [_datas removeAllObjects];
    OrderDetailViewModel *viewModel = [[OrderDetailViewModel alloc]init];
    viewModel.order_id = self.order_id;
    [viewModel DownDataWithSuccess:^(id successData) {
        NSLog(@"successData-->>%@",successData);
        MyOrderDetailModel *model =  [MyOrderDetailModel modelWithDic:successData];
        orderStatus = [model.orderNumModel.status integerValue];
        email = model.orderNumModel.email ;
        [_datas addObject:model];
        [self initNavigationBar];
        [_tableView reloadData];
    } error:^BOOL(id errorData) {
        NSLog(@"%@",errorData);
        return YES;
    }];
    
    
}
- (void)initUI{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+20, SCREEN_WIDTH, SCREEN_HEIGHT-120-20) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:SurePlaceOrderCellIdentifier bundle:nil] forCellReuseIdentifier:SurePlaceOrderCellIdentifier];
    
    [_tableView registerNib:[UINib nibWithNibName:SureWeddingInformationIdentifier bundle:nil] forCellReuseIdentifier:SureWeddingInformationIdentifier];
    
    [_tableView registerNib:[UINib nibWithNibName:SureWeddingCaseCellIdentifier bundle:nil] forCellReuseIdentifier:SureWeddingCaseCellIdentifier];
    
    [_tableView registerNib:[UINib nibWithNibName:SurePayAmountCellIdentifier bundle:nil] forCellReuseIdentifier:SurePayAmountCellIdentifier];
    [_tableView registerNib:[UINib nibWithNibName:SurePayWayCellIdentifier bundle:nil] forCellReuseIdentifier:SurePayWayCellIdentifier];
    [_tableView registerNib:[UINib nibWithNibName:SureGoodsDetailedCellIdentifier bundle:nil] forCellReuseIdentifier:SureGoodsDetailedCellIdentifier];
    
    [_tableView registerNib:[UINib nibWithNibName:SureSecondGoodsDeatialCellIdentifier bundle:nil] forCellReuseIdentifier:SureSecondGoodsDeatialCellIdentifier];
    
    [_tableView registerNib:[UINib nibWithNibName:SureAggregateAmountCellIdentifier bundle:nil] forCellReuseIdentifier:SureAggregateAmountCellIdentifier];
    
    [self.view addSubview:_tableView];
    _tableView.userInteractionEnabled = YES;
    if ([_firstPay isEqualToString:@"first"]) {
        self.reminderLb.hidden = NO;
    }else {
    
        self.reminderLb.hidden = YES;
    }
    
    
    
}

- (void)initNavigationBar {
    self.surePayBt.hidden = NO;
    [self.surePayBt setTitle:@"确认支付" forState:UIControlStateNormal];
    [self.surePayBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.surePayBt.backgroundColor = [UIColor colorWithHexString:@"FC5777"];
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.isDeatil isEqualToString:@"nodetail"]) {
        return 4;
    }else {
    return 5;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1*_datas.count;
    }else if (section == 1) {
        return 2*_datas.count;
    }else if (section == 2) {
        if ([self.isDeatil isEqualToString:@"nodetail"]) {
            return 1*_datas.count;
        }else {
            if (isSelectDetail == YES) {
                return 2*_datas.count;
            }else {
                return 1*_datas.count;
            }
        }
    }else if (section == 3) {
        if ([self.isDeatil isEqualToString:@"nodetail"]) {
            return 2*_datas.count;
        }else {

            return 1*_datas.count;
        }
    }else {
        
        return 2*_datas.count;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0 ) {
            return [tableView fd_heightForCellWithIdentifier:SurePlaceOrderCellIdentifier
                                            cacheByIndexPath:indexPath
                                               configuration:^(PlaceOrderTableViewCell *cell) {
                                                   MyOrderDetailModel *model = _datas[0];
                                                   [cell generateOrderDetailCell:model];
                                                   
                                               }];
        }else{
            return [tableView fd_heightForCellWithIdentifier:SurePayAmountCellIdentifier
                                            cacheByIndexPath:indexPath
                                               configuration:^(AggregateAmountCell *cell) {
                                                   MyOrderDetailModel *model = _datas[0];
                                                   [cell generateOrderDetailCell:model];
                                                   
                                               }];
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 40;
        }else {
        return [tableView fd_heightForCellWithIdentifier:SureWeddingCaseCellIdentifier
                                        cacheByIndexPath:indexPath
                                           configuration:^(WeddingCaseCell *cell) {
                                               MyOrderDetailModel *model = _datas[0];
                                               [cell generateOrderDetailCell:model];
                                               
                                           }];
        }
    }
    else if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            return 40;
        }else {
            if ([self.isDeatil isEqualToString:@"nodetail"]) {
                return [tableView fd_heightForCellWithIdentifier:SureAggregateAmountCellIdentifier
                                                cacheByIndexPath:indexPath
                                                   configuration:^(AggregateAmountCell *cell) {
                                                       
                                                       
                                                       
                                                   }];
            }else {

            return [tableView fd_heightForCellWithIdentifier:SureSecondGoodsDeatialCellIdentifier
                                            cacheByIndexPath:indexPath
                                               configuration:^(SecondGoodsDeatialCell *cell) {
                                                   MyOrderDetailModel *model = _datas[0];
                                                   [cell generateOrderDetailCell:model];
                                                   
                                               }];
            }
        }
        
        
    }
    else if (indexPath.section == 3) {
        if ([self.isDeatil isEqualToString:@"nodetail"]) {
            return [tableView fd_heightForCellWithIdentifier:SurePayWayCellIdentifier
                                            cacheByIndexPath:indexPath
                                               configuration:^(PayWayCell *cell) {
                                                   
                                                   
                                                   
                                               }];
        }else {
            return [tableView fd_heightForCellWithIdentifier:SureAggregateAmountCellIdentifier
                                            cacheByIndexPath:indexPath
                                               configuration:^(AggregateAmountCell *cell) {
                                                   
                                                   
                                                   
                                               }];
        }
        
        
    }
    else {
        
        return [tableView fd_heightForCellWithIdentifier:SurePayWayCellIdentifier
                                        cacheByIndexPath:indexPath
                                           configuration:^(PayWayCell *cell) {
                                               
                                               
                                               
                                           }];
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0&&[_firstPay isEqualToString:@"first"]) {
        return 1;
    }else {
    return 10;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
            PlaceOrderTableViewCell *cell = [PlaceOrderTableViewCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            MyOrderDetailModel *model = _datas[0];
            [cell generateOrderDetailCell:model];
            
            return cell;
        
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            GoodsDetailedCell *cell = [GoodsDetailedCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            MyOrderDetailModel *model = _datas[0];
            cell.titles = @"2";
            cell.delegate = self;
            [cell generateOrderDetailCell:model];
            return cell;
        }else {
            WeddingCaseCell *cell = [WeddingCaseCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.submit = @"submit";
            MyOrderDetailModel *model = _datas[0];
            [cell generateOrderDetailCell:model];
            return cell;
        }
        
    }else if (indexPath.section == 2) {
        if ([self.isDeatil isEqualToString:@"nodetail"]) {
            AggregateAmountCell  *cell = [AggregateAmountCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            MyOrderDetailModel *model = _datas[0];
            order_pay_price = model.orderNumModel.order_pay_price;
            [cell generateOrderDetailCell:model];
            return cell;
        }else {
            if (indexPath.row == 0) {
                
                GoodsDetailedCell *cell = [GoodsDetailedCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                MyOrderDetailModel *model = _datas[0];
                cell.titles = @"3";
                cell.delegate = self;
                cell.isSelect = isSelectDetail;
                [cell generateOrderDetailCell:model];
                return cell;
            }else {
                
                SecondGoodsDeatialCell  *cell = [SecondGoodsDeatialCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                MyOrderDetailModel *model = _datas[0];
                cell.type = @"second";
                [cell generateOrderDetailCell:model];
                return cell;
                
            }
            
        }
        
        
    }else if (indexPath.section == 3) {
        if ([self.isDeatil isEqualToString:@"nodetail"]) {
            PayWayCell *cell = [PayWayCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
            cell.delegate = self;
            if (isAply == YES) {
                isAply = NO;
                cell.isApy = YES;
            }
            if (indexPath.row == 1) {
                cell.lineView.hidden = YES;
                [cell.payWayImage setImage:[UIImage imageNamed:@"wechat"]];
                cell.payWayLb.text = @"微信支付";
                cell.safetyLb.text = @"微信安全支付";
            }
            [cell generateCell:indexPath.row +10];
            return cell;
        }else {
            AggregateAmountCell  *cell = [AggregateAmountCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            MyOrderDetailModel *model = _datas[0];
            order_pay_price = model.orderNumModel.order_pay_price;
            [cell generateOrderDetailCell:model];
            return cell;
            
        }
        
    }

    else {
        PayWayCell *cell = [PayWayCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        cell.delegate = self;
        if (isAply == YES) {
            isAply = NO;
            cell.isApy = YES;
        }
        if (indexPath.row == 1) {
            cell.lineView.hidden = YES;
            [cell.payWayImage setImage:[UIImage imageNamed:@"wechat"]];
            cell.payWayLb.text = @"微信支付";
            cell.safetyLb.text = @"微信安全支付";
        }
        [cell generateCell:indexPath.row +10];
        return cell;
    }
}
- (void)payWayChoose:(NSInteger)tag {
    
    selectPayWay = tag;
    if (tag == 0) {
        UIButton *button = [self.view viewWithTag:11];
        button.selected = NO;
    }else{
        
        UIButton *button = [self.view viewWithTag:10];
        button.selected = NO;
    }
    
}
- (void)moreDetail:(NSString *)titles {
    
   if ([titles isEqualToString:@"3"]) {
        
        isSelectDetail =! isSelectDetail;
        [_tableView reloadData];
        
    }
}
- (IBAction)surePay:(id)sender {
    
    MyOrderDetailModel *model = _datas[0];
    [MobClick event:@"surePay" attributes:@{@"order_id" :model.orderNumModel.order_id} counter:[model.orderNumModel.order_pay_price intValue]];
    if (selectPayWay == 0) {
        [self alipay];
    }else {
        order_id = model.orderNumModel.order_id;
        [self sendPay];
        
    }
    
    
}


//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alter show];
    
}
- (void)payAlert:(NSString *)title {
    
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:@"完成支付" otherButtonTitles:@"未支付", nil];
    
    [alter show];
    
}
- (void)sendPay
{
    
    WechatViewModel *viewModel = [[WechatViewModel alloc]init];
    viewModel.order_id = self.order_id;
    [viewModel DownDataWithSuccess:^(id successData) {
        NSLog(@" %@",successData);
        weChat = successData[@"data"];
        [self toWechatPay];
    } error:^BOOL(id errorData) {
        NSLog(@"%@",errorData);
        return YES;
    }];
    
    
}

- (void)toWechatPay {


    if(weChat != nil){
            
            NSMutableString *stamp  = [weChat objectForKey:@"timestamp"];
        NSLog(@"%@",weChat);
            //调起微信支付
            PayReq* req             = [[PayReq alloc] init];
            req.openID              = [weChat objectForKey:@"appid"];
        NSLog(@"%@",req.openID);
            req.partnerId           = [weChat objectForKey:@"partnerid"];
        NSLog(@"%@",req.partnerId);
            req.prepayId            = [weChat objectForKey:@"prepayid"];
            req.nonceStr            = [weChat objectForKey:@"noncestr"];
            req.timeStamp           = stamp.intValue;
            req.package             = [weChat objectForKey:@"package"];
            req.sign                = [weChat objectForKey:@"sign"];
            [WXApi sendReq:req];
            //日志输出
            NSLog(@"---****---appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",req.openID,req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
        }else{
            [self alert:@"提示信息" msg:[weChat objectForKey:@"retmsg"]];
        }
    [self payResult];

}

- (void)alipay{
    
    NSString *partner = @"2088121657907352";
    NSString *seller = @"847939957@qq.com";
    NSString *privateKey = @"MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBANFvt6y9Q4cM3OV5hDCVeg7LzKcwDJvxkR3XZTXcTb/6mblJP1ojl/itCObid/B3ObYHo9zmL9wigDddCRXtykgEg6TAaeC/C5X7+aSSxeFRBx7EnRjfeM6hIS1LKNqubwZu97PmJkVmL0YUajMEfCrhGdavy0B2g5kO+Q9K09ezAgMBAAECgYBhhej8acEpAMdXn6b7TI9ilmm8rDYi43CUebkqRGR78cBlNANpAMwCQuizQl9hPNNFvPcDpLhChFo57XuOl4Sp/ouatymdPL6D8UqtKp+uXno9rbTX0hiO4P6cA14ZDyTy6Qy8o64jBh/OQ2R+WGplJ7D1g7VnLgDA318Bgdfy0QJBAPB83VKUffPOW9+ssewef1zj5dbF2RhDCtbyQuYJ7aw6Pzhdo4KrhtTOPo3xPWx1TuUbfo12HDUXQ1nvGYXct2kCQQDe8htedmnP8oTue/z7wlgcwDmoydsyhjrlsb8q+jI7DoiITY+iYVzLbB24ZWYhQsRgrK+wwfyfpXjDRpHk3S67AkAEpUTZPYkZVpkrvvhI6WXoc3aTKYtCDrl84X0tWG/A7fceraBk+89E+R74OvrGx5VYk6lkLi3pUKO6bwX9MgBRAkAn5KyvD4NJmXzd68PODO2VX3Qx1sTpWomJdm/dsd1xId2efjp4dPGU2OjMiSBoTTk0j1H00BFzQ7nDP4p1qHpnAkBJGEPmW7FuFjY9x4LGqH8C9FqfXdqp8/++51nhCAbe5g31n4Snsx8IAi4jIv+PDjICOWxnPMaCkUF1lLOv4SRQ";
    MyOrderDetailModel *model = _datas[0];
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.sellerID = seller;
    NSString *randomString =[[NSString alloc]init];
    for (int i = 0; i < 12; i++) {
            int figure = arc4random() % 12;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            randomString = [randomString stringByAppendingString:tempString];
    }
    NSLog(@"%@",randomString);
    order.outTradeNO = randomString; //订单ID（由商家自行制定）
    
    order.subject = model.orderNumModel.order_id; //商品标题
    order.body = @"dongdongwedding"; //商品描述
    double price;
    price = [(model.moneyModel.payMoney)doubleValue];
    NSString *totalPrice = [NSString stringWithFormat:@"%.0f",price];
    order.totalFee = totalPrice; //商品价格
//    order.totalFee = @"0.01";
    order.notifyURL =  [NSString stringWithFormat:@"%@%@",kBaseUrl,PAYURL];  //回调URL
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    //    order.showURL = @"m.alipay.com";
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"dongdongAlipay";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            
            [self payResult];
        }];
    }
}

- (void)payResult{

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"支付结果" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"完成支付" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        PayResultViewController *result = [[PayResultViewController alloc]init];
        result.orderId = self.order_id;
        result.pay = selectPayWay;
        result.order_pay_price = order_pay_price;
        result.dismiss = self.dismiss;
        [self.navigationController pushViewController:result animated:YES];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"支付遇到问题" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        PayResultViewController *result = [[PayResultViewController alloc]init];
        result.orderId = self.order_id;
        result.pay = selectPayWay;
        result.order_pay_price = order_pay_price;
        result.dismiss = self.dismiss;
        [self.navigationController pushViewController:result animated:YES];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [self setupLeftButtonWithImage:@"back_red" selection:@selector(leftbt)];
   
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [MobClick endLogPageView:@"payCenter"];
   
}
- (void)viewWillDisappear:(BOOL)animated {

   
//        self.navigationController.interactivePopGestureRec ognizer.enabled = YES;
  
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
