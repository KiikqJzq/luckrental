//
//  YLHistoryOrderVC.m
//  luckrental
//
//  Created by kiikqjzq on 2023/9/16.
//

#import "YLHistoryOrderVC.h"
#import "YLOrderBean.h"
#import "YLHistoryOrderCell.h"
#import "YLOrderInfoVC.h"
#import "YLEvaluateVC.h"
@interface YLHistoryOrderVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tabV;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation YLHistoryOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = MyString(@"past_trips");
    self.view.backgroundColor = HEXCOLOR(0xf8f8f8);

    _tabV = [UITableView new];
    _tabV.delegate = self;
    _tabV.dataSource = self;
    _tabV.backgroundColor = UIColor.clearColor;
    _tabV.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_tabV registerNib:[UINib nibWithNibName:@"YLHistoryOrderCell" bundle:nil] forCellReuseIdentifier:@"YLHistoryOrderCell"];

    [self.view addSubview:_tabV];
    
    [_tabV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.view);
        make.left.equalTo(self.view).offset(13);
        make.right.equalTo(self.view).offset(-13);
    }];
    
}


- (void)getData{
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/order/getMyHistoryJourney" parameters:nil complete:^(id ob) {
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
    return 150;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"YLHistoryOrderCell";
    YLOrderBean *bean = _dataArray[indexPath.row];
    YLHistoryOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer forIndexPath:indexPath];
    [cell initWithDate:bean];
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(evaluateTapped:)];
    [cell.evaluateLb setUserInteractionEnabled:YES];
    [cell.evaluateLb addGestureRecognizer:tapGesture];
    cell.evaluateLb.tag = indexPath.row+111;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YLOrderBean *bean = _dataArray[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YLOrderInfoVC *vc = [YLOrderInfoVC new];
    vc.orderId = bean.orderId;
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


- (void)evaluateTapped:(UITapGestureRecognizer *)sender {
    YLOrderBean *bean = _dataArray[sender.view.tag-111];
    YLEvaluateVC *vc = [YLEvaluateVC new];
    vc.orderId = bean.orderId;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
