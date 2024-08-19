//
//  YLQuestionListBean.h
//  luckrental
//
//  Created by kiikqjzq on 2024/8/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLQuestionListBean : NSObject
@property(nonatomic,strong)NSString *qId;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *i18nConfig;
@property(nonatomic,strong)NSArray *questions;
@end

NS_ASSUME_NONNULL_END
