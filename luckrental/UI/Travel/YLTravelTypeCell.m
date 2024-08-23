//
//  YLTravelTypeCell.m
//  luckrental
//
//  Created by kiikqjzq on 2024/8/23.
//

#import "YLTravelTypeCell.h"

@implementation YLTravelTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)initWithDate:(YLTravelTypeBean*)bean{
    self.lb.text = bean.name;
    if (bean.isSelected){
        self.contentV.backgroundColor = UIColor.whiteColor;
    }else{
        self.contentV.backgroundColor = UIColor.clearColor;
    }
}
@end
