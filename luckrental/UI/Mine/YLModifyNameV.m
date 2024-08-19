//
//  YLPayUploadV.m
//  luckrental
//
//  Created by kiikqjzq on 2023/9/26.
//

#import "YLModifyNameV.h"
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

@interface YLModifyNameV()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, copy) void(^ didPaySuccess)(void);
@property (weak, nonatomic) IBOutlet UIView *bgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UIButton *summitBtn;
@property (weak, nonatomic) IBOutlet UIView *contentV;

@end

@implementation YLModifyNameV


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (void)show:(void(^)(void))didPaySuccess{
    _titleLb.text = MyString(@"modify_nickname");
    [_summitBtn setTitle:MyString(@"confirm") forState:UIControlStateNormal];
    _nameTF.placeholder = MyString(@"enter");
    self.didPaySuccess = didPaySuccess;
    self.bgV.userInteractionEnabled = YES;
    [self.bgV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)]];
    
    [self.summitBtn addTarget:self action:@selector(updateMyInfo) forControlEvents:UIControlEventTouchUpInside];
    
    [self.superVc.view addSubview:self];
    [UIView animateWithDuration:0.5 animations:^{
        self.bgV.alpha = 0.5;
        self.contentV.top = 100;
    }];
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

- (void)updateMyInfo{
    PXWeakSelf
    NSString *nickName = _nameTF.text;
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"nickName"] =  nickName;
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodPost URLString:@"/api/member/updateMyInfo" parameters:dic complete:^(id ob) {
        [weakSelf close];
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
