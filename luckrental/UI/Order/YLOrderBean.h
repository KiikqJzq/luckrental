//
//  YLOrderBean.h
//  luckrental
//
//  Created by kiikqjzq on 2023/10/5.
//

#import <Foundation/Foundation.h>
#import "YLCarBean.h"
NS_ASSUME_NONNULL_BEGIN

@interface YLOrderBean : NSObject
@property(nonatomic,strong)NSString *orderId;
@property(nonatomic,strong)NSString *carTitle;
@property(nonatomic,strong)NSString *pickCarDate;
@property(nonatomic,strong)NSString *returnCarDate;
@property(nonatomic,strong)NSString *pickCarAddress;
@property(nonatomic,strong)NSString *returnCarAddress;
@property(nonatomic,strong)NSString *reserveName;
@property(nonatomic,strong)NSString *reservePhone;
@property(nonatomic,strong)NSString *reserveCard;
@property(nonatomic,strong)NSString *receiveService;
@property(nonatomic,strong)NSString *seatService;
@property(nonatomic,strong)NSString *seatServiceNum;
@property(nonatomic,strong)NSString *insuranceService;
@property(nonatomic,strong)NSString *insuranceServiceNum;
@property(nonatomic,strong)NSString *etcService;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *pointDeduction;
@property(nonatomic,strong)NSString *actualPrice;


@property(nonatomic,strong)YLCarBean *carInfo;

- (NSString *)statusShow;
@end

NS_ASSUME_NONNULL_END
