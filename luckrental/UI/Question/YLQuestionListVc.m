//
//  YLQuestionListVc.m
//  luckrental
//
//  Created by kiikqjzq on 2024/8/5.
//

#import "YLQuestionListVc.h"
#import "YLQuestionListCell.h"
#import "YLQuestionListBean.h"
@interface YLQuestionListVc ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tabV;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation YLQuestionListVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = MyString(@"faq");
    self.view.backgroundColor = HEXCOLOR(0xf8f8f8);

    _tabV.delegate = self;
    _tabV.dataSource = self;
    _tabV.backgroundColor = UIColor.clearColor;
    _tabV.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_tabV registerNib:[UINib nibWithNibName:@"YLQuestionListCell" bundle:nil] forCellReuseIdentifier:@"YLQuestionListCell"];

}


- (void)getData{
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/question/getQuestionTypeByI18n" parameters:nil complete:^(id ob) {
        self.dataArray = [YLQuestionListBean mj_objectArrayWithKeyValuesArray:ob];
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
    YLQuestionListBean *bean = _dataArray[indexPath.row];

    return 30+(bean.questions.count*50);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"YLQuestionListCell";
    YLQuestionListBean *bean = _dataArray[indexPath.row];
    YLQuestionListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer forIndexPath:indexPath];
    [cell initWithDate:bean];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    YLQuestionListBean *bean = _dataArray[indexPath.row];
//    YLOrderInfoVC *vc = [YLOrderInfoVC new];
//    vc.orderId =bean.orderId;
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


@end
