//
//  YLTravelListCell.m
//  luckrental
//
//  Created by kiikqjzq on 2024/8/12.
//

#import "YLTravelListCell.h"
#import "SDWebImage.h"
#import "YLOptionBean.h"
#import "YLCarFuncCell.h"




@implementation YLTravelListCell


- (void)awakeFromNib {
    [super awakeFromNib];
    
    UICollectionViewFlowLayout *flowLayout2 = [[UICollectionViewFlowLayout alloc] init];
    flowLayout2.itemSize = CGSizeMake(40, 20); // 每个 cell 的大小
    flowLayout2.minimumInteritemSpacing = 2; // 列间距
    flowLayout2.minimumLineSpacing = 0; // 行间距
    _cv.collectionViewLayout=flowLayout2;
    [_cv setShowsHorizontalScrollIndicator:NO];
    [_cv setShowsVerticalScrollIndicator:NO];
    _cv.scrollEnabled = NO;
    _cv.delegate = self;
    _cv.dataSource = self;
    [_cv registerNib:[UINib nibWithNibName:NSStringFromClass([YLCarFuncCell class])bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"YLCarFuncCell"];
}




- (void)initWithDate:(YLTravelBean*)bean{
    self.lb.text = bean.title;
    self.titleLb.text = bean.place;
    self.priceLb.text = [NSString stringWithFormat:MyString(@"price_up"),bean.price];
    
    NSDictionary *attributes = @{
        NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle],
    };

    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:MyString(@"price_up"),bean.originalPrice] attributes:attributes];
    self.originalPriceLb.attributedText = attributedText;
    
    NSAttributedString *attributedText2 = [[NSAttributedString alloc] initWithString:self.originalPriceTitleLb.text attributes:attributes];
    self.originalPriceTitleLb.attributedText = attributedText2;
    
    [self.iv sd_setImageWithURL:[NSURL URLWithString:bean.mobileImg]];
    
    _dataArray = [NSMutableArray new];
    NSArray *labelArray = [bean.label componentsSeparatedByString:@","];
    for (NSString *item in labelArray) {
        YLOptionBean *bean = [YLOptionBean new];
        bean.text = item;
        bean.isSelected = YES;
        [_dataArray addObject:bean];
    }
    [self.cv reloadData];

}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"YLCarFuncCell";
    YLOptionBean *bean = _dataArray[indexPath.row];
    YLCarFuncCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.contentLb.text = bean.text;
    return cell;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 2;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(0.01,0.01);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0.1, 0.1, 0.1, 0.1);
}

@end
