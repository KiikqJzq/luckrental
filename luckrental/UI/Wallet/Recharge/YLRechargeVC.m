//
//  YLRechargeVC.m
//  luckrental
//
//  Created by kiikqjzq on 2023/9/16.
//

#import "YLRechargeVC.h"
#import "YLPayUploadV.h"
#import "YLPayRateV.h"
#import "UIView+Nib.h"
#import "YLRechargeCell.h"
#import "YLRechargeBean.h"
@interface YLRechargeVC ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *backIV;
@property (weak, nonatomic) IBOutlet UICollectionView *cv;
@property (weak, nonatomic) IBOutlet UITextField *tf;
@property (weak, nonatomic) IBOutlet UIImageView *zskIV;
@property (weak, nonatomic) IBOutlet UIImageView *cashIV;
@property (weak, nonatomic) IBOutlet UIButton *summitBtn;
@property (weak, nonatomic) IBOutlet UILabel *balanceTitleLb;
@property (weak, nonatomic) IBOutlet UIView *zskV;
@property (weak, nonatomic) IBOutlet UIView *cashV;
@property (weak, nonatomic) IBOutlet UILabel *priceLb;
@property (strong, nonatomic)NSString *payType;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *zskLb;
@property (strong, nonatomic)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UILabel *cashLb;
@property (weak, nonatomic) IBOutlet UILabel *priceTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *balanceLb;
@property (weak, nonatomic) IBOutlet UILabel *rechargeLb;
@property (weak, nonatomic) IBOutlet UILabel *payTypeLb;
@end

@implementation YLRechargeVC

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)initUI{
    [super initUI];
    
    _titleLb.text  = MyString(@"points_recharge");
    _priceTitleLb.text = MyString(@"points_balance");
    _rechargeLb.text = MyString(@"points_recharge");
    _payTypeLb.text = MyString(@"payment_method");
    _tf.placeholder = MyString(@"other_recharge_amount");
    _zskLb.text = MyString(@"fast_transfer");
    _cashLb.text = MyString(@"cash_payment");
    _priceTitleLb.text = MyString(@"amount");
    _balanceTitleLb.text = MyString(@"points_balance");
    [_summitBtn setTitle:MyString(@"confirm_recharge") forState:UIControlStateNormal];
    
    _backIV.userInteractionEnabled = YES;
    [_backIV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBack)]];
    
    _zskV.userInteractionEnabled = YES;
    [_zskV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setZsk)]];
    
    _cashV.userInteractionEnabled = YES;
    [_cashV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setCash)]];
    
    [_summitBtn addTarget:self action:@selector(showPayDialog) forControlEvents:UIControlEventTouchUpInside];
    
    // 设置UICollectionViewFlowLayout，定义布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(166, 68); // 每个 cell 的大小
    flowLayout.minimumInteritemSpacing = 0; // 列间距
    flowLayout.minimumLineSpacing = 12; // 行间距
    _cv.collectionViewLayout=flowLayout;
    [_cv setShowsHorizontalScrollIndicator:NO];
    [_cv setShowsVerticalScrollIndicator:NO];
    _cv.scrollEnabled = NO;
    _cv.delegate = self;
    _cv.dataSource = self;
    [_cv registerNib:[UINib nibWithNibName:NSStringFromClass([YLRechargeCell class])bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"YLRechargeCell"];
}

- (void)setData{
//    _dataArray = [NSMutableArray new];
//    YLRechargeBean *bean = [YLRechargeBean new];
//    bean.amount = @"100";
//    bean.price = @"100";
//    [_dataArray addObject:bean];
//    YLRechargeBean *bean2 = [YLRechargeBean new];
//    bean2.amount = @"500";
//    bean2.price = @"500";
//    [_dataArray addObject:bean2];
//    YLRechargeBean *bean3 = [YLRechargeBean new];
//    bean3.amount = @"1000";
//    bean3.price = @"1000";
//    [_dataArray addObject:bean3];
//    YLRechargeBean *bean4 = [YLRechargeBean new];
//    bean4.amount = @"2000";
//    bean4.price = @"2000";
//    [_dataArray addObject:bean4];
//    YLRechargeBean *bean5 = [YLRechargeBean new];
//    bean5.amount = @"3000";
//    bean5.price = @"3000";
//    [_dataArray addObject:bean5];
//    YLRechargeBean *bean6 = [YLRechargeBean new];
//    bean6.amount = @"5000";
//    bean6.price = @"5000";
//    [_dataArray addObject:bean6];
//    [_cv reloadData];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}


- (void)setZsk{
    [_zskIV setImage:[UIImage imageNamed:@"ic_hook_sel"]];
    [_cashIV setImage:[UIImage imageNamed:@"ic_hook_nor"]];
    _payType = @"1";
}

- (void)setCash{
    [_cashIV setImage:[UIImage imageNamed:@"ic_hook_sel"]];
    [_zskIV setImage:[UIImage imageNamed:@"ic_hook_nor"]];
    _payType = @"2";
}


- (void)showPayDialog {
    NSString *rid;
    NSString *amount;
    for(YLRechargeBean *bean in _dataArray){
        if(bean.isSelected){
            rid = bean.rId;
            amount = bean.rechargeAmount;
            break;
        }
    }
    if(!_payType || _payType.length == 0){
        [self.view makeToast:MyString(@"select_payment_method")];
        return;
    }
    
    YLPayRateV *v = [YLPayRateV viewFormNib_];
    v.rid = rid;
    v.amount = amount;
    v.payType = self.payType;
    v.dialogType = 1;
    v.superVc = self;
    [v show:^{
        NSLog(@"123");
    }];
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"YLRechargeCell";
    YLRechargeBean *bean = self.dataArray[indexPath.row];
    YLRechargeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell initWithDate:bean];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    for(YLRechargeBean *bean in _dataArray){
        bean.isSelected = NO;
    }
    YLRechargeBean *bean = self.dataArray[indexPath.row];
    bean.isSelected = YES;
    self.priceLb.text = bean.rechargeAmount;
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

- (void)getData{
    [super getData];
    PXWeakSelf
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/member/getBalance" parameters:nil complete:^(id ob) {
        weakSelf.balanceLb.text = [ob stringValue];
    }];
    
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/order/getRechargeList" parameters:nil complete:^(id ob) {
        weakSelf.dataArray = [YLRechargeBean mj_objectArrayWithKeyValuesArray:ob];
        YLRechargeBean *item = weakSelf.dataArray[0];
        item.isSelected = YES;
        weakSelf.priceLb.text = item.rechargeAmount;
        [weakSelf.cv reloadData];
    }];
}
@end
