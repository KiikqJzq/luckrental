//
//  YLTravelTypeCell.h
//  luckrental
//
//  Created by kiikqjzq on 2024/8/23.
//

#import <UIKit/UIKit.h>
#import "YLTravelTypeBean.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLTravelTypeCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *contentV;
@property (weak, nonatomic) IBOutlet UILabel *lb;
@property (weak, nonatomic) IBOutlet UIView *lineV;
- (void)initWithDate:(YLTravelTypeBean*)bean;
@end

NS_ASSUME_NONNULL_END
