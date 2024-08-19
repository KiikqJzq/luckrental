//
//  RCDMainTabBarViewController.m
//  RCloudMessage
//
//  Created by Jue on 16/7/30.
//  Copyright © 2016年 RongCloud. All rights reserved.
//

#import "RCDMainTabBarViewController.h"
#import "RCDCommonDefine.h"
#import "YLHomeVC.h"
#import "YLMineVC.h"
#import "YLTravelListVC.h"



static NSInteger RCD_MAIN_TAB_INDEX = 0;

@interface RCDMainTabBarViewController ()

@property NSUInteger previousIndex;

@property (nonatomic, strong) NSArray *tabTitleArr;

@property (nonatomic, strong) NSArray *imageArr;

@property (nonatomic, strong) NSArray *selectImageArr;

@property (nonatomic, strong) NSArray *animationImages;

// 声明属性
@property (nonatomic, strong) NSURLSession *urlSession;

@end

@implementation RCDMainTabBarViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        RCD_MAIN_TAB_INDEX = 0;
    }
    return self;
}

+ (NSInteger)currentTabBarItemIndex {
    return RCD_MAIN_TAB_INDEX;;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self rcdinitTabImages];
    [self setControllers];

    [self setTabBarItems];
    self.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeSelectedIndex:)
                                                 name:@"ChangeTabBarIndex"
                                               object:nil];

}

- (BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self setTabBarItems];
}

- (void)setControllers {
    YLHomeVC *homeVC = [[YLHomeVC alloc] init];
    YLTravelListVC *travelListVC = [[YLTravelListVC alloc] init];
    YLMineVC *mineVC = [[YLMineVC alloc] init];
    
    self.viewControllers = @[homeVC,travelListVC,mineVC];
}


- (void)setTabBarItems {
    self.tabBar.backgroundColor = [UIColor whiteColor];
    [self.viewControllers
        enumerateObjectsUsingBlock:^(__kindof UIViewController *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {

        if ([obj isKindOfClass:[YLHomeVC class]] || [obj isKindOfClass:[YLTravelListVC class]]|| [obj isKindOfClass:[YLMineVC class]]) {
                obj.tabBarItem.title = self.tabTitleArr[idx];
                obj.tabBarItem.image =
                    [[UIImage imageNamed:self.imageArr[idx]]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                obj.tabBarItem.selectedImage =
                    [[UIImage imageNamed:self.selectImageArr[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            } else {
                NSLog(@"Unknown TabBarController");
            }
//            [obj.tabBarController.tabBar bringBadgeToFrontOnItemIndex:(int)idx];
        }];
}

- (void)tabBarController:(UITabBarController *)tabBarController
 didSelectViewController:(UIViewController *)viewController {
    NSUInteger index = tabBarController.selectedIndex;
    RCD_MAIN_TAB_INDEX = index;
    if (self.previousIndex != index) {
        [self tabBarImageAnimation:index];
    }

    switch (index) {
    case 0:
        self.previousIndex = index;
        break;
    case 1:
        self.previousIndex = index;
        break;
    case 2:
        self.previousIndex = index;
        break;
    default:
        break;
    }
}

- (void)changeSelectedIndex:(NSNotification *)notify {
    NSInteger index = [notify.object integerValue];
    self.selectedIndex = index;
}

- (void)tabBarImageAnimation:(NSUInteger)index {
    NSMutableArray *arry = [NSMutableArray array];
    for (UIControl *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            for (UIView *imageView in tabBarButton.subviews) {
                if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
                    //添加动画:放大效果
                    [arry addObject:imageView];
                }
            }
        }
    }

    //快速切换时会出现前一个动画还在播放的情况，所以需要先停止前一个动画
    if (self.previousIndex >= arry.count) {
        return;
    }
    UIImageView *preImageView = arry[self.previousIndex];
    [preImageView stopAnimating];
    preImageView.animationImages = nil;

    UIImageView *imgView = arry[index];
    imgView.animationImages = self.animationImages[index];
    imgView.animationDuration = 1;
    imgView.animationRepeatCount = 1;
    [imgView startAnimating];
}

- (void)rcdinitTabImages{
    self.tabTitleArr = @[MyString(@"home"),MyString(@"highlight"),MyString(@"my")];
    self.imageArr = @[@"ic_home_n",@"ic_travel_n",@"ic_mine_n"];
    self.selectImageArr = @[@"ic_home_h",@"ic_travel_h",@"ic_mine_h"];
    NSArray *homeAnimationImages = @[[UIImage imageNamed:@"ic_home_n"],[UIImage imageNamed:@"ic_home_h"]];
    NSArray *travelAnimationImages = @[[UIImage imageNamed:@"ic_travel_n"],[UIImage imageNamed:@"ic_travel_h"]];
    NSArray *mineAnimationImages = @[[UIImage imageNamed:@"ic_mine_n"],[UIImage imageNamed:@"ic_mine_h"]];
    self.animationImages = @[homeAnimationImages,travelAnimationImages,mineAnimationImages];

}


//- (void)viewWillDisappear:(BOOL)animated{
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
//
//}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
@end
