//
//  HomeBaseTableController.h
//  DongDongWedding
//
//  Created by sunny on 16/8/2.
//  Copyright © 2016年 gl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DongDongBaseViewController.h"

@interface HomeBaseTableController : DongDongBaseViewController
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, assign) BOOL useMJFooter;
@property (nonatomic, assign) BOOL useMJHeader;
@property (nonatomic,assign) UITableViewStyle style;
- (instancetype)initWithTableStyle:(UITableViewStyle)style;

/**
 *  @author zhaoming
 *
 *  结束加载更多数据
 */
- (void)endLoadingMoredata;
/**
 *  @author zhaoming
 *
 *  开始加载更多数据
 */
- (void)startLoadMoreData;
/**
 *  @author zhaoming
 *
 *  结束加载数据
 */
- (void)startLoadSource;

/**
 *  @author zhaoming
 *
 *  开始加载数据
 */
- (void)endLoadSource;
/**
 *  @author zhaoming
 *
 *  没有更多数据
 */
- (void)noData;


- (void)configHeader;
- (void)configFooter;

@end
