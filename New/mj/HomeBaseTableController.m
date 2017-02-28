//
//  HomeBaseTableController.m
//  DongDongWedding
//
//  Created by sunny on 16/8/2.
//  Copyright © 2016年 gl. All rights reserved.
//

#import "HomeBaseTableController.h"
#import "MJRefresh.h"

@interface HomeBaseTableController ()


@end

@implementation HomeBaseTableController

- (instancetype)initWithTableStyle:(UITableViewStyle)style {
    if (self = [super init]) {
       
    }
    return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    _useMJFooter = YES;
    _useMJHeader = YES;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:_style];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor=[DDSkin DDThemeTableViewBacColor];
    self.tableView.tableFooterView = [UIView new];
    if (self.useMJFooter) {
        [self configFooter];
    }
    if (self.useMJHeader) {
        [self configHeader];
    }
}


#pragma mark -- 配置MJRefresh header 和 footer
- (void)configHeader {
    NSMutableArray *images = @[].mutableCopy;
    for (int i = 1; i <= 8; i ++) {
        NSString *str = i < 10 ? [NSString stringWithFormat:@"0%d",i] : [NSString stringWithFormat:@"%d",i];
        NSString *imageName = [NSString stringWithFormat:@"window_loading%@.png",str];
        UIImage *image = [UIImage imageNamed:imageName];
        [images addObject:image];
    }
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDataSource)];
    [header setImages:images duration:1.0f forState:MJRefreshStateRefreshing];
    [header setImages:images duration:1.0f forState:MJRefreshStateIdle];
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // Hide the status
    header.stateLabel.hidden = YES;
    _tableView.mj_header = header;
}

- (void)configFooter {
    NSMutableArray *images = @[].mutableCopy;
    for (int i = 1; i <= 8; i ++) {
        NSString *str = i < 10 ? [NSString stringWithFormat:@"0%d",i] : [NSString stringWithFormat:@"%d",i];
        NSString *imageName = [NSString stringWithFormat:@"window_loading%@.png",str];
        UIImage *image = [UIImage imageNamed:imageName];
        [images addObject:image];
    }

    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDataSource)];
    footer.automaticallyRefresh = NO;
    [footer setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"松手开始加载" forState:MJRefreshStatePulling];
    [footer setTitle:@"加载中" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
    _tableView.mj_footer = footer;
    
}


//- (void)loadDataSource {
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [_tableView.mj_header endRefreshing];
//    });
//}

//- (void)loadMoreDataSource {
//    
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [_tableView.mj_footer endRefreshing];
//    });
//}



- (void)startLoadMoreData {
    [_tableView.mj_footer beginRefreshing];
}

- (void)noData {
    
    _tableView.mj_footer.state = MJRefreshStateNoMoreData;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            _tableView.mj_footer.alpha=0;
        }];
    });
 
}

- (void)startLoadSource {
    [_tableView.mj_header beginRefreshing];
}
- (void)endLoadingMoredata {
    [_tableView.mj_footer endRefreshing];
}
- (void)endLoadSource {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_tableView.mj_header endRefreshing];
    });
}
-(void)setTableViewFrame:(CGRect)tableViewFrame
{
    self.tableView.frame=tableViewFrame;
}

-(void)setUseMJFooter:(BOOL)useMJFooter
{
    _useMJFooter=useMJFooter;
    if (useMJFooter==NO) {
        self.tableView.mj_footer=nil;
    }
   else
   {
       [self configFooter];
   
   }
}
//-(void)setUseMJHeader:(BOOL)useMJHeader
//{
//    _useMJHeader=useMJHeader;
//    if (useMJHeader==YES) {
//       [self configFooter];
//    }
//    else
//    {
//       
//        
//    }
//}


@end
