//
//  YLQuestionCell.h
//  luckrental
//
//  Created by kiikqjzq on 2024/8/8.
//

#import <UIKit/UIKit.h>
#import "YLQuestionBean.h"
NS_ASSUME_NONNULL_BEGIN

@interface YLQuestionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
- (void)initWithDate:(YLQuestionBean*)bean;
@end

NS_ASSUME_NONNULL_END
