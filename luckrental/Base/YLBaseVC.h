//
//  YLBaseVC.h
//  luckrental
//
//  Created by kiikqjzq on 2023/9/14.
//

#import <UIKit/UIKit.h>
#import "YLHTTPUtility.h"
#import "MJExtension.h"
#import "Masonry.h"
#import "SDWebImage.h"
#import "UIView+Toast.h"
#import "RCDCommonDefine.h"


NS_ASSUME_NONNULL_BEGIN

@interface YLBaseVC : UIViewController
- (void)goBack;

- (void)initUI;

- (void)getData;

@end

NS_ASSUME_NONNULL_END
