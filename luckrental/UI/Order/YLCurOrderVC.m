//
//  YLCurOrderVC.m
//  luckrental
//
//  Created by kiikqjzq on 2023/9/16.
//

#import "YLCurOrderVC.h"
#import "YLOrderBean.h"
#import "YLCurOrderCell.h"
#import "YLOrderInfoVC.h"
@interface YLCurOrderVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tabV;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation YLCurOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = MyString(@"my_trips");
    self.view.backgroundColor = HEXCOLOR(0xf8f8f8);
    
    _tabV = [UITableView new];
    _tabV.delegate = self;
    _tabV.backgroundColor = UIColor.clearColor;
    _tabV.dataSource = self;
    _tabV.separatorStyle = UITableViewCellSeparatorStyleNone;

    [_tabV registerNib:[UINib nibWithNibName:@"YLCurOrderCell" bundle:nil] forCellReuseIdentifier:@"YLCurOrderCell"];

    [self.view addSubview:_tabV];
    
    [_tabV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.view);
        make.left.equalTo(self.view).offset(13);
        make.right.equalTo(self.view).offset(-13);
    }];
    
}


- (void)getData{
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/order/getMyJourney" parameters:nil complete:^(id ob) {
        self.dataArray = [YLOrderBean mj_objectArrayWithKeyValuesArray:ob];
        [self.tabV reloadData];
    }];

}

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"YLCurOrderCell";
    YLOrderBean *bean = _dataArray[indexPath.row];
    YLCurOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer forIndexPath:indexPath];
    [cell initWithDate:bean];
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    YLOrderBean *bean = _dataArray[indexPath.row];
    YLOrderInfoVC *vc = [YLOrderInfoVC new];
    vc.orderId =bean.orderId;
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

@end
