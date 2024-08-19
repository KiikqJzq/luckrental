//
//  YLQuestionListCell.h
//  luckrental
//
//  Created by kiikqjzq on 2024/8/8.
//

#import <UIKit/UIKit.h>
#import "YLQuestionListBean.h"
#import "YLQuestionBean.h"
NS_ASSUME_NONNULL_BEGIN

@interface YLQuestionListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tabV;
@property (weak, nonatomic) IBOutlet UIView *contentV;
@property (nonatomic, strong) UINavigationController *nav;

- (void)initWithDate:(YLQuestionListBean*)bean;
@end

NS_ASSUME_NONNULL_END
