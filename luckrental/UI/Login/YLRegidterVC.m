//
//  YLRegidterVC.m
//  luckrental
//
//  Created by kiikqjzq on 2023/10/3.
//

#import "YLRegidterVC.h"
#import "YLCountryBean.h"
#import <CommonCrypto/CommonDigest.h>
#import "YLWebVC.h"

@interface YLRegidterVC ()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UIView *pickerV;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UIImageView *backIV;
@property (weak, nonatomic) IBOutlet UITextField *pwd2TF;
@property (strong, nonatomic) UIPickerView *countryPicker;
@property (strong, nonatomic) NSArray *countries;
@property (strong, nonatomic) UIToolbar *toolbar;

@property (weak, nonatomic) IBOutlet UIImageView *countryIV;

@property (weak, nonatomic) IBOutlet UILabel *countryLb;

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIImageView *hookIV;
@property (weak, nonatomic) IBOutlet UILabel *goLoginLb;
@property (weak, nonatomic) IBOutlet UILabel *welcomLb;
@property (weak, nonatomic) IBOutlet UILabel *bookLb;
@property (weak, nonatomic) IBOutlet UILabel *selectCountryLb;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UILabel *sendCodeLb;

@property (assign, nonatomic) bool isRead;

@end

@implementation YLRegidterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _backIV.userInteractionEnabled = YES;
    [_backIV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBack)]];
    
    _pickerV.userInteractionEnabled = YES;
    [_pickerV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicker)]];
    
    _hookIV.userInteractionEnabled = YES;
    [_hookIV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickRead)]];
    
    _goLoginLb.userInteractionEnabled = YES;
    [_goLoginLb addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBack)]];
    
    [_registerBtn addTarget:self action:@selector(summit) forControlEvents:UIControlEventTouchUpInside];
    
    _sendCodeLb.userInteractionEnabled = YES;
    [_sendCodeLb addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendCode)]];
    
    _bookLb.userInteractionEnabled = YES;
    [_bookLb addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goAgreement)]];
    
    _welcomLb.text = MyString(@"welcome_to_system");
    _accountTF.placeholder =  MyString(@"enter_email");
    _sendCodeLb.text =  MyString(@"verification_code");
    _codeTF.placeholder =  MyString(@"enter_verification_code");
    _pwdTF.placeholder =  MyString(@"enter_password");
    _pwd2TF.placeholder =  MyString(@"enter_password");
    _selectCountryLb.text = MyString(@"region");
    _countryLb.text = MyString(@"please_select");
    [_registerBtn setTitle:MyString(@"register") forState:UIControlStateNormal];

    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@", MyString(@"agree_to_terms"), MyString(@"rental_agreement_and_privacy_policy")]];
    NSRange range1 = [attributedString1.string rangeOfString:MyString(@"rental_agreement_and_privacy_policy")];
    [attributedString1 addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0xFEAE3A) range:range1];
    _bookLb.attributedText = attributedString1;
    
    
    NSString *noAccountPrompt = MyString(@"already_have_account");
    NSString *goToRegister = MyString(@"go_to_login");
    
    // 创建一个NSMutableAttributedString
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@", noAccountPrompt, goToRegister]];
    
    // 设置要变色的文字范围和颜色
    NSRange range = [attributedString.string rangeOfString:goToRegister];
    [attributedString addAttribute:NSForegroundColorAttributeName value:HEXCOLOR(0xFEAE3A) range:range];
    
    // 将NSAttributedString应用到UILabel
    self.goLoginLb.attributedText = attributedString;
}

-(void)getData{
    [super getData];
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/member/countryList" parameters:nil complete:^(id ob) {
        self.countries = [YLCountryBean mj_objectArrayWithKeyValuesArray:ob];
    }];
    
}


-(void)summit{
    
    NSString *email = _accountTF.text;
    NSString *password = _pwdTF.text;
    NSString *password2 = _pwd2TF.text;
    NSString *country = _countryLb.text;
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
    
    if(!country || country.length==0){
        [self.view makeToast:MyString(@"select_region")];
        return;
    }
    
    if(!self.isRead){
        [self.view makeToast:MyString(@"agree_to_terms")];
        return;
    }
    
    if(!code || code.length==0){
        [self.view makeToast:MyString(@"enter_email")];
        return;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"email"] = email;
    dic[@"password"] = [self getmd5Str:password];
    dic[@"country"] = country;
    dic[@"code"] = code;
    
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodPost URLString:@"/api/member/register" parameters:dic complete:^(id ob) {
        [self.navigationController popViewControllerAnimated:YES];
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

-(void)verifyCode{
    NSString *email = _accountTF.text;
    NSString *code = _codeTF.text;
    if(!email || email.length==0){
        [self.view makeToast:MyString(@"enter_email")];
        return;
    }
    
    if(!code || code.length==0){
        [self.view makeToast:MyString(@"enter_email")];
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"/api/email/codeValid/%@/%@",email,code];
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:url parameters:nil complete:^(id ob) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}
-(void)showPicker{
    // 创建PickerView
    self.countryPicker = [UIPickerView new];
    self.countryPicker.backgroundColor = UIColor.whiteColor;
    self.countryPicker.delegate = self;
    self.countryPicker.dataSource = self;
    
    // 创建Toolbar
    _toolbar = [UIToolbar new];
    _toolbar.backgroundColor = UIColor.whiteColor;
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:MyString(@"cancel") style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonTapped)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:MyString(@"confirm") style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonTapped)];
    _toolbar.items = @[cancelButton, flexibleSpace, doneButton];
    
    // 将PickerView和Toolbar添加到视图中
    [self.view addSubview:self.countryPicker];
    [self.view addSubview:_toolbar];
    [self.countryPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(@200);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    [_toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(@44);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.countryPicker.mas_top);
    }];
    
}

#pragma mark - UIPickerViewDelegate and UIPickerViewDataSource methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1; // 选择1列
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.countries.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
   // self.countries[row];
    YLCountryBean * bean = [YLCountryBean mj_objectWithKeyValues:self.countries[row]];
    return bean.Country;
}

#pragma mark - Button actions

- (void)cancelButtonTapped {
    // 处理取消按钮点击事件
    [self.countryPicker removeFromSuperview];
    [self.toolbar removeFromSuperview];
}

- (void)doneButtonTapped {
    // 处理完成按钮点击事件
    NSInteger selectedRow = [self.countryPicker selectedRowInComponent:0];
    YLCountryBean * bean = [YLCountryBean mj_objectWithKeyValues:self.countries[selectedRow]];
    NSString *selectedCountry = bean.Country;
    _countryLb.text = selectedCountry;
    [_countryIV sd_setImageWithURL:[NSURL URLWithString:bean.Ensign]];
    [self.countryPicker removeFromSuperview];
    [self.toolbar removeFromSuperview];
}

-(void)clickRead{
    if (_isRead) {
        [_hookIV setImage:[UIImage imageNamed:@"ic_hook_nor"]];
    }else{
        [_hookIV setImage:[UIImage imageNamed:@"ic_hook_sel"]];
    }
    _isRead = !_isRead;
}

- (BOOL)isValidEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
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
