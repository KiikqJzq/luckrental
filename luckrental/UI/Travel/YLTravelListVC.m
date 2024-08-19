//
//  YLTravelListVC.m
//  luckrental
//
//  Created by kiikqjzq on 2024/8/12.
//

#import "YLTravelListVC.h"
#import "YLTravelInfoVC.h"
#import "YLTravelTypeBean.h"
#import "YLTravelBean.h"
#import "YLTravelListCell.h"
@interface YLTravelListVC ()<UICollectionViewDelegate, UICollectionViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) NSMutableArray *typeDataArray;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSString *typeId;
@end

@implementation YLTravelListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.typeId = @"";
    [self.segCon addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];

            
    // 计算每个 cell 的宽度
    CGFloat cellWidth = (RCDScreenWidth -13*2 - 12) / 2.0;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(cellWidth, 300); // 每个 cell 的大小, 高度保持不变
    flowLayout.minimumInteritemSpacing = 0; // 列间距
    flowLayout.minimumLineSpacing = 12; // 行间距
    
    
    _cv.collectionViewLayout=flowLayout;
    [_cv setShowsHorizontalScrollIndicator:NO];
    [_cv setShowsVerticalScrollIndicator:NO];
    _cv.scrollEnabled = NO;
    _cv.delegate = self;
    _cv.dataSource = self;
    [_cv registerNib:[UINib nibWithNibName:NSStringFromClass([YLTravelListCell class])bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"YLTravelListCell"];
    
    [self.segCon setApportionsSegmentWidthsByContent:YES];
    self.scrollV.showsHorizontalScrollIndicator = NO;
    
    self.searchLb.userInteractionEnabled = YES;
    [self.searchLb addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchClick)]];
    
    self.searchTV.delegate = self;
    [self.searchTV addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

}

- (void)getData{
    PXWeakSelf
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/travel/getTravelTypeList" parameters:nil complete:^(id ob) {
        weakSelf.typeDataArray = [YLTravelTypeBean mj_objectArrayWithKeyValuesArray:ob];
        
        YLTravelTypeBean *hot = [YLTravelTypeBean new];
        hot.name = MyString(@"popular");
        hot.tId = @"0";
        [weakSelf.typeDataArray insertObject:hot atIndex:0];
        [weakSelf.segCon removeAllSegments];
        for (int i = 0; i < weakSelf.typeDataArray.count; i++) {
            YLTravelTypeBean *typeBean = weakSelf.typeDataArray[i];
            NSString *name = typeBean.name;
            [weakSelf.segCon insertSegmentWithTitle:name atIndex:i animated:YES];
        }
        [weakSelf getHotTravelList];
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)segmentChanged:(UISegmentedControl *)sender {
    NSInteger selectedIndex = sender.selectedSegmentIndex;
    CGFloat segmentWidth = 100.0;
    CGFloat targetOffsetX = selectedIndex * segmentWidth - (self.view.frame.size.width / 2 - segmentWidth / 2);
    targetOffsetX = MAX(0, MIN(targetOffsetX, self.scrollV.contentSize.width - self.scrollV.frame.size.width));
    [self.scrollV setContentOffset:CGPointMake(targetOffsetX, 0) animated:YES];
    
    YLTravelTypeBean *bean = self.typeDataArray[selectedIndex];
    self.typeId = bean.tId;
    if(selectedIndex == 0){
        [self getHotTravelList];
    }else{
        [self getTravelList];
    }
    
    
}

- (void)getHotTravelList{
    PXWeakSelf
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"title"] = self.searchTV.text;
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/travel/getHotTravelList" parameters:dic complete:^(id ob) {
        weakSelf.dataArray = [YLTravelBean mj_objectArrayWithKeyValuesArray:ob];
        [weakSelf.cv reloadData];
    }];
}


- (void)getTravelList{
    PXWeakSelf
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"typeId"] = self.typeId;
    dic[@"title"] = self.searchTV.text;
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/travel/getTravelList" parameters:dic complete:^(id ob) {
        weakSelf.dataArray = [YLTravelBean mj_objectArrayWithKeyValuesArray:ob];
        [weakSelf.cv reloadData];
    }];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"YLTravelListCell";
    YLTravelBean *bean = self.dataArray[indexPath.row];
    YLTravelListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell initWithDate:bean];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    YLTravelBean *bean = self.dataArray[indexPath.row];
    YLTravelInfoVC *vc = [YLTravelInfoVC new];
    vc.tid = bean.tId;
    [self.navigationController pushViewController:vc animated:YES];
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


- (void)textFieldDidChange:(UITextField *)textField {
    if (textField.text.length == 0) {
        if ([self.typeId isEqualToString:@"0"]){
            [self getHotTravelList];
        }else{
            [self getTravelList];
        }
    } else {
        
    }
}

-(void)searchClick{
    if ([self.typeId isEqualToString:@"0"]){
        [self getHotTravelList];
    }else{
        [self getTravelList];
    }
}

@end
