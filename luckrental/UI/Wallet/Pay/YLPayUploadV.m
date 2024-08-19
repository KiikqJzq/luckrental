//
//  YLPayUploadV.m
//  luckrental
//
//  Created by kiikqjzq on 2023/9/26.
//

#import "YLPayUploadV.h"
#import "UIView+Additions.h"
#import "YLHTTPUtility.h"
#import "UIView+Toast.h"
#import "RCDUploadAPI.h"
#import "SDWebImage.h"
#import "RCDCommonDefine.h"
#import "YLPayInfoBean.h"
#import "MJExtension.h"
#import "YLOrderInfoVC.h"

@interface YLPayUploadV()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *bgV;
@property (weak, nonatomic) IBOutlet UIView *contentV;

@property (weak, nonatomic) IBOutlet UIImageView *imgIV;
@property (weak, nonatomic) IBOutlet UIButton *summitBtn;
@property (nonatomic, copy) void(^ didPaySuccess)(void);
@property (weak, nonatomic) IBOutlet UILabel *titleLb;

@property (strong, nonatomic) NSString *imgUrl;
@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) UIImage *image;
@property (strong, nonatomic)YLPayInfoBean *payInfoBean;
@property (weak, nonatomic) IBOutlet UILabel *payInfoLb;

@end

@implementation YLPayUploadV


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (void)show:(void(^)(void))didPaySuccess{
    _titleLb.text = MyString(@"upload_payment_success_screenshot");
    [self.summitBtn setTitle:MyString(@"payment_completed") forState:UIControlStateNormal];
    self.didPaySuccess = didPaySuccess;
    
    self.bgV.userInteractionEnabled = YES;
    [self.bgV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)]];
    
    self.imgIV.userInteractionEnabled = YES;
    [self.imgIV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToImagePickerController)]];
    
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
    PXWeakSelf
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/aboutUS/getPayInfo" parameters:nil complete:^(id ob) {
        YLPayInfoBean *payInfoBean = [YLPayInfoBean mj_objectWithKeyValues:ob];
        if([self.payType isEqualToString:@"1"]){
            NSString *str1 = [NSString stringWithFormat:@"%@\n\n%@\n%@\n\n%@\n%@",payInfoBean.firstStep,payInfoBean.secondStep,payInfoBean.tip,payInfoBean.name,payInfoBean.fpsId];
            weakSelf.payInfoLb.text = str1;
        }else{
            NSString *str2 = [NSString stringWithFormat:@"%@\n\n%@\n%@\n%@\n\n%@\n%@",payInfoBean.cashWarning,payInfoBean.firstStep,payInfoBean.secondStep,payInfoBean.tip,payInfoBean.name,payInfoBean.fpsId];
            weakSelf.payInfoLb.text = str2;
        }
    }];
    
}

- (void)summit{
    
    if(!_imgUrl || _imgUrl.length==0){
        [self makeToast:MyString(@"select_image")];
        return;
    }

    
    if(self.dialogType == 1){
        NSMutableDictionary *dic = [NSMutableDictionary new];
        dic[@"id"] = self.rid;
        dic[@"imgUrl"] = self.imgUrl;
        dic[@"payType"] = self.payType;
        [YLHTTPUtility requestWithHTTPMethod:HTTPMethodPost URLString:@"/api/member/recharge" parameters:dic complete:^(id ob){
            [self close];
            [self showCompletionAlert];
        }];
    }else{
        NSMutableDictionary *dic = [NSMutableDictionary new];
        dic[@"orderId"] = self.orderId;
        dic[@"imgUrl"] = self.imgUrl;
        dic[@"payType"] = self.payType;
        [YLHTTPUtility requestWithHTTPMethod:HTTPMethodPost URLString:@"/api/order/submitPay" parameters:dic complete:^(id ob){
            [self close];
            UINavigationController *navigationController = self.superVc.navigationController;
            NSArray *viewControllers = navigationController.viewControllers;
            NSArray *viewControllersToKeep = @[viewControllers[0], viewControllers[1]];
           [navigationController setViewControllers:viewControllersToKeep animated:NO];
           YLOrderInfoVC *orderInfoVC = [YLOrderInfoVC new];
            orderInfoVC.orderId = self.orderId;
           [navigationController pushViewController:orderInfoVC animated:YES];
        }];
    }
}




-(void)pushToImagePickerController{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.allowsEditing = NO;
        picker.delegate = self;
//        if (sourceType == UIImagePickerControllerSourceTypeCamera) {
//            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//                picker.sourceType = sourceType;
//            } else {
//                NSLog(@"模拟器无法连接相机");
//            }
//        } else {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        }
        picker.modalPresentationStyle = UIModalPresentationFullScreen;
        [self.superVc presentViewController:picker animated:YES completion:nil];
    });
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqual:@"public.image"]) {
        //获取原图
        UIImage *originImage = [info objectForKey:UIImagePickerControllerOriginalImage];
//        //获取截取区域
//        CGRect captureRect = [[info objectForKey:UIImagePickerControllerCropRect] CGRectValue];
//        //获取截取区域的图像
//        UIImage *captureImage =
//        [UIImage getSubImage:originImage Rect:captureRect imageOrientation:originImage.imageOrientation];
//        UIImage *scaleImage = [UIImage scaleImage:captureImage toScale:0.8];
        self.data = UIImageJPEGRepresentation(originImage, 0.0001);
    }
    self.image = [UIImage imageWithData:self.data];
    [self.superVc dismissViewControllerAnimated:YES completion:nil];
    [self uploadImage];
}


- (void)uploadImage {
    [RCDUploadAPI uploadImage:self.data
                         complete:^(NSString *url) {
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 self.imgUrl = url;
                                 [self.imgIV sd_setImageWithURL:[NSURL URLWithString:self.imgUrl]];
                             });
                         }];
}

- (void)showCompletionAlert {
    PXWeakSelf
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:MyString(@"info_submitted")
                                                                             message:MyString(@"please_wait")
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:MyString(@"confirm")
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf.superVc.navigationController popViewControllerAnimated:YES];
                                                     }];
    [alertController addAction:okAction];
    [weakSelf.superVc presentViewController:alertController animated:YES completion:nil];
}


@end
