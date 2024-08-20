//
//  YLTravelListCell.h
//  luckrental
//
//  Created by kiikqjzq on 2024/8/12.
//

#import <UIKit/UIKit.h>
#import "YLTravelBean.h"
#import "RCDCommonDefine.h"
NS_ASSUME_NONNULL_BEGIN

@interface YLTravelListCell : UICollectionViewCell<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *iv;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *lb;
@property (weak, nonatomic) IBOutlet UILabel *priceTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *priceLb;
@property (weak, nonatomic) IBOutlet UILabel *originalPriceTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *originalPriceLb;
@property (strong, nonatomic)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UICollectionView *cv;
- (void)initWithDate:(YLTravelBean*)bean;

@end

NS_ASSUME_NONNULL_END
