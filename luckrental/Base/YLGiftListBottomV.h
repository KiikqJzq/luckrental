//
//  YLGiftListBottomV.h
//  SealTalk
//
//  Created by kiikqjzq on 2023/12/20.
//  Copyright © 2023 RongCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLGiftListBottomV : UIView
@property (nonatomic, strong) UIViewController *superVc;
@property (nonatomic, strong) NSString *targetId;

- (void)show:(void(^)(void))didPaySuccess;

- (void)close;
@end

NS_ASSUME_NONNULL_END
