//
//  YLPayUploadV.h
//  luckrental
//
//  Created by kiikqjzq on 2023/9/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLModifyNameV : UIView
@property (nonatomic, strong) UIViewController *superVc;
@property (nonatomic, assign) NSString *payType;
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *rid;
@property (nonatomic, assign) int dialogType;

- (void)show:(void(^)(void))didPaySuccess;

- (void)close;


@end

NS_ASSUME_NONNULL_END
