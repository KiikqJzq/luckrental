//
//  YLMerchantBean.h
//  luckrental
//
//  Created by kiikqjzq on 2023/9/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLMerchantBean : NSObject
@property(nonatomic,strong)NSString *merchantId;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *subheading;
@property(nonatomic,strong)NSString *mobileUrl;
@property(nonatomic,strong)NSString *desctiption;
@property(nonatomic,strong)NSString *openingHours;
@property(nonatomic,strong)NSString *pinfen;
@property(nonatomic,strong)NSString *junjia;
@property(nonatomic,strong)NSString *sales;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *rate;
@property(nonatomic,strong)NSArray *jcCommentList;

@property(nonatomic,strong)NSString *i18nConfig;


@end

NS_ASSUME_NONNULL_END
