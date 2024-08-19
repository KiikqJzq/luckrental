//
//  YLCarListCell.h
//  luckrental
//
//  Created by kiikqjzq on 2023/9/15.
//

#import <UIKit/UIKit.h>
#import "YLCarBean.h"
NS_ASSUME_NONNULL_BEGIN

@interface YLCarListCell : UITableViewCell
- (void)initWithDate:(YLCarBean*)bean;

@end

NS_ASSUME_NONNULL_END
