//
//  YLMerchantListVC.m
//  luckrental
//
//  Created by kiikqjzq on 2023/10/6.
//

#import "YLMerchantListVC.h"
#import "YLMerchantBean.h"
#import "YLMerchantCell.h"
#import "YLMerchantVC.h"

@interface YLMerchantListVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *marchantArray;
@property (weak, nonatomic) IBOutlet UITableView *tabV;

@end

@implementation YLMerchantListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = MyString(@"popular_merchants");
}

- (void)initUI{
    [_tabV registerNib:[UINib nibWithNibName:@"YLMerchantCell" bundle:nil] forCellReuseIdentifier:@"YLMerchantCell"];
    _tabV.delegate = self;
    _tabV.dataSource = self;
    _tabV.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tabV.showsVerticalScrollIndicator = NO;
    _tabV.tag = 111;
}

- (void)getData{
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/merchant/getMerchantByFilter" parameters:nil complete:^(id ob) {
        self.marchantArray = [YLMerchantBean mj_objectArrayWithKeyValuesArray:ob];
        [self.tabV reloadData];
    }];
}


#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.marchantArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 125;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"YLMerchantCell";
    YLMerchantBean *bean = _marchantArray[indexPath.row];
    YLMerchantCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer forIndexPath:indexPath];
    [cell initWithDate:bean];
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YLMerchantBean *bean = _marchantArray[indexPath.row];
    YLMerchantVC *vc = [YLMerchantVC new];
    vc.merchantId = bean.merchantId;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
@end
