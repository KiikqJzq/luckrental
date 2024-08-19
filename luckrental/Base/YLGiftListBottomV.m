//
//  YLGiftListBottomV.m
//  SealTalk
//
//  Created by kiikqjzq on 2023/12/20.
//  Copyright © 2023 RongCloud. All rights reserved.
//

#import "YLGiftListBottomV.h"
#import "UIView+Additions.h"
#import "RCDUtilities.h"
#import "MJExtension.h"
#import "Masonry.h"
#import "DoraemonDefine.h"
#import "YLHTTPUtility.h"
#import "YLGiftBean.h"
#import "MJExtension.h"
#import "YLChatGiftCell.h"

@interface YLGiftListBottomV()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *bgV;
@property (weak, nonatomic) IBOutlet UIView *contentV;
@property (weak, nonatomic) IBOutlet UIButton *senBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *cv;
@property (strong, nonatomic)NSMutableArray *dataArray;
@property (nonatomic, copy) void(^ didPaySuccess)(void);

@end

@implementation YLGiftListBottomV

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (void)show:(void(^)(void))didPaySuccess{
    self.didPaySuccess = didPaySuccess;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(80, 120); // 每个 cell 的大小
    flowLayout.minimumInteritemSpacing = 0; // 列间距
    flowLayout.minimumLineSpacing = 0; // 行间距
    _cv.collectionViewLayout=flowLayout;
    
    [_cv setShowsHorizontalScrollIndicator:NO];
    [_cv setShowsVerticalScrollIndicator:NO];
    _cv.scrollEnabled = NO;
    _cv.delegate = self;
    _cv.dataSource = self;
    [_cv registerNib:[UINib nibWithNibName:NSStringFromClass([YLChatGiftCell class])bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"YLChatGiftCell"];
    
    self.bgV.userInteractionEnabled = YES;
    [self.bgV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)]];
    
    [self.senBtn addTarget:self action:@selector(summit) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.superVc.view addSubview:self];
    

    
    [UIView animateWithDuration:0.5 animations:^{
        self.bgV.alpha = 0.5;
        self.contentV.top = 100;
    }];
    [self getData];
}

- (void)getData{
    WEAKSELF(weakSelf)
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"type"] = @"1";
    [YLHTTPUtility getRequestWithURLString:@"gift/list" parameters:dic complete:^(id ob) {
        weakSelf.dataArray = [YLGiftBean mj_objectArrayWithKeyValuesArray:ob];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.cv reloadData];
        });
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"YLChatGiftCell";
    YLGiftBean *bean = self.dataArray[indexPath.row];
    YLChatGiftCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell setUI:bean];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    for (YLGiftBean *item in self.dataArray) {
        item.isSelected = NO;
    }
    YLGiftBean *bean = self.dataArray[indexPath.row];
    bean.isSelected = YES;
    [self.cv reloadData];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(0.01,0.01);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0.1, 0.1, 0.1, 0.1);
}


- (void)close{
    [UIView animateWithDuration:0.3 animations:^{
        self.bgV.alpha = 0.0;
        self.contentV.top = self.height;
        self.didPaySuccess();
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)summit{
    
    WEAKSELF(weakSelf)
    YLGiftBean *bean;
    for (YLGiftBean *item in self.dataArray) {
        if(item.isSelected == YES){
            bean = item;
            break;
        }
    }
    if(!bean){
        [DoraemonToastUtil showToastBlack:@"请选择一款礼物!" inView:weakSelf];
        return;
    }
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"userId"] = self.targetId;
    dic[@"giftId"] = bean.gId;
    [YLHTTPUtility requestWithURLString:@"gift/send" parameters:dic complete:^(id ob) {
        [DoraemonToastUtil showToastBlack:@"赠送成功" inView:self];
    }];
}

@end
