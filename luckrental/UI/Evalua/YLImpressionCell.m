//
//  YLImpressionCell.m
//  luckrental
//
//  Created by kiikqjzq on 2023/10/5.
//

#import "YLImpressionCell.h"

@implementation YLImpressionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)initWithDate:(YLOptionBean*)bean{
    if(bean.isSelected){
        [self.bgIV setImage:[UIImage imageNamed:@"bg_btn_theme"]];
    }else{
        [self.bgIV setImage:[UIImage imageNamed:@""]];
    }
    self.textLb.text = bean.text;
}
@end
