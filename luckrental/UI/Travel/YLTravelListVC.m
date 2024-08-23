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
#import "YLTravelTypeCell.h"

@interface YLTravelListVC ()<UICollectionViewDelegate, UICollectionViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) NSMutableArray *typeDataArray;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSString *typeId;

@end

@implementation YLTravelListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.typeId = @"";
    self.searchTV.placeholder = MyString(@"enter_keywords");
    self.searchLb.text = MyString(@"search");
    
    // 计算每个 cell 的宽度
    CGFloat cellWidth = (RCDScreenWidth -13*2 - 12) / 2.0;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(cellWidth, 300); // 每个 cell 的大小, 高度保持不变
    flowLayout.minimumInteritemSpacing = 0; // 列间距
    flowLayout.minimumLineSpacing = 12; // 行间距
    
    
    _cv.collectionViewLayout=flowLayout;
    _cv.tag = 111;
    [_cv setShowsHorizontalScrollIndicator:NO];
    [_cv setShowsVerticalScrollIndicator:NO];
    _cv.scrollEnabled = NO;
    _cv.delegate = self;
    _cv.dataSource = self;
    [_cv registerNib:[UINib nibWithNibName:NSStringFromClass([YLTravelListCell class])bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"YLTravelListCell"];
    
    self.searchLb.userInteractionEnabled = YES;
    [self.searchLb addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchClick)]];

    self.searchTV.delegate = self;
    [self.searchTV addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    UICollectionViewFlowLayout *flowLayout2 = [[UICollectionViewFlowLayout alloc] init];
    flowLayout2.minimumInteritemSpacing = 0; // Column spacing
    flowLayout2.minimumLineSpacing = 8; // Row spacing
    flowLayout2.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _typeCv.collectionViewLayout=flowLayout2;
    _typeCv.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.1];;
    _typeCv.tag = 222;
    [_typeCv setShowsHorizontalScrollIndicator:NO];
    [_typeCv setShowsVerticalScrollIndicator:NO];
    _typeCv.delegate = self;
    _typeCv.dataSource = self;
    [_typeCv registerNib:[UINib nibWithNibName:NSStringFromClass([YLTravelTypeCell class])bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"YLTravelTypeCell"];
    
}

- (void)getData{
    PXWeakSelf
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/travel/getTravelTypeList" parameters:nil complete:^(id ob) {
        weakSelf.typeDataArray = [YLTravelTypeBean mj_objectArrayWithKeyValuesArray:ob];
        YLTravelTypeBean *hot = [YLTravelTypeBean new];
        hot.name = MyString(@"popular");
        hot.tId = @"0";
        hot.isSelected = YES;
        [weakSelf.typeDataArray insertObject:hot atIndex:0];
        [weakSelf.typeCv reloadData];
        [weakSelf getHotTravelList];
    }];
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
    if (collectionView.tag == 111) {
        return _dataArray.count;
    }else{
        return _typeDataArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag == 111) {
        static NSString *identify = @"YLTravelListCell";
        YLTravelBean *bean = self.dataArray[indexPath.row];
        YLTravelListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
        [cell initWithDate:bean];
        return cell;
    }else{
        static NSString *identify = @"YLTravelTypeCell";
        YLTravelTypeBean *bean = self.typeDataArray[indexPath.row];
        YLTravelTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
        [cell initWithDate:bean];
        return cell;
    }

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag == 111) {
        YLTravelBean *bean = self.dataArray[indexPath.row];
        YLTravelInfoVC *vc = [YLTravelInfoVC new];
        vc.tid = bean.tId;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        for (YLTravelTypeBean *item in _typeDataArray) {
            item.isSelected = NO;
        }
        YLTravelTypeBean *bean = self.typeDataArray[indexPath.row];
        bean.isSelected = YES;
        self.typeId = bean.tId;
        [self.typeCv reloadData];
        
        [collectionView scrollToItemAtIndexPath:indexPath
                                   atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                           animated:YES];
        
        if (0 == indexPath.row) {
            [self getHotTravelList];
        } else {
            [self getTravelList];
        }
    }
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


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(collectionView.tag == 111){
        CGFloat cellWidth = (RCDScreenWidth -13*2 - 12) / 2.0;
        return CGSizeMake(cellWidth, 300);
    }else{
        YLTravelTypeBean *bean = self.typeDataArray[indexPath.row];
        NSString *text = bean.name;
        UIFont *font = [UIFont systemFontOfSize:15];
        CGSize textSize = [text sizeWithAttributes:@{NSFontAttributeName: font}];
        CGFloat width = textSize.width + 40;
        CGFloat height = 35;
        return CGSizeMake(width, height);
    }
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
