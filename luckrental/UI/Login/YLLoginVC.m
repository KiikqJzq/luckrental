//
//  YLLoginVC.m
//  luckrental
//
//  Created by kiikqjzq on 2023/9/14.
//

#import "YLLoginVC.h"
#import "YLHomeVC.h"
#import "YLRegidterVC.h"
#import "YLResetPwdVC.h"
#import "RCDMainTabBarViewController.h"
#import "YLprotocolV.h"
#import "UIView+Nib.h"
#import <CommonCrypto/CommonDigest.h>
#import "YLWebVC.h"

@interface YLLoginVC ()
@property (weak, nonatomic) IBOutlet UILabel *welLb;
@property (weak, nonatomic) IBOutlet UILabel *bookLb;
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UILabel *registerLb;
@property (weak, nonatomic) IBOutlet UIImageView *hookIV;
@property (weak, nonatomic) IBOutlet UILabel *resetPwdLb;
@property (assign, nonatomic) bool isRead;
@end

@implementation YLLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_loginBtn addTarget:self action:@selector(summit) forControlEvents:UIControlEventTouchUpInside];
    
    _registerLb.userInteractionEnabled = YES;
    [_registerLb addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goRegister)]];
    
    _hookIV.userInteractionEnabled = YES;
    [_hookIV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickRead)]];
    
    
    _resetPwdLb.userInteractionEnabled = YES;
    [_resetPwdLb addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goResetPwd)]];
    
    _bookLb.userInteractionEnabled = YES;
    [_bookLb addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goAgreement)]];
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *isAgree = [defaults objectForKey:@"isAgree"];
//    if (!isAgree || ![isAgree isEqualToString:@"1"]) {
//        YLprotocolV *v = [YLprotocolV viewFormNib_];
//        v.superVc = self;
//        [v show];
//    }
    _accountTF.placeholder =  MyString(@"enter_email");
    _pwdTF.placeholder =  MyString(@"enter_password");
    _resetPwdLb.text = MyString(@"reset_password");
    _welLb.text = MyString(@"welcome_to_system");
    
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@", MyString(@"agree_to_terms"), MyString(@"rental_agreement_and_privacy_policy")]];
    NSRange range1 = [attributedString1.string rangeOfString:MyString(@"rental_agreement_and_privacy_policy")];
    [attributedString1 addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0xFEAE3A) range:range1];
    _bookLb.attributedText = attributedString1;
    
    
    [_loginBtn setTitle:MyString(@"login") forState:UIControlStateNormal];
    // 获取国际化字符串
    NSString *noAccountPrompt = MyString(@"no_account_prompt");
    NSString *goToRegister = MyString(@"go_to_register");
    
    // 创建一个NSMutableAttributedString
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@", noAccountPrompt, goToRegister]];
    
    // 设置要变色的文字范围和颜色
    NSRange range = [attributedString.string rangeOfString:goToRegister];
    [attributedString addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0xFEAE3A) range:range];
    
    // 将NSAttributedString应用到UILabel
    self.registerLb.attributedText = attributedString;
}


-(void)summit{
    NSString *email = _accountTF.text;
    NSString *password = _pwdTF.text;
    
    if(!email || email.length==0){
        
        [self.view makeToast:MyString(@"check_account")];
        return;
    }
    if(!password || password.length==0){
        [self.view makeToast:MyString(@"enter_password")];
        return;
    }
    
    if(!self.isRead){
        [self.view makeToast:MyString(@"agree_to_terms")];
        return;
    }
    
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"email"] = email;
    dic[@"password"] = [self getmd5Str:password];
    
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodPost URLString:@"/api/member/login" parameters:dic complete:^(id ob) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:ob forKey:@"AccessToken"]; // "AccessToken" 是你用于标识token的键
        [defaults synchronize]; // 确保数据立即保存
        
        BOOL isViewControllerAlreadyExists = NO;
        
        for (UIViewController *viewController in self.navigationController.viewControllers) {
            if ([viewController isKindOfClass:[RCDMainTabBarViewController class]]) {
                isViewControllerAlreadyExists = YES;
                break;
            }
        }
        if (isViewControllerAlreadyExists) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            RCDMainTabBarViewController *vc = [RCDMainTabBarViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }];
}

-(void)clickRead{
    if (_isRead) {
        [_hookIV setImage:[UIImage imageNamed:@"ic_hook_nor"]];
    }else{
        [_hookIV setImage:[UIImage imageNamed:@"ic_hook_sel"]];
    }
    _isRead = !_isRead;
}

-(void)goRegister{
    YLRegidterVC *vc = [YLRegidterVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)goResetPwd{
    YLResetPwdVC *vc = [YLResetPwdVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (NSString *)getmd5Str:(NSString *)str
{
    //传入参数,转化成char
    const char *cStr = [str UTF8String];
    //开辟一个16字节的空间
    unsigned char result[16];
    /*
     extern unsigned char * CC_MD5(const void *data, CC_LONG len, unsigned char *md)官方封装好的加密方法
     把str字符串转换成了32位的16进制数列（这个过程不可逆转） 存储到了md这个空间中
     */
    CC_MD5(cStr, (unsigned)strlen(cStr), result);
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ];
}

-(void)goAgreement{
    YLWebVC *webViewController = [YLWebVC new];
    webViewController.titleText = @"Agreement";
    webViewController.urlString = @"https://luckrentalcar.com/#/agreement";
    [self.navigationController pushViewController:webViewController animated:YES];
}
@end
