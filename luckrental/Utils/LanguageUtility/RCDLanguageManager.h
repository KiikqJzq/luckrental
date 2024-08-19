//
//  RCDLanguageManager.h
//  LanguageSettingDemo
//
//  Created by 孙浩 on 2019/2/17.
//  Copyright © 2019 rongcloud. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCDLanguageManager : NSObject


+ (instancetype)sharedInstance;

- (void)setLanguage:(NSString *)language;
- (NSString *)currentLanguage;

@end

NS_ASSUME_NONNULL_END
