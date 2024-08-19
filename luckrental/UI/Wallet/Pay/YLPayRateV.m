//
//  YLPayUploadV.m
//  luckrental
//
//  Created by kiikqjzq on 2023/9/26.
//

#import "YLPayRateV.h"
#import "UIView+Additions.h"
#import "YLHTTPUtility.h"
#import "UIView+Toast.h"
#import "RCDUploadAPI.h"
#import "SDWebImage.h"
#import "RCDCommonDefine.h"
#import "YLPayInfoBean.h"
#import "MJExtension.h"
#import "YLPayRateBean.h"
#import "YLPayUploadV.h"
#import "UIView+Nib.h"

@interface YLPayRateV()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, copy) void(^ didPaySuccess)(void);
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UIView *bgV;
@property (weak, nonatomic) IBOutlet UIView *contentV;
@property (strong, nonatomic)YLPayInfoBean *payInfoBean;
@property (weak, nonatomic) IBOutlet UILabel *country1TitleLb;
@property (weak, nonatomic) IBOutlet UILabel *country2TitleLb;
@property (weak, nonatomic) IBOutlet UILabel *country3TitleLb;
@property (weak, nonatomic) IBOutlet UILabel *country4TitleLb;
@property (weak, nonatomic) IBOutlet UILabel *country1Lb;
@property (weak, nonatomic) IBOutlet UILabel *country2Lb;
@property (weak, nonatomic) IBOutlet UILabel *country3Lb;
@property (weak, nonatomic) IBOutlet UILabel *country4Lb;
@property (weak, nonatomic) IBOutlet UIButton *summitBtn;

@end

@implementation YLPayRateV


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (void)show:(void(^)(void))didPaySuccess{
//    _titleLb.text = MyString(@"upload_payment_success_screenshot");
//    [self.summitBtn setTitle:MyString(@"payment_completed") forState:UIControlStateNormal];
    _titleLb.text = MyString(@"exchange_rate");
    _country1TitleLb.text = MyString(@"hong_kong_dollar");
    _country2TitleLb.text = MyString(@"taiwan_dollar");
    _country3TitleLb.text = MyString(@"us_dollar");
    _country4TitleLb.text = MyString(@"japanese_yen");
    [_summitBtn setTitle:MyString(@"next") forState:UIControlStateNormal];
    
//    self.amount

    
    self.didPaySuccess = didPaySuccess;
    self.bgV.userInteractionEnabled = YES;
    [self.bgV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)]];
    
    [self.summitBtn addTarget:self action:@selector(summit) forControlEvents:UIControlEventTouchUpInside];
    
    [self.superVc.view addSubview:self];
    [UIView animateWithDuration:0.5 animations:^{
        self.bgV.alpha = 0.5;
        self.contentV.top = 100;
    }];
    [self getData];
}

- (void)close{
    [UIView animateWithDuration:0.3 animations:^{
        self.bgV.alpha = 0.0;
        self.contentV.top = self.height;
        self.didPaySuccess();
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)upload{
    
}

- (void)getData{
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/order/getCurrentRate" parameters:nil complete:^(id ob) {
        YLPayRateBean *payInfoBean = [YLPayRateBean mj_objectWithKeyValues:ob];
        double amountD = [self.amount doubleValue];
        
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [numberFormatter setMinimumFractionDigits:0];
        [numberFormatter setMaximumFractionDigits:0]; // 设置最多显示两位小数
        NSString *amount1 = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:amountD * payInfoBean.HongKong]];
        self.country1Lb.text = [NSString stringWithFormat:@"HKD%@", amount1];
        NSString *amount2 = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:amountD * payInfoBean.Taiwan]];
        self.country2Lb.text = [NSString stringWithFormat:@"TWD%@", amount2];
        NSString *amount3 = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:amountD * payInfoBean.America]];
        self.country3Lb.text = [NSString stringWithFormat:@"$%@", amount3];
        NSString *amount4 = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:amountD]];
        self.country4Lb.text = [NSString stringWithFormat:@"¥%@", amount4];
    }];
    
}

- (void)summit{
    PXWeakSelf
    YLPayUploadV *v = [YLPayUploadV viewFormNib_];
    v.rid = self.rid;
    v.orderId = self.orderId;
    v.amount = self.amount;
    v.payType = self.payType;
    v.dialogType = self.dialogType;
    v.superVc = self.superVc;
    [v show:^{
        [weakSelf close];
    }];
}


@end
