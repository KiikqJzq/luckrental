//
//  YLWalletVC.m
//  luckrental
//
//  Created by kiikqjzq on 2023/9/15.
//

#import "YLWalletVC.h"
#import "YLRechargeVC.h"
#import "YLBalanceBean.h"
#import "YLBalanceCell.h"

@interface YLWalletVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UIImageView *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *rechargeBtn;
@property (weak, nonatomic) IBOutlet UILabel *balanceLb;
@property (weak, nonatomic) IBOutlet UITableView *tabV;
@property (weak, nonatomic) IBOutlet UILabel *titlteLb;
@property (weak, nonatomic) IBOutlet UILabel *balanceTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *detailsLb;

@end

@implementation YLWalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titlteLb.text = MyString(@"points_details");
    _balanceTitleLb.text = MyString(@"points_balance");
    [_rechargeBtn setTitle:MyString(@"recharge") forState:UIControlStateNormal];
    _detailsLb.text = MyString(@"points_details");
    
    [self.rechargeBtn addTarget:self action:@selector(goRechargeVC) forControlEvents:UIControlEventTouchUpInside];
    
    self.backBtn.userInteractionEnabled = YES;
    [self.backBtn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBack)]];
    
    [_tabV registerNib:[UINib nibWithNibName:@"YLBalanceCell" bundle:nil] forCellReuseIdentifier:@"YLBalanceCell"];
    _tabV.delegate = self;
    _tabV.dataSource = self;
    _tabV.showsVerticalScrollIndicator = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)goRechargeVC{
    YLRechargeVC *vc = [YLRechargeVC new];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)getData{
    [super getData];
    
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/member/getBalance" parameters:nil complete:^(id ob) {
        self.balanceLb.text = [ob stringValue];
    }];
    
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/member/getBalanceList" parameters:nil complete:^(id ob) {
        self.dataArray = [YLBalanceBean mj_objectArrayWithKeyValuesArray:ob];
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
    return 76;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"YLBalanceCell";
    YLBalanceBean *bean = _dataArray[indexPath.row];
    YLBalanceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer forIndexPath:indexPath];
    [cell initWithDate:bean];
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

@end
