//
//  YLCurOrderCell.h
//  luckrental
//
//  Created by kiikqjzq on 2023/9/16.
//

#import <UIKit/UIKit.h>
#import "YLOrderBean.h"
NS_ASSUME_NONNULL_BEGIN

@interface YLCurOrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *statusLb;
@property (weak, nonatomic) IBOutlet UILabel *infoLb;
@property (weak, nonatomic) IBOutlet UILabel *startLb;
@property (weak, nonatomic) IBOutlet UILabel *endLb;
@property (weak, nonatomic) IBOutlet UILabel *priceLb;
@property (weak, nonatomic) IBOutlet UILabel *priceTitleLb;
- (void)initWithDate:(YLOrderBean*)bean;
@end

NS_ASSUME_NONNULL_END
