//
//  YLQuestionListCell.m
//  luckrental
//
//  Created by kiikqjzq on 2024/8/8.
//

#import "YLQuestionListCell.h"
#import "YLQuestionCell.h"
#import "MJExtension.h"
#import "YLQuestionInfoVC.h"


@interface YLQuestionListCell ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation YLQuestionListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _tabV.delegate = self;
    _tabV.dataSource = self;
    _tabV.backgroundColor = UIColor.clearColor;
    _tabV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tabV registerNib:[UINib nibWithNibName:@"YLQuestionCell" bundle:nil] forCellReuseIdentifier:@"YLQuestionCell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)initWithDate:(YLQuestionListBean*)bean{
    self.titleLabel.text = [NSString stringWithFormat:@"  %@", bean.name];
    self.dataArray = [YLQuestionBean mj_objectArrayWithKeyValuesArray:bean.questions];
    [self.tabV reloadData];
}

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"YLQuestionCell";
    YLQuestionBean *bean = _dataArray[indexPath.row];
    YLQuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer forIndexPath:indexPath];
    [cell initWithDate:bean];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PXWeakSelf
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    YLQuestionBean *bean = _dataArray[indexPath.row];
    YLQuestionInfoVC *vc = [YLQuestionInfoVC new];
    vc.qid = bean.qId;
    vc.titleStr = bean.title;
    [[weakSelf topViewControllerForKeyWindow].navigationController pushViewController:vc animated:YES];
}

- (UIViewController *)topViewControllerForKeyWindow {
    UIViewController *resultVC;
    UIWindow *keyWindow = nil;
    if ([[UIApplication sharedApplication].delegate respondsToSelector:@selector(window)]) {
        keyWindow = [[UIApplication sharedApplication].delegate window];
    }else{
        keyWindow = [UIApplication sharedApplication].windows.firstObject;
    }
    resultVC = [self _topViewController:[keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}
@end
