//
//  YLCommentV.h
//  luckrental
//
//  Created by kiikqjzq on 2024/8/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLCommentV : UIView
@property (weak, nonatomic) IBOutlet UIView *bgV;
@property (weak, nonatomic) IBOutlet UIView *contentV;
@property (weak, nonatomic) IBOutlet UITextView *tv;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (nonatomic, strong) UIViewController *superVc;
@property (nonatomic, strong) NSString *travelId;
@property (nonatomic, assign) int dialogType;
@property (nonatomic, copy) void(^didClose)(void);


- (void)show:(void(^)(void))didPaySuccess;

- (void)close;


@end

NS_ASSUME_NONNULL_END
