//
//  YLServicesBean.h
//  luckrental
//
//  Created by kiikqjzq on 2023/10/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLServicesBean : NSObject
@property(nonatomic,assign)int seatPrice;
@property(nonatomic,strong)NSString *seatPriceDesc;
@property(nonatomic,strong)NSString *seatDesc;
@property(nonatomic,assign)int etcPrice;
@property(nonatomic,strong)NSString *etcPriceDesc;
@property(nonatomic,strong)NSString *etcDesc;
@property(nonatomic,strong)NSString *etcTip;
@property(nonatomic,assign)int tyrePrice;
@property(nonatomic,strong)NSString *tyreDesc;
@property(nonatomic,assign)int linsuranceItem1Price;
@property(nonatomic,strong)NSString *linsuranceItem1PriceDesc;
@property(nonatomic,strong)NSString *linsuranceItem1Desc;
@property(nonatomic,assign)int linsuranceItem2Price;
@property(nonatomic,strong)NSString *linsuranceItem2PriceDesc;
@property(nonatomic,strong)NSString *linsuranceItem2Desc;
@property(nonatomic,assign)int linsuranceItem3Price;
@property(nonatomic,strong)NSString *linsuranceItem3Desc;
@property(nonatomic,strong)NSString *linsuranceItem3Tip;
@property(nonatomic,strong)NSString *driverDesc;
@property(nonatomic,strong)NSString *driverTip;
@property(nonatomic,strong)NSString *i18nConfig;
@property(nonatomic,assign)int tyreAble;

@end

NS_ASSUME_NONNULL_END
