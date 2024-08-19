//
//  RCDHTTPResult.m
//  SealTalk
//
//  Created by LiFei on 2019/5/30.
//  Copyright © 2019 RongCloud. All rights reserved.
//

#import "YLHTTPResult.h"

@implementation YLHTTPResult

- (NSString *)description {
    return [NSString stringWithFormat:@"success: %d, httpCode: %ld, errorCode: %ld, content: %@", self.success,
                                      (long)self.httpCode, (long)self.errorCode, self.content];
}

@end
