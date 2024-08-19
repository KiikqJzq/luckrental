//
//  YLTravelBean.h
//  luckrental
//
//  Created by kiikqjzq on 2024/8/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLTravelBean : NSObject
@property(nonatomic,strong)NSString *tId;
@property(nonatomic,strong)NSString *mobileImg;
@property(nonatomic,strong)NSString *place;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *label;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *originalPrice;
@end

NS_ASSUME_NONNULL_END
