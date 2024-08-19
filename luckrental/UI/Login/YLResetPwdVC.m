//
//  YLRegidterVC.m
//  luckrental
//
//  Created by kiikqjzq on 2023/10/3.
//

#import "YLResetPwdVC.h"
#import "YLCountryBean.h"
#import <CommonCrypto/CommonDigest.h>


@interface YLResetPwdVC ()
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UITextField *pwd2TF;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UILabel *tipLb;
@property (weak, nonatomic) IBOutlet UILabel *sendCodeLb;

@end

@implementation YLResetPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];

    _sendCodeLb.userInteractionEnabled = YES;
    [_sendCodeLb addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendCode)]];
    self.title = MyString(@"reset_password");
    _tipLb.text = MyString(@"reset_code_sent");
    _accountTF.placeholder = MyString(@"enter_email");
    _codeTF.placeholder = MyString(@"enter");
    _pwdTF.placeholder = MyString(@"enter_new_password");
    _pwd2TF.placeholder = MyString(@"enter_new_password");
    _sendCodeLb.text = MyString(@"verification_code");
    
    [_registerBtn setTitle:MyString(@"reset_password") forState:UIControlStateNormal];
    [_registerBtn addTarget:self action:@selector(summit) forControlEvents:UIControlEventTouchUpInside];
    
}



-(void)summit{
    
    NSString *email = _accountTF.text;
    NSString *password = _pwdTF.text;
    NSString *password2 = _pwd2TF.text;
    NSString *code = _codeTF.text;
    
    if(!email || email.length==0){
        [self.view makeToast:MyString(@"enter_email")];
        return;
    }
    
    if(![self isValidEmail:email]){
        [self.view makeToast:MyString(@"enter_valid_email")];
        return;
    }
    
    if(!password || password.length==0){
        [self.view makeToast:MyString(@"enter_password")];
        return;
    }
    
    if(!password2 || password2.length==0){
        [self.view makeToast:MyString(@"enter_password_again")];
        return;
    }
    
    if(![password isEqualToString:password2]){
        [self.view makeToast:MyString(@"password_mismatch")];
        return;
    }
    
    if(!code || code.length==0){
        [self.view makeToast:MyString(@"enter_verification_code")];
        return;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"email"] = email;
    dic[@"password"] = [self getmd5Str:password];
    dic[@"code"] = code;
    PXWeakSelf
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodPost URLString:@"/api/member/resetPassword" parameters:dic complete:^(id ob) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    
}

-(void)sendCode{
    NSString *email = _accountTF.text;
    if(!email || email.length==0){
        [self.view makeToast:MyString(@"enter_email")];
        return;
    }
    PXWeakSelf
    NSString *url = [NSString stringWithFormat:@"/api/email/sendEmail/%@",email];
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:url parameters:nil complete:^(id ob) {
        weakSelf.sendCodeLb.text = MyString(@"sent");
    }];
    
}


- (BOOL)isValidEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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

@end
