//
//  YLTravelListVC.h
//  luckrental
//
//  Created by kiikqjzq on 2024/8/12.
//

#import "YLBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLTravelListVC : YLBaseVC
@property (weak, nonatomic) IBOutlet UISegmentedControl *segCon;
@property (weak, nonatomic) IBOutlet UICollectionView *cv;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollV;
@property (weak, nonatomic) IBOutlet UITextField *searchTV;
@property (weak, nonatomic) IBOutlet UILabel *searchLb;

@end

NS_ASSUME_NONNULL_END
