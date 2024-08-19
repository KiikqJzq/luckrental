//
//  YLRechargeCell.m
//  luckrental
//
//  Created by kiikqjzq on 2023/10/5.
//

#import "YLRechargeCell.h"
#import "RCDCommonDefine.h"


@implementation YLRechargeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _pointLb.text = MyString(@"points");
    self.contentView.layer.cornerRadius = 12.0;
    self.contentView.layer.borderWidth = 1.0; // 设置边框宽度

    // Initialization code
}

- (void)initWithDate:(YLRechargeBean*)bean{
    self.amountLb.text = bean.receiveAmount;
    self.priceLb.text = bean.rechargeAmount;
    if(bean.isSelected){
        self.contentView.layer.borderColor = HEXCOLOR(0xFEAE3A).CGColor;
        [self.hookIV setImage:[UIImage imageNamed:@"ic_hook_sel"]];
    }else{
        self.contentView.layer.borderColor = HEXCOLOR(0xC6C4C5).CGColor;
        [self.hookIV setImage:[UIImage imageNamed:@"ic_hook_nor"]];
    }
}

@end
