//
//  YLEvaluaCell.m
//  luckrental
//
//  Created by kiikqjzq on 2023/12/11.
//

#import "YLEvaluaCell.h"
#import "SDWebImage.h"
#import "RCDCommonDefine.h"

@implementation YLEvaluaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initWithDate:(YLCommentBean*)bean{
    [self.avatarIV sd_setImageWithURL:[NSURL URLWithString:bean.userIcon]];
    self.nameLb.text = bean.userName;
    self.timeLb.text = bean.submitDate;
    self.contentLb.text = bean.content;
    self.likeNumLb.text = [NSString stringWithFormat:@"%d", bean.upvote];
    
}
@end
