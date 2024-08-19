//
//  YLMerchantBean.m
//  luckrental
//
//  Created by kiikqjzq on 2023/9/18.
//

#import "YLMerchantBean.h"

@implementation YLMerchantBean
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"merchantId":@"id"};
}
@end
