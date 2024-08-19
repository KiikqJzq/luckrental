//
//  AppDelegate.m
//  luckrental
//
//  Created by kiikqjzq on 2023/9/11.
//

#import "AppDelegate.h"
#import "RCDNavigationViewController.h"
#import "YLLoginVC.h"
#import "RCDMainTabBarViewController.h"
#import "NSBundle+language.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *i18nConfig = [defaults objectForKey:@"i18nConfig"];
    if(!i18nConfig){
        [defaults setObject:@"Chinese" forKey:@"i18nConfig"];
        [defaults synchronize];
        [NSBundle setLanguage:@"zh-Hant"];
    }else{
        if([i18nConfig isEqualToString:@"English"]){
            [NSBundle setLanguage:@"en"];
        }else if([i18nConfig isEqualToString:@"Chinese"]){
            [NSBundle setLanguage:@"zh-Hant"];
        }else if([i18nConfig isEqualToString:@"Korean"]){
            [NSBundle setLanguage:@"ko"];
        }else if([i18nConfig isEqualToString:@"Japan"]){
            [NSBundle setLanguage:@"ja"];
        }
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    RCDMainTabBarViewController *vc = [[RCDMainTabBarViewController alloc] init];
    RCDNavigationViewController *_navi = [[RCDNavigationViewController alloc] initWithRootViewController:vc];
    self.window.rootViewController = _navi;
    return YES;
}

@end
