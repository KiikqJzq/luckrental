//
//  YLCarListCell.m
//  luckrental
//
//  Created by kiikqjzq on 2023/9/15.
//

#import "YLCarListCell.h"
#import "SDWebImage.h"
#import "RCDCommonDefine.h"
@interface YLCarListCell()
@property (weak, nonatomic) IBOutlet UIImageView *coverIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *infoLb;
@property (weak, nonatomic) IBOutlet UILabel *tagLb;
@property (weak, nonatomic) IBOutlet UILabel *moneyLb;
@property (weak, nonatomic) IBOutlet UILabel *dayUnitLb;
@property (weak, nonatomic) IBOutlet UILabel *info2Lb;
@property (weak, nonatomic) IBOutlet UILabel *info3Lb;

@end


@implementation YLCarListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _dayUnitLb.text = MyString(@"days");
}

- (void)initWithDate:(YLCarBean*)bean{
    self.nameLb.text =bean.carTitle;
    [self.coverIV sd_setImageWithURL:[NSURL URLWithString:bean.mobileUrl]];
    self.infoLb.text = [NSString stringWithFormat:@"%@/%@",bean.brand,bean.model];
    if([bean.automatic isEqualToString:@"Yes"]){
        self.info2Lb.text = [NSString stringWithFormat:@"%@/%@%@",MyString(@"automatic_transmission"),bean.seats,MyString(@"seats")];
    }else{
        self.info2Lb.text = [NSString stringWithFormat:@"%@/%@%@",MyString(@"manual_transmission"),bean.seats,MyString(@"seats")];
    }
    self.info3Lb.text = bean.descript;
    self.moneyLb.text = bean.price;
    NSString *resultString = [bean.lableList componentsJoinedByString:@" "];
    self.tagLb.text = resultString;
}

@end
