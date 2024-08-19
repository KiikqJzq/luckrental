//
//  RCDUploadAPI.m
//  SealTalk
//
//  Created by LiFei on 2019/6/14.
//  Copyright © 2019 RongCloud. All rights reserved.
//

#import "RCDUploadAPI.h"
#import "YLHTTPUtility.h"
#import "RCDCommonDefine.h"

#import <AFNetworking/AFNetworking.h>

@implementation RCDUploadAPI


+ (void)uploadImage:(NSData *)image complete:(void (^)(NSString *))completeBlock {
        NSMutableDictionary *params = [NSMutableDictionary new];

        //获取系统当前的时间戳
        NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval now = [dat timeIntervalSince1970];
        NSString *timeString = [NSString stringWithFormat:@"%f.png", now];
        NSString *url =  [NSString stringWithFormat:@"%@%@",DEMO_SERVER,@"/api/order/upload"];

        NSData *imageData = image;

        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager POST:url
            parameters:params
            headers:nil
            constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                [formData appendPartWithFileData:imageData
                                            name:@"file"
                                        fileName:timeString
                                        mimeType:@"application/octet-stream"];
            }
            progress:nil
            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable response) {
                NSString *imageUrl = response[@"url"];
               
                if (completeBlock) {
                    completeBlock(imageUrl);
                }
            }
            failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"uploadImage 请求失败");
                if (completeBlock) {
                    completeBlock(nil);
                }
            }];
}

@end
