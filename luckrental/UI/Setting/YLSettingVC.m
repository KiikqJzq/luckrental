//
//  YLSettingVC.m
//  luckrental
//
//  Created by kiikqjzq on 2023/12/28.
//

#import "YLSettingVC.h"
#import "YLResetPwdVC.h"
#import "AppDelegate.h"
#import "RCDMainTabBarViewController.h"
#import "RCDNavigationViewController.h"
@interface YLSettingVC ()
@property (weak, nonatomic) IBOutlet UILabel *resetLb;
@property (weak, nonatomic) IBOutlet UILabel *logOutLb;
@property (weak, nonatomic) IBOutlet UILabel *quitLb;
@property (weak, nonatomic) IBOutlet UIView *resetPwdV;
@property (weak, nonatomic) IBOutlet UIView *logOutV;
@property (weak, nonatomic) IBOutlet UIView *quitV;

@end

@implementation YLSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = MyString(@"settings");
    
    self.resetPwdV.userInteractionEnabled = YES;
    [self.resetPwdV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goResetPwd)]];
    
    self.logOutV.userInteractionEnabled = YES;
    [self.logOutV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showLogout)]];
    
    self.quitV.userInteractionEnabled = YES;
    [self.quitV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quitLogin)]];

    _resetLb.text = MyString(@"reset_password");
    _logOutLb.text = MyString(@"logout_account");
    _quitLb.text = MyString(@"logout");

}

- (void)goResetPwd{
    YLResetPwdVC *vc = [YLResetPwdVC new];
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
        app.window.rootViewController = nav;    }];
    [alertController addAction:yesAction];
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:MyString(@"no") style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:noAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)showLogout{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:MyString(@"prompt") message:MyString(@"logout_confirmation_message") preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:MyString(@"yes") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self logout];
    }];
    [alertController addAction:yesAction];
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:MyString(@"no") style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:noAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)logout{
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodPost URLString:@"/api/member/logout" parameters:nil complete:^(id ob) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"" forKey:@"AccessToken"];
        [defaults synchronize];
        
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        RCDMainTabBarViewController *mainTabBarVC = [[RCDMainTabBarViewController alloc] init];
        RCDNavigationViewController *nav = [[RCDNavigationViewController alloc] initWithRootViewController:mainTabBarVC];
        app.window.rootViewController = nav;
    }];

}

- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

@end
