//
//  YLCarFuncCell.m
//  luckrental
//
//  Created by kiikqjzq on 2023/12/8.
//

#import "YLCarFuncCell.h"
#import "RCDCommonDefine.h"

@implementation YLCarFuncCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentV.layer.borderWidth = 1.0; // 边框宽度
    self.contentV.layer.borderColor = HEXCOLOR(0xFEAD3A).CGColor; // 边框颜色
}

@end
