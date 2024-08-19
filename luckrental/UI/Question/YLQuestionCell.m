//
//  YLQuestionCell.m
//  luckrental
//
//  Created by kiikqjzq on 2024/8/8.
//

#import "YLQuestionCell.h"

@implementation YLQuestionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initWithDate:(YLQuestionBean*)bean{
    self.titleLb.text = [NSString stringWithFormat:@"%@", bean.title];
}
@end
