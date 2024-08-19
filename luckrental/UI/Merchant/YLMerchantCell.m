//
//  YLMerchantCell.m
//  luckrental
//
//  Created by kiikqjzq on 2023/9/15.
//

#import "YLMerchantCell.h"
#import "RCDCommonDefine.h"

@implementation YLMerchantCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initWithDate:(YLMerchantBean*)bean{
    self.nameLb.text =bean.title;
    [self.avatarIV sd_setImageWithURL:[NSURL URLWithString:bean.mobileUrl]];
    self.infoLb.text = bean.address;
    self.scoreLb.text = [NSString stringWithFormat:@"%@:%@",MyString(@"user_rating"),bean.pinfen];
    self.priceLb.text = MyString(@"no_average_price");
    self.tagLb.text = bean.subheading;
    self.timeLb.text = bean.openingHours;
}
@end
