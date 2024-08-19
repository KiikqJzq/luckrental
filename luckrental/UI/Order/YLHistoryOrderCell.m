//
//  YLHistoryOrderCell.m
//  luckrental
//
//  Created by kiikqjzq on 2023/9/16.
//

#import "YLHistoryOrderCell.h"
#import "RCDCommonDefine.h"
@implementation YLHistoryOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _priceTitleLb.text = MyString(@"total_price");
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)initWithDate:(YLOrderBean*)bean{
    _statusLb.text = bean.statusShow;
    _nameLb.text = bean.carTitle;
    _infoLb.text = bean.pickCarDate;
    _startLb.text = bean.pickCarAddress;
    _endLb.text = bean.returnCarAddress;
    _priceLb.text =[NSString stringWithFormat:@"￥%@",bean.actualPrice];
    _evaluateLb.text = MyString(@"order_review");
}


@end
