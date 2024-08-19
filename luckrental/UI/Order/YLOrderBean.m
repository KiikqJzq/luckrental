//
//  YLOrderBean.m
//  luckrental
//
//  Created by kiikqjzq on 2023/10/5.
//

#import "YLOrderBean.h"
#import "RCDCommonDefine.h"
@implementation YLOrderBean

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"orderId":@"id"};
}

- (NSString *)statusShow{
    NSString *str = @"";
    if([_status isEqualToString:@"0"]){
        str = MyString(@"to_be_paid");
    }else if([_status isEqualToString:@"1"]){
        str =  MyString(@"store_confirmation");
    }else if([_status isEqualToString:@"2"]){
        str = MyString(@"awaiting_vehicle_assignment");
    }else if([_status isEqualToString:@"3"]){
        str = MyString(@"awaiting_pickup");
    }else if([_status isEqualToString:@"4"]){
        str = MyString(@"in_use");
    }else if([_status isEqualToString:@"5"]){
        str = MyString(@"order_completed");
    }else if([_status isEqualToString:@"6"]){
        str = MyString(@"order_failed");
    }
    return str;
}

@end
