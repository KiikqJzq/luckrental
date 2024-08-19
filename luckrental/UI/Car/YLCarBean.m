//
//  YLCarBean.m
//  luckrental
//
//  Created by kiikqjzq on 2023/9/18.
//

#import "YLCarBean.h"

@implementation YLCarBean
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"carId":@"id"};
}
@end
