//
//  YLHTTPUtility.m
//  SealTalk
//
//  Created by LiFei on 2019/5/30.
//  Copyright © 2019 RongCloud. All rights reserved.
//

#import "YLHTTPUtility.h"
#import <AFNetworking/AFNetworking.h>
#import "RCDCommonDefine.h"
#import "RCDCommonString.h"
#import <SDWebImage/SDWebImage.h>
#import "UIView+Toast.h"
#import "YLLoginVC.h"
#define HTTP_SUCCESS 200

//NSString *const BASE_URL = DEMO_SERVER;

static AFHTTPSessionManager *manager;

@implementation YLHTTPUtility

+ (AFHTTPSessionManager *)sharedHTTPManager {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        [self resetHTTPManager];
    });
    return manager;
}

+ (void)requestWithHTTPMethod:(HTTPMethod)method
                    URLString:(NSString *)URLString
                   parameters:(NSMutableDictionary *)parameters
                     complete:(void (^)(id))completeBlock{
    
    AFHTTPSessionManager *manager = [YLHTTPUtility sharedHTTPManager];
//    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *baseURL = DEMO_SERVER;
//    NSString *url = [baseURL stringByAppendingPathComponent:URLString];
    NSString *url = [NSString stringWithFormat:@"%@%@",baseURL,URLString];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"AccessToken"];
    if (token && token.length > 0) {
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    }else{
        [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"Authorization"];
    }
    
    NSString *i18nConfig = [defaults objectForKey:@"i18nConfig"];
    if (i18nConfig && i18nConfig.length > 0) {
        if(!parameters){
            parameters = [NSMutableDictionary new];
        }
        parameters[@"i18nConfig"] = i18nConfig;
        [manager.requestSerializer setValue:i18nConfig forHTTPHeaderField:@"i18nConfig"];
    }
    
    switch (method) {
    case HTTPMethodGet: {
        [manager GET:url
           parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self dealResponse:responseObject :task complete:completeBlock fail:nil];

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSString *msg = [NSString stringWithFormat:@"请求异常%ld",(long)error.code];
            dispatch_async(dispatch_get_main_queue(), ^{
                UIView *view = [self topViewControllerForKeyWindow].view;
                [view makeToast:msg];
            });
        }];
        break;
    }


    case HTTPMethodPost: {
        [manager POST:url
           parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self dealResponse:responseObject :task complete:completeBlock fail:nil];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSString *msg = [NSString stringWithFormat:@"请求异常%ld",(long)error.code];
            dispatch_async(dispatch_get_main_queue(), ^{
                UIView *view = [self topViewControllerForKeyWindow].view;
                [view makeToast:msg];
            });
        }];
        break;
    }

 
    default:
        break;
    }
}


+ (void)requestWithHTTPMethod:(HTTPMethod)method
                    URLString:(NSString *)URLString
                   parameters:(NSMutableDictionary *)parameters
                     complete:(void (^)(id ob))completeBlock
                         fail:(void (^)(id ob))failBlock{
    
    AFHTTPSessionManager *manager = [YLHTTPUtility sharedHTTPManager];
//    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *baseURL = DEMO_SERVER;
//    NSString *url = [baseURL stringByAppendingPathComponent:URLString];
    NSString *url = [NSString stringWithFormat:@"%@%@",baseURL,URLString];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"AccessToken"];
    if (token && token.length > 0) {
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    }else{
        [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"Authorization"];
    }
    
    NSString *i18nConfig = [defaults objectForKey:@"i18nConfig"];
    if (i18nConfig && i18nConfig.length > 0) {
        if(!parameters){
            parameters = [NSMutableDictionary new];
        }
        parameters[@"i18nConfig"] = i18nConfig;
        [manager.requestSerializer setValue:i18nConfig forHTTPHeaderField:@"i18nConfig"];
    }
    
    switch (method) {
    case HTTPMethodGet: {
        [manager GET:url
           parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self dealResponse:responseObject :task complete:completeBlock fail:failBlock];

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSString *msg = [NSString stringWithFormat:@"请求异常%ld",(long)error.code];
            dispatch_async(dispatch_get_main_queue(), ^{
                UIView *view = [self topViewControllerForKeyWindow].view;
                [view makeToast:msg];
            });
        }];
        break;
    }


    case HTTPMethodPost: {
        [manager POST:url
           parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self dealResponse:responseObject :task complete:completeBlock fail:failBlock];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSString *msg = [NSString stringWithFormat:@"请求异常%ld",(long)error.code];
            dispatch_async(dispatch_get_main_queue(), ^{
                UIView *view = [self topViewControllerForKeyWindow].view;
                [view makeToast:msg];
            });
        }];
        break;
    }

 
    default:
        break;
    }
}



+ (YLHTTPResult *)httpSuccessResult:(NSURLSessionDataTask *)task response:(id)responseObject {
    YLHTTPResult *result = [[YLHTTPResult alloc] init];
    result.httpCode = ((NSHTTPURLResponse *)task.response).statusCode;

    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        result.errorCode = [responseObject[@"code"] integerValue];
        result.content = responseObject[@"result"];
        result.success = (result.errorCode == HTTP_SUCCESS);
        if (!result.success) {
            NSLog(@"%@, {%@}", task.currentRequest.URL, result);
        }
    } else {
        result.success = NO;
    }

    return result;
}

+ (YLHTTPResult *)httpFailureResult:(NSURLSessionDataTask *)task error:(NSError *)error{
    YLHTTPResult *result = [[YLHTTPResult alloc] init];
    result.success = NO;
    result.httpCode = ((NSHTTPURLResponse *)task.response).statusCode;
    result.errorCode = result.httpCode;
    
    return result;
}

+ (void)saveCookieIfHave:(NSURLSessionDataTask *)task {
    NSString *cookieString = [[(NSHTTPURLResponse *)task.response allHeaderFields] valueForKey:@"Set-Cookie"];
    NSMutableString *finalCookie = [NSMutableString new];
    NSArray *cookieStrings = [cookieString componentsSeparatedByString:@","];
    for (NSString *temp in cookieStrings) {
        NSArray *tempArr = [temp componentsSeparatedByString:@";"];
        [finalCookie appendString:[NSString stringWithFormat:@"%@;", tempArr[0]]];
    }
    if (finalCookie.length > 0) {
        [DEFAULTS setObject:finalCookie forKey:RCDUserCookiesKey];
        [DEFAULTS synchronize];
        [[YLHTTPUtility sharedHTTPManager].requestSerializer setValue:finalCookie forHTTPHeaderField:@"Cookie"];
    }
}

+ (NSURLSessionConfiguration *)rcSessionConfiguration {
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    RCIMProxy *currentProxy = [[RCCoreClient sharedCoreClient] getCurrentProxy];
//
//    if (currentProxy && [currentProxy isValid]) {
//        NSString *proxyHost = currentProxy.host;
//        NSNumber *proxyPort = @(currentProxy.port);
//        NSString *proxyUserName = currentProxy.userName;
//        NSString *proxyPassword = currentProxy.password;
//
//        NSDictionary *proxyDict = @{
//            (NSString *)kCFStreamPropertySOCKSProxyHost: proxyHost,
//            (NSString *)kCFStreamPropertySOCKSProxyPort: proxyPort,
//            (NSString *)kCFStreamPropertySOCKSUser : proxyUserName,
//            (NSString *)kCFStreamPropertySOCKSPassword: proxyPassword
//        };
//
//        sessionConfiguration.connectionProxyDictionary = proxyDict;
//    }
    return sessionConfiguration;
}

// 全局配置 SDWebImage， 允许使用代理模式加载图片
+ (void)configProxySDWebImage {
    // 由于单例模式， 需要手动重置代理配置
    [self resetHTTPManager];
    
    SDWebImageDownloaderConfig *config = [SDWebImageDownloaderConfig defaultDownloaderConfig];
    config.sessionConfiguration = [self rcSessionConfiguration];
    SDWebImageDownloader *imageDownloader = [[SDWebImageDownloader alloc] initWithConfig:config];
    SDWebImageManager.defaultImageLoader = imageDownloader;
}

// 重试初始化 AFHTTPSessionManager
+ (void)resetHTTPManager {
    manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[self rcSessionConfiguration]];
    manager.completionQueue = dispatch_queue_create("cn.rongcloud.sealtalk.httpqueue", DISPATCH_QUEUE_SERIAL);
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", nil];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.validatesDomainName = NO;
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    manager.requestSerializer.HTTPShouldHandleCookies = YES;
    [manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    ((AFJSONResponseSerializer *)manager.responseSerializer).removesKeysWithNullValues = YES;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
}

+ (void)requestWithURLString:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                    complete:(void (^)(id ob))completeBlock{


    AFHTTPSessionManager *manager = [YLHTTPUtility sharedHTTPManager];
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *baseURL = DEMO_SERVER;
    NSString *url = [NSString stringWithFormat:@"%@%@",baseURL,URLString];

//    NSString *url = [baseURL stringByAppendingPathComponent:URLString];
    
    NSString *cookie = [DEFAULTS valueForKey:RCDUserCookiesKey];
    if (cookie && cookie.length > 0) {
        [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    }
    

    [manager POST:url
       parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completeBlock) {
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    NSInteger status = [responseObject[@"status"] integerValue];
                    if(status == 100){
                        completeBlock([[self class] httpSuccessResultNew:task response:responseObject]);
                    }
//                    else if (status == 106){
//                        ZXLoginAlertView *view = [ZXLoginAlertView shareLoginAlertView];
//                        [view show];
//                    }
                    else{
//                        NSString *message = [responseObject[@"message"] stringValue]?:@"请求异常";
//                        UIView *view = [UIViewController topViewControllerForKeyWindow].view;
//                        [DoraemonToastUtil showToastBlack:message inView:view];
//                        failBlock(false);
                    }
                }
            }
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *msg = [NSString stringWithFormat:@"请求异常%ld",(long)error.code];
        dispatch_async(dispatch_get_main_queue(), ^{
//            UIView *view = [UIViewController topViewControllerForKeyWindow].view;
//            [DoraemonToastUtil showToastBlack:msg inView:view];
//            failBlock(false);
        });
    }];
}


+ (void)requestWithURLString:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                    complete:(void (^)(id ob))completeBlock
                    fail:(void (^)(id ob))failBlock{


    AFHTTPSessionManager *manager = [YLHTTPUtility sharedHTTPManager];
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *baseURL = DEMO_SERVER;
//    NSString *url = [baseURL stringByAppendingPathComponent:URLString];
    NSString *url = [NSString stringWithFormat:@"%@%@",baseURL,URLString];

    NSString *cookie = [DEFAULTS valueForKey:RCDUserCookiesKey];
    if (cookie && cookie.length > 0) {
        [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    }
    

    [manager POST:url
       parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self dealResponse:responseObject :task complete:completeBlock fail:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *msg = [NSString stringWithFormat:@"请求异常%ld",(long)error.code];
        dispatch_async(dispatch_get_main_queue(), ^{
//            UIView *view = [UIViewController topViewControllerForKeyWindow].view;
//            [DoraemonToastUtil showToastBlack:msg inView:view];
//            failBlock(false);
        });
    }];
}


+ (void)getRequestWithURLString:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                    complete:(void (^)(id ob))completeBlock{


    AFHTTPSessionManager *manager = [YLHTTPUtility sharedHTTPManager];
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *baseURL = DEMO_SERVER;
    NSString *url = [baseURL stringByAppendingPathComponent:URLString];
    NSString *cookie = [DEFAULTS valueForKey:RCDUserCookiesKey];
    if (cookie && cookie.length > 0) {
        [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    }
    

    [manager GET:url
       parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completeBlock) {
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    NSInteger status = [responseObject[@"code"] integerValue];
                    if(status == 200){
                        completeBlock([[self class] httpSuccessResultNew:task response:responseObject]);
                    }
//                    else if (status == 106){
//                        ZXLoginAlertView *view = [ZXLoginAlertView shareLoginAlertView];
//                        [view show];
//                    }
                    else{
//                        NSString *message = [responseObject[@"message"] stringValue]?:@"请求异常";
//                        UIView *view = [UIViewController topViewControllerForKeyWindow].view;
//                        [DoraemonToastUtil showToastBlack:message inView:view];
//                        failBlock(false);
                    }
                }
            }
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *msg = [NSString stringWithFormat:@"请求异常%ld",(long)error.code];
        dispatch_async(dispatch_get_main_queue(), ^{
//            UIView *view = [UIViewController topViewControllerForKeyWindow].view;
//            [DoraemonToastUtil showToastBlack:msg inView:view];
//            failBlock(false);
        });
    }];
}


+ (id)httpSuccessResultNew:(NSURLSessionDataTask *)task response:(id)responseObject {
    id data;
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        NSInteger code = [responseObject[@"code"] integerValue];
//        NSString *msg = [responseObject[@"msg"] stringValue]?:@"请求异常";
        if(code == 0){
            data = responseObject[@"data"];
        }else{
//            UIView *view = [UIViewController topViewControllerForKeyWindow].view;
//            [view makeToast:message duration:2.0
//                   position:CSToastPositionCenter];
        }
    }
    return data;
}




+(void)dealResponse :(id)responseObject:(NSURLSessionDataTask *)task complete:(void (^)(id ob))completeBlock
               fail:(void (^)(id ob))failBlock{
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSInteger status = [responseObject[@"code"] integerValue];
            dispatch_async(dispatch_get_main_queue(), ^{
                if(status == 0){
                    if (completeBlock) {
                        completeBlock([[self class] httpSuccessResultNew:task response:responseObject]);
                    }
                }else if (status == 402){
                    
                    BOOL isViewControllerAlreadyExists = NO;
                    
                    UINavigationController *nav = [self topViewControllerForKeyWindow].navigationController;
                    for (UIViewController *viewController in nav.viewControllers) {
                        if ([viewController isKindOfClass:[YLLoginVC class]]) {
                            isViewControllerAlreadyExists = YES;
                            break;
                        }
                    }
                    if (!isViewControllerAlreadyExists) {
                        YLLoginVC *vc = [YLLoginVC new];
                        [[self topViewControllerForKeyWindow].navigationController pushViewController:vc animated:YES];
                    }
                     
                }else{
                    NSString *message = responseObject[@"msg"]?:@"请求异常";
                    if([task.originalRequest.URL.absoluteString containsString:@"login"] && status == 500){
                        message = MyString(@"username_password_error");
                    }else if([task.originalRequest.URL.absoluteString containsString:@"getPromotionCodeByCode"] && status == 500){
                        message = MyString(@"invalid_promo_code");
                    }
                    UIView *view = [self topViewControllerForKeyWindow].view;
                    [view makeToast:message];
                    if (failBlock) {
                        failBlock([[self class] httpFailureResult:task error:nil]);
                    }
                }
            });
        }
}

+ (UIViewController *)topViewControllerForKeyWindow {
    UIViewController *resultVC;
    UIWindow *keyWindow = nil;
    if ([[UIApplication sharedApplication].delegate respondsToSelector:@selector(window)]) {
        keyWindow = [[UIApplication sharedApplication].delegate window];
    }else{
        keyWindow = [UIApplication sharedApplication].windows.firstObject;
    }
    resultVC = [self _topViewController:[keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}


+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

@end
