//
//  YLSatisfactionCell.h
//  luckrental
//
//  Created by kiikqjzq on 2023/10/5.
//

#import <UIKit/UIKit.h>
#import "YLOptionBean.h"
NS_ASSUME_NONNULL_BEGIN

@interface YLSatisfactionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *hookIv;
@property (weak, nonatomic) IBOutlet UILabel *textLb;
- (void)initWithDate:(YLOptionBean*)bean;
@end

NS_ASSUME_NONNULL_END
