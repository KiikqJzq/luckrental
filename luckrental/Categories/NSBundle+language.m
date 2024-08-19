//
//  NSBundle+language.m
//  luckrental
//
//  Created by kiikqjzq on 2023/10/17.
//

#import "NSBundle+language.h"
#import <objc/runtime.h>
static const char _bundle = 0;

@interface BundleEx : NSBundle

@end

@implementation BundleEx

- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName {
    NSBundle *bundle = objc_getAssociatedObject(self, &_bundle);
    return bundle ? [bundle localizedStringForKey:key value:value table:tableName] : [super localizedStringForKey:key value:value table:tableName];
}

@end

@implementation NSBundle (Language)

+ (void)setLanguage:(NSString *)language {
    // 保证设置语言的操作只执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 更改主NSBundle的类为BundleEx类
        object_setClass([NSBundle mainBundle], [BundleEx class]);
    });

    // 获取主NSBundle
    NSBundle *mainBundle = [NSBundle mainBundle];

    // 获取当前保存在NSUserDefaults standardUserDefaults中的数据
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *existingUserDefaultsData = [userDefaults dictionaryRepresentation];

    // 如果提供了语言，创建一个新的Bundle，否则为nil
    NSBundle *languageBundle = nil;
    if (language) {
        NSString *path = [mainBundle pathForResource:language ofType:@"lproj"];
        if (path) {
            languageBundle = [NSBundle bundleWithPath:path];
        }
    }

    // 将语言Bundle关联到主NSBundle
    objc_setAssociatedObject(mainBundle, &_bundle, languageBundle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    // 重新设置之前保存的数据
    [existingUserDefaultsData enumerateKeysAndObjectsUsingBlock:^(NSString *key, id value, BOOL *stop) {
        [userDefaults setObject:value forKey:key];
    }];
    [userDefaults synchronize];
}

@end
