//
//  YLRechargeBean.h
//  luckrental
//
//  Created by kiikqjzq on 2023/10/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLRechargeBean : NSObject
@property(nonatomic,strong)NSString *rId;
@property(nonatomic,strong)NSString *rechargeAmount;
@property(nonatomic,strong)NSString *receiveAmount;
@property(nonatomic,assign)bool isSelected;
@end

NS_ASSUME_NONNULL_END
