//
//  YLBalanceCell.m
//  luckrental
//
//  Created by kiikqjzq on 2023/10/7.
//

#import "YLBalanceCell.h"
#import "RCDCommonDefine.h"

@implementation YLBalanceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initWithDate:(YLBalanceBean*)bean{
    self.titleLb.text = [self getStatus:bean.type];
    self.timeLb.text = bean.submitDate;
    self.amountLb.text = bean.deduct;
}


-(NSString*)getStatus:(NSString*)type{
    NSString *status = @"";
    if([type isEqualToString:@"0"]){
        status = MyString(@"recharge");
    }else if([type isEqualToString:@"1"]){
        status = MyString(@"consume");
    }else if([type isEqualToString:@"2"]){
        status = MyString(@"order_timeout_return");
    }
    return status;
}
@end
