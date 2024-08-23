//
//  YLMineVC.m
//  luckrental
//
//  Created by kiikqjzq on 2023/9/14.
//

#import "YLMineVC.h"
#import "YLCurOrderVC.h"
#import "YLHistoryOrderVC.h"
#import "YLFeedbackVC.h"
#import "YLWalletVC.h"
#import "YLAboutUSVC.h"
#import "YLLoginVC.h"
#import "YLSettingVC.h"
#import "YLResetPwdVC.h"
#import "YLQuestionListVc.h"
#import "YLServiceBean.h"
#import "YLModifyNameV.h"
#import "UIView+Nib.h"
#import "AppDelegate.h"
#import "RCDMainTabBarViewController.h"
#import "RCDNavigationViewController.h"



@interface YLMineVC ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *levelLb;
@property (weak, nonatomic) IBOutlet UIView *curOrderV;
@property (weak, nonatomic) IBOutlet UIView *histortOrderV;
@property (weak, nonatomic) IBOutlet UIView *feedbackV;
@property (weak, nonatomic) IBOutlet UIView *walletV;
@property (weak, nonatomic) IBOutlet UIView *serviceV;
@property (weak, nonatomic) IBOutlet UIView *aboutUsV;
@property (weak, nonatomic) IBOutlet UIView *quitV;
@property (weak, nonatomic) IBOutlet UILabel *curNumLb;
@property (weak, nonatomic) IBOutlet UILabel *historyNumLb;
@property (weak, nonatomic) IBOutlet UILabel *curOrderLb;
@property (weak, nonatomic) IBOutlet UILabel *curOrdersLb;
@property (weak, nonatomic) IBOutlet UILabel *historyOrderLb;
@property (weak, nonatomic) IBOutlet UILabel *historyOrdersLb;
@property (weak, nonatomic) IBOutlet UILabel *moreFunctionLb;
@property (weak, nonatomic) IBOutlet UILabel *feedbackLb;
@property (weak, nonatomic) IBOutlet UILabel *pointLb;
@property (weak, nonatomic) IBOutlet UILabel *serviceLb;
@property (weak, nonatomic) IBOutlet UILabel *aboutUsLb;
@property (weak, nonatomic) IBOutlet UILabel *quitLb;
@property (weak, nonatomic) IBOutlet UIView *questionV;
@property (weak, nonatomic) IBOutlet UILabel *questionLb;

@property (nonatomic, strong) NSMutableArray *dataArray1;
@property (nonatomic, strong) NSMutableArray *dataArray2;
@property (weak, nonatomic) IBOutlet UIView *settingV;
@property (weak, nonatomic) IBOutlet UILabel *settingLb;
@property (weak, nonatomic) IBOutlet UIButton *editModifyBtn;
@end

@implementation YLMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.curOrderV.userInteractionEnabled = YES;
    [self.curOrderV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goCurOrder)]];
    
    self.histortOrderV.userInteractionEnabled = YES;
    [self.histortOrderV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goHistoryOrder)]];
    
    self.feedbackV.userInteractionEnabled = YES;
    [self.feedbackV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goFeedbac)]];
    
    self.walletV.userInteractionEnabled = YES;
    [self.walletV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goWallet)]];
    
    self.aboutUsV.userInteractionEnabled = YES;
    [self.aboutUsV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goAboutUs)]];
    
    self.serviceV.userInteractionEnabled = YES;
    [self.serviceV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getCustomerService)]];
    
    self.settingV.userInteractionEnabled = YES;
    [self.settingV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goSetting)]];
    
    self.questionV.userInteractionEnabled = YES;
    [self.questionV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goQuestionList)]];
    
    

    
//    self.editModifyBtn.userInteractionEnabled = YES;
//    [self.nameLb addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quitLogin)]];
    
    [self.editModifyBtn addTarget:self action:@selector(showNicknameModify) forControlEvents:UIControlEventTouchUpInside];
    
    _curOrderLb.text = MyString(@"my_trips");
    _curOrdersLb.text = MyString(@"n_orders");
    _historyOrderLb.text = MyString(@"past_trips");
    _historyOrdersLb.text = MyString(@"n_orders");
    _moreFunctionLb.text = MyString(@"more_functions");
    _feedbackLb.text = MyString(@"feedback");
    _pointLb.text = MyString(@"my_points");
    _serviceLb.text = MyString(@"contact_support");
    _aboutUsLb.text = MyString(@"about_us");
    _settingLb.text = MyString(@"settings");
    _questionLb.text = MyString(@"faq");
    
}
//- (void)viewWillDisappear:(BOOL)animated{
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
//
//}
//
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
//}

- (void)goCurOrder{
    YLCurOrderVC *vc = [YLCurOrderVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)goHistoryOrder{
    YLHistoryOrderVC *vc = [YLHistoryOrderVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)goFeedbac{
    YLFeedbackVC *vc = [YLFeedbackVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)goWallet{
    YLWalletVC *vc = [YLWalletVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)goAboutUs{
    YLAboutUSVC *vc = [YLAboutUSVC new];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)goSetting{
    YLSettingVC *vc = [YLSettingVC new];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)goQuestionList{
    YLQuestionListVc *vc = [YLQuestionListVc new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)quitLogin{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:MyString(@"prompt") message:MyString(@"logout_confirmation") preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:MyString(@"yes") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"" forKey:@"AccessToken"];
        [defaults synchronize];
        
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        RCDMainTabBarViewController *mainTabBarVC = [[RCDMainTabBarViewController alloc] init];
        RCDNavigationViewController *nav = [[RCDNavigationViewController alloc] initWithRootViewController:mainTabBarVC];
        app.window.rootViewController = nav;
//        // 获取导航控制器的根视图控制器
//        UIViewController *rootViewController = [self.navigationController.viewControllers firstObject];
//        // 将导航堆栈设置为只包含根视图控制器
//        [self.navigationController setViewControllers:@[rootViewController] animated:YES];
////        YLLoginVC *vc = [YLLoginVC new];
////        [self.navigationController pushViewController:vc animated:YES];
    }];
    [alertController addAction:yesAction];
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:MyString(@"no") style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:noAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)getData{
    [super getData];
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/member/myInfo" parameters:nil complete:^(id ob) {
        [self.avatarIV sd_setImageWithURL:[NSURL URLWithString:ob[@"icon"]]];
        self.nameLb.text = ob[@"nickname"];
        self.levelLb.text = ob[@"level"];
    }];
    
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/order/getMyHistoryJourney" parameters:nil complete:^(id ob) {
        self.dataArray1 = [YLOrderBean mj_objectArrayWithKeyValuesArray:ob];
        self.historyNumLb.text = [NSString stringWithFormat:@"%lu",self.dataArray1.count];
    }];
    
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/order/getMyJourney" parameters:nil complete:^(id ob) {
        self.dataArray2 = [YLOrderBean mj_objectArrayWithKeyValuesArray:ob];
        self.curNumLb.text = [NSString stringWithFormat:@"%lu",self.dataArray2.count];
    }];
}

- (void)getCustomerService{
    PXWeakSelf
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"platform"] = @"2";
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/aboutUS/getCustomerService" parameters:dic complete:^(id ob) {
        NSArray*array = [YLServiceBean mj_objectArrayWithKeyValuesArray:ob];
        YLServiceBean *bean;
        for (YLServiceBean *item in array) {
            if([item.name isEqualToString:@"IOS"]){
                bean = item;
                break;
            }
        }
        NSString *url = [NSString stringWithFormat:@"https://wa.me/%@",bean.link];
        NSURL *whatsappURL = [NSURL URLWithString: @"whatsapp://"];
        NSURL *ChatsURL = [NSURL URLWithString: url];

        //判断本地是否存在WhatsApp应用，存在才进行跳转
        if ([[UIApplication sharedApplication] canOpenURL: whatsappURL]) {
            [[UIApplication sharedApplication] openURL: ChatsURL];
        } else {
            NSString *str = [NSString stringWithFormat:MyString(@"contact_support_whatsapp"),bean.link];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:MyString(@"prompt")
                                                                                     message:str
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:MyString(@"confirm")
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
                                                             }];
            [alertController addAction:okAction];
            [weakSelf presentViewController:alertController animated:YES completion:nil];
            // Cannot open whatsapp
            NSLog(@"不能打开WhatsApp");
        }
    }];
}

- (void)showNicknameModify{
    PXWeakSelf
    YLModifyNameV *v = [YLModifyNameV viewFormNib_];
    v.superVc = self;
    [v show:^{
        [weakSelf getData];
    }];
}
@end
