//
//  RCDLanguageManager.m
//  LanguageSettingDemo
//
//  Created by 孙浩 on 2019/2/17.
//  Copyright © 2019 rongcloud. All rights reserved.
//

#import "RCDLanguageManager.h"
#import "RCDCommonDefine.h"


@interface RCDLanguageManager ()

@end

@implementation RCDLanguageManager


+ (instancetype)sharedInstance {
    static RCDLanguageManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RCDLanguageManager alloc] init];
    });
    return sharedInstance;
}

- (void)setLanguage:(NSString *)language {
    [[NSUserDefaults standardUserDefaults] setObject:@[language] forKey:@"AppleLanguages"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    // 发送通知，通知界面重新加载
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LanguageChanged" object:nil];
}

- (NSString *)currentLanguage {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] firstObject];
}



@end
