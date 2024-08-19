//
//  YLPayInfoBean.h
//  luckrental
//
//  Created by kiikqjzq on 2023/11/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLPayInfoBean : UIView
@property(nonatomic,strong)NSString *firstStep;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *fpsId;
@property(nonatomic,strong)NSString *secondStep;
@property(nonatomic,strong)NSString *tip;
@property(nonatomic,strong)NSString *cashWarning;

@property(nonatomic,strong)NSString *i18nConfig;
@end

NS_ASSUME_NONNULL_END
