//
//  YLRechargeCell.h
//  luckrental
//
//  Created by kiikqjzq on 2023/10/5.
//

#import <UIKit/UIKit.h>
#import "YLRechargeBean.h"


NS_ASSUME_NONNULL_BEGIN

@interface YLRechargeCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *amountLb;
@property (weak, nonatomic) IBOutlet UILabel *priceLb;
@property (weak, nonatomic) IBOutlet UIImageView *hookIV;
@property (weak, nonatomic) IBOutlet UILabel *pointLb;
- (void)initWithDate:(YLRechargeBean*)bean;
@end

NS_ASSUME_NONNULL_END
