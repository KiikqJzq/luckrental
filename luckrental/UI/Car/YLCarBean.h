//
//  YLCarBean.h
//  luckrental
//
//  Created by kiikqjzq on 2023/9/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLCarBean : NSObject
@property(nonatomic,strong)NSString *carId;
@property(nonatomic,strong)NSString *carTitle;
@property(nonatomic,strong)NSString *category;
@property(nonatomic,strong)NSString *url1;
@property(nonatomic,strong)NSString *mobileUrl;
@property(nonatomic,strong)NSString *descript;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *brand;
@property(nonatomic,strong)NSString *model;
@property(nonatomic,strong)NSString *seats;
@property(nonatomic,strong)NSString *automatic;
@property(nonatomic,assign)int pinfen;
@property(nonatomic,strong)NSArray *lableList;
@property(nonatomic,strong)NSArray *commentList;
@property(nonatomic,assign)int rentNum;

@end

NS_ASSUME_NONNULL_END
