//
//  YLTravelListVC.h
//  luckrental
//
//  Created by kiikqjzq on 2024/8/12.
//

#import "YLBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLTravelListVC : YLBaseVC
@property (weak, nonatomic) IBOutlet UICollectionView *cv;
@property (weak, nonatomic) IBOutlet UITextField *searchTV;
@property (weak, nonatomic) IBOutlet UILabel *searchLb;
@property (weak, nonatomic) IBOutlet UICollectionView *typeCv;

@end

NS_ASSUME_NONNULL_END
