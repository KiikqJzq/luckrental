//
//  YLBalanceCell.h
//  luckrental
//
//  Created by kiikqjzq on 2023/10/7.
//

#import <UIKit/UIKit.h>
#import "YLBalanceBean.h"
NS_ASSUME_NONNULL_BEGIN

@interface YLBalanceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
@property (weak, nonatomic) IBOutlet UILabel *amountLb;
- (void)initWithDate:(YLBalanceBean*)bean;
@end

NS_ASSUME_NONNULL_END
