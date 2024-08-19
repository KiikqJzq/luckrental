//
//  YLEvaluaCell.h
//  luckrental
//
//  Created by kiikqjzq on 2023/12/11.
//

#import <UIKit/UIKit.h>
#import "YLCommentBean.h"


NS_ASSUME_NONNULL_BEGIN

@interface YLEvaluaCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
@property (weak, nonatomic) IBOutlet UILabel *contentLb;
- (void)initWithDate:(YLCommentBean*)bean;
@end

NS_ASSUME_NONNULL_END
