//
//  YLScoreCell.h
//  luckrental
//
//  Created by kiikqjzq on 2023/10/5.
//

#import <UIKit/UIKit.h>
#import "YLOptionBean.h"
NS_ASSUME_NONNULL_BEGIN

@interface YLScoreCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iv;
- (void)initWithDate:(YLOptionBean*)bean;
@end

NS_ASSUME_NONNULL_END
