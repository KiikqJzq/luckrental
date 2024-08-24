//
//  YLCommentV.m
//  luckrental
//
//  Created by kiikqjzq on 2024/8/14.
//

#import "YLCommentV.h"
#import "UIView+Additions.h"
#import "YLHTTPUtility.h"
#import "UIView+Toast.h"
#import "RCDUploadAPI.h"
#import "SDWebImage.h"
#import "RCDCommonDefine.h"
#import "YLPayInfoBean.h"
#import "MJExtension.h"
#import "UIView+Nib.h"

@implementation YLCommentV

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (void)show:(void(^)(void))didPaySuccess{
    _titleLb.text = MyString(@"enter_review");
    [_btn setTitle:MyString(@"confirm") forState:UIControlStateNormal];
    self.bgV.userInteractionEnabled = YES;
    [self.bgV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)]];
    [self.btn addTarget:self action:@selector(summit) forControlEvents:UIControlEventTouchUpInside];

    [self.superVc.view addSubview:self];
    [UIView animateWithDuration:0.5 animations:^{
        self.bgV.alpha = 0.5;
        self.contentV.top = 150;
    }];
    
    [_tv becomeFirstResponder];

}

- (void)close{
    [UIView animateWithDuration:0.3 animations:^{
        self.bgV.alpha = 0.0;
        self.contentV.top = self.height;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (self.didClose) {
            self.didClose();
        }
    }];
}
- (void)summit{
    PXWeakSelf
    NSString *content = _tv.text;
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"content"] =  content;
    dic[@"travelId"] =  self.travelId;
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodPost URLString:@"/api/travel/addTravelReply" parameters:dic complete:^(id ob) {
        [weakSelf showCompletionAlert];
    }];
    
    
}

- (void)showCompletionAlert {
    PXWeakSelf
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:MyString(@"thank_you_for_your_comment")
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:MyString(@"confirm")
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
        //        [weakSelf.superVc.navigationController popViewControllerAnimated:YES];
        //                                                     }];
        [weakSelf close];
    }];
    [alertController addAction:okAction];
    [weakSelf.superVc presentViewController:alertController animated:YES completion:nil];
}





@end
