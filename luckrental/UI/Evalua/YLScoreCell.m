//
//  YLScoreCell.m
//  luckrental
//
//  Created by kiikqjzq on 2023/10/5.
//

#import "YLScoreCell.h"

@implementation YLScoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)initWithDate:(YLOptionBean*)bean{
    if(bean.isSelected){
        [self.iv setImage:[UIImage imageNamed:@"ic_start_gold"]];
    }else{
        [self.iv setImage:[UIImage imageNamed:@"ic_start_gray"]];
    }
}
@end
