//
//  YLSatisfactionCell.m
//  luckrental
//
//  Created by kiikqjzq on 2023/10/5.
//

#import "YLSatisfactionCell.h"

@implementation YLSatisfactionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)initWithDate:(YLOptionBean*)bean{
    if(bean.isSelected){
        [self.hookIv setImage:[UIImage imageNamed:@"ic_hook_sel"]];
    }else{
        [self.hookIv setImage:[UIImage imageNamed:@"ic_hook_nor"]];
    }
    self.textLb.text = bean.text;
}
@end
