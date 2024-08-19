//
//  YLMerchantCell.h
//  luckrental
//
//  Created by kiikqjzq on 2023/9/15.
//

#import <UIKit/UIKit.h>
#import "YLMerchantBean.h"
#import "SDWebImage.h"
NS_ASSUME_NONNULL_BEGIN

@interface YLMerchantCell : UITableViewCell
- (void)initWithDate:(YLMerchantBean*)bean;
@property (weak, nonatomic) IBOutlet UIImageView *avatarIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *infoLb;
@property (weak, nonatomic) IBOutlet UILabel *scoreLb;
@property (weak, nonatomic) IBOutlet UILabel *priceLb;
@property (weak, nonatomic) IBOutlet UILabel *tagLb;
@property (weak, nonatomic) IBOutlet UILabel *timeLb;

@end

NS_ASSUME_NONNULL_END
