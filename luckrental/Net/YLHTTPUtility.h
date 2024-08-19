//
//  RCDHTTPUtility.h
//  SealTalk
//
//  Created by LiFei on 2019/5/30.
//  Copyright © 2019 RongCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YLHTTPResult.h"

typedef NS_ENUM(NSUInteger, HTTPMethod) {
    HTTPMethodGet = 1,
    HTTPMethodHead = 2,
    HTTPMethodPost = 3,
    HTTPMethodPut = 4,
    HTTPMethodDelete = 5
};

@interface YLHTTPUtility : NSObject

//+ (void)requestWithHTTPMethod:(HTTPMethod)method
//                    URLString:(NSString *)URLString
//                   parameters:(NSDictionary *)parameters
//                     response:(void (^)(YLHTTPResult *result))responseBlock;

+ (void)requestWithHTTPMethod:(HTTPMethod)method
                    URLString:(NSString *)URLString
                   parameters:(NSMutableDictionary *)parameters
                     complete:(void (^)(id ob))completeBlock;

+ (void)requestWithHTTPMethod:(HTTPMethod)method
                    URLString:(NSString *)URLString
                   parameters:(NSMutableDictionary *)parameters
                     complete:(void (^)(id ob))completeBlock
                         fail:(void (^)(id ob))failBlock;

/*
 根据 RongCoreClient 是否设置代理，统一构造 NSURLSessionConfiguration

 @return 代理设置好的 NSURLSessionConfiguration 实例
*/
+ (NSURLSessionConfiguration *)rcSessionConfiguration;

// 全局配置 SDWebImage， 允许使用代理模式加载图片
+ (void)configProxySDWebImage;

//+ (void)requestWithURLString:(NSString *)URLString
//                   parameters:(NSDictionary *)parameters
//                    complete:(void (^)(id ob))completeBlock;
//
//+ (void)getRequestWithURLString:(NSString *)URLString
//                   parameters:(NSDictionary *)parameters
//                       complete:(void (^)(id ob))completeBlock;
//+ (void)requestWithURLString:(NSString *)URLString
//                   parameters:(NSDictionary *)parameters
//                    complete:(void (^)(id ob))completeBlock
//                        fail:(void (^)(id ob))failBlock;
@end
