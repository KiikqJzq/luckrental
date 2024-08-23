//
//  YLTravelTypeBean.h
//  luckrental
//
//  Created by kiikqjzq on 2024/8/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLTravelTypeBean : NSObject
@property(nonatomic,strong)NSString *tId;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,assign)bool isSelected;
@end

NS_ASSUME_NONNULL_END
