//
//  YLCommentBean.h
//  luckrental
//
//  Created by kiikqjzq on 2023/12/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLCommentBean : NSObject
@property(nonatomic,strong)NSString *cId;
@property(nonatomic,strong)NSString *userId;
@property(nonatomic,strong)NSString *userIcon;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *userPhone;
@property(nonatomic,strong)NSString *orderId;
@property(nonatomic,strong)NSString *experience;
@property(nonatomic,strong)NSString *mapping;
@property(nonatomic,strong)NSString *rate;
@property(nonatomic,strong)NSString *img;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,assign)int upvote;
@property(nonatomic,strong)NSString *submitDate;
@property(nonatomic,strong)NSString *createTime;
@end

NS_ASSUME_NONNULL_END
