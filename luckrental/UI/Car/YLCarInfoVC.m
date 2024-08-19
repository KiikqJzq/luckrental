//
//  YLCarInfoVC.m
//  luckrental
//
//  Created by kiikqjzq on 2023/9/18.
//

#import "YLCarInfoVC.h"
#import "YLSummitOrderVC.h"
#import "YLOptionBean.h"
#import "YLCarFuncCell.h"
#import "YLScoreCell.h"
#import "YLCommentBean.h"
#import "YLEvaluaCell.h"

@interface YLCarInfoVC ()<UICollectionViewDelegate, UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollV;
@property (weak, nonatomic) IBOutlet UIView *contentV;
@property(nonatomic,strong)YLCarBean *carBean;
@property (weak, nonatomic) IBOutlet UIImageView *backBtn;
@property (weak, nonatomic) IBOutlet UIImageView *coverIV;
@property (weak, nonatomic) IBOutlet UILabel *priceDayLb;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UICollectionView *startsCV;
@property (weak, nonatomic) IBOutlet UICollectionView *labelCV;
@property (weak, nonatomic) IBOutlet UILabel *startsLb;
@property (weak, nonatomic) IBOutlet UILabel *rentInfoLb;
@property (weak, nonatomic) IBOutlet UILabel *ageLb;
@property (weak, nonatomic) IBOutlet UILabel *displacementLb;
@property (weak, nonatomic) IBOutlet UILabel *gasTypeLb;
@property (weak, nonatomic) IBOutlet UILabel *gasVolumeLb;
@property (weak, nonatomic) IBOutlet UILabel *seatLb;
@property (weak, nonatomic) IBOutlet UILabel *evaluateLb;
@property (weak, nonatomic) IBOutlet UILabel *evaluateMoreLb;
@property (weak, nonatomic) IBOutlet UITableView *evaluateTabV;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLb;
@property (weak, nonatomic) IBOutlet UIButton *summitBtn;
@property (weak, nonatomic) IBOutlet UILabel *topPriceLb;
@property (weak, nonatomic) IBOutlet UILabel *dayUnitLb;
@property (weak, nonatomic) IBOutlet UILabel *rentedAndReviewsLb;
@property (weak, nonatomic) IBOutlet UILabel *carConditionLb;
@property (weak, nonatomic) IBOutlet UILabel *carAgeLb;
@property (weak, nonatomic) IBOutlet UILabel *cardisplaceLb;
@property (weak, nonatomic) IBOutlet UILabel *carGasLb;
@property (weak, nonatomic) IBOutlet UILabel *gasLuateLb;
@property (weak, nonatomic) IBOutlet UILabel *seatTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *carCheckLb;
@property (weak, nonatomic) IBOutlet UILabel *dayRentTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *dayRentUnitLb;
@property (strong, nonatomic)NSMutableArray *dataArray1;
@property (strong, nonatomic)NSMutableArray *dataArray3;
@property (strong, nonatomic)NSMutableArray *commentArray;
@property (weak, nonatomic) IBOutlet UIView *commentLineV;
@end

@implementation YLCarInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _dayUnitLb.text = MyString(@"days");
    _rentedAndReviewsLb.text = MyString(@"rented_and_reviews");
    _carConditionLb.text = MyString(@"vehicle_condition_configuration");
    _carAgeLb.text = MyString(@"vehicle_age");
    _cardisplaceLb.text = MyString(@"engine_displacement");
    _carGasLb.text = MyString(@"power");
    _gasLuateLb.text = MyString(@"fuel_tank_capacity");
    _seatTitleLb.text =  MyString(@"seats");
    _carCheckLb.text = MyString(@"vehicle_condition_check");
    _dayRentTitleLb.text = MyString(@"daily_rental");
    _dayRentUnitLb.text = MyString(@"days");
    _evaluateLb.text = MyString(@"vehicle_evaluation");
    _evaluateMoreLb.text = MyString(@"more");
    _backBtn.userInteractionEnabled = YES;
    [_summitBtn setTitle:MyString(@"rental_vehicles") forState:UIControlStateNormal];
    
    UICollectionViewFlowLayout *flowLayout2 = [[UICollectionViewFlowLayout alloc] init];
    flowLayout2.itemSize = CGSizeMake(50, 17); // 每个 cell 的大小
    flowLayout2.minimumInteritemSpacing = 8; // 列间距
    flowLayout2.minimumLineSpacing = 0; // 行间距
    _labelCV.collectionViewLayout=flowLayout2;
    [_labelCV setShowsHorizontalScrollIndicator:NO];
    [_labelCV setShowsVerticalScrollIndicator:NO];
    _labelCV.scrollEnabled = NO;
    _labelCV.delegate = self;
    _labelCV.dataSource = self;
    _labelCV.tag = 111;
    [_labelCV registerNib:[UINib nibWithNibName:NSStringFromClass([YLCarFuncCell class])bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"YLCarFuncCell"];
    
    UICollectionViewFlowLayout *flowLayout3 = [[UICollectionViewFlowLayout alloc] init];
    flowLayout3.itemSize = CGSizeMake(15, 10); // 每个 cell 的大小
    flowLayout3.minimumInteritemSpacing = 5; // 列间距
    flowLayout3.minimumLineSpacing = 0; // 行间距
    _startsCV.collectionViewLayout=flowLayout3;
    [_startsCV setShowsHorizontalScrollIndicator:NO];
    [_startsCV setShowsVerticalScrollIndicator:NO];
    _startsCV.scrollEnabled = NO;
    _startsCV.delegate = self;
    _startsCV.dataSource = self;
    _startsCV.tag = 333;
    [_startsCV registerNib:[UINib nibWithNibName:NSStringFromClass([YLScoreCell class])bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"YLScoreCell"];
    
    [_evaluateTabV registerNib:[UINib nibWithNibName:@"YLEvaluaCell" bundle:nil] forCellReuseIdentifier:@"YLEvaluaCell"];
    _evaluateTabV.delegate = self;
    _evaluateTabV.dataSource = self;
    _evaluateTabV.scrollEnabled = NO;
    _evaluateTabV.separatorStyle = UITableViewCellSeparatorStyleNone;
    _evaluateTabV.showsVerticalScrollIndicator = NO;
    [_backBtn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBack)]];
    [_summitBtn addTarget:self action:@selector(goOrder) forControlEvents:UIControlEventTouchUpInside];
}

-(void)getData{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *i18nConfig = [defaults objectForKey:@"i18nConfig"];
    NSString *url = [NSString stringWithFormat:@"/api/car/getCarByID/%@/%@",self.carId,i18nConfig];
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:url parameters:nil complete:^(id ob) {
        self.carBean = [YLCarBean mj_objectWithKeyValues:ob];
        self.commentArray = [YLCommentBean mj_objectArrayWithKeyValuesArray:self.carBean.commentList];
//        [self.commentArray addObject:self.commentArray[0]];
//        [self.commentArray addObject:self.commentArray[0]];
//        [self.commentArray addObject:self.commentArray[0]];
//        [self.commentArray addObject:self.commentArray[0]];
//        [self.commentArray addObject:self.commentArray[0]];
        
//        if(self.commentArray.count>0){
//            
//            float contentHeight = 200+self.commentArray.count*135;
//            float tabHeight = self.commentArray.count*135;
//            [self.contentV mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.top.left.right.bottom.equalTo(self.scrollV);
//                make.height.mas_equalTo(contentHeight);
//            }];
//            
//        [self.evaluateTabV mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.contentV).offset(16);
////               make.bottom.equalTo(self.contentV.mas_bottom).offset(-16);
//            make.left.equalTo(self.contentV);
//            make.right.equalTo(self.contentV);
//            make.height.equalTo(@(tabHeight));
//        }];
//        [self.evaluateTabV mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.contentV).offset(200);
//            make.left.equalTo(self.contentV);
//            make.right.equalTo(self.contentV);
//            make.height.mas_equalTo(tabHeight);
//        }];
        [self refreshUI];
        [self.evaluateTabV reloadData];
    }];
}

- (void)initUI{
    self.backBtn.userInteractionEnabled = YES;
    [self.backBtn addGestureRecognizer:[[UIGestureRecognizer alloc] initWithTarget:self action:@selector(goBack)]];
}

-(void)refreshUI{
    [_coverIV sd_setImageWithURL:[NSURL URLWithString:_carBean.mobileUrl]];
    _priceDayLb.text = _carBean.price;
    _topPriceLb.text = _carBean.price;
    _nameLb.text = _carBean.carTitle;
    _seatLb.text = _carBean.seats;
    _rentInfoLb.text = [NSString stringWithFormat:MyString(@"rented_and_reviews"),_carBean.rentNum,_carBean.commentList.count];
    _startsLb.text = [NSString stringWithFormat:@"%d分", _carBean.pinfen];
    _ageLb.text = @"";
    _displacementLb.text = @"";
    _gasTypeLb.text = @"";
    _gasVolumeLb.text = @"";
    _totalPriceLb.text = _carBean.price;
    
    _dataArray3 = [NSMutableArray new];
    YLOptionBean *bean31 = [YLOptionBean new];
    bean31.isSelected = _carBean.pinfen>0;
    [_dataArray3 addObject:bean31];
    YLOptionBean *bean32 = [YLOptionBean new];
    bean32.isSelected = _carBean.pinfen>1;
    [_dataArray3 addObject:bean32];
    YLOptionBean *bean33 = [YLOptionBean new];
    bean33.isSelected = _carBean.pinfen>2;
    [_dataArray3 addObject:bean33];
    YLOptionBean *bean34 = [YLOptionBean new];
    bean34.isSelected = _carBean.pinfen>3;
    [_dataArray3 addObject:bean34];
    YLOptionBean *bean35 = [YLOptionBean new];
    bean35.isSelected = _carBean.pinfen>4;
    [_dataArray3 addObject:bean35];
    [self.startsCV reloadData];

    _dataArray1 = [NSMutableArray new];
    for (NSString *item in _carBean.lableList) {
        YLOptionBean *bean = [YLOptionBean new];
        bean.text = item;
        bean.isSelected = YES;
        [_dataArray1 addObject:bean];
    }
    [self.labelCV reloadData];
    
}


-(void)goOrder{
    YLSummitOrderVC *vc = [YLSummitOrderVC new];
    vc.carBean = _carBean;
    [self.navigationController pushViewController:vc animated:YES];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(collectionView.tag == 111){
        return _dataArray1.count;
    }else{
        return _dataArray3.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(collectionView.tag == 111){
        static NSString *identify = @"YLCarFuncCell";
        YLOptionBean *bean = self.dataArray1[indexPath.row];
        YLCarFuncCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
        cell.contentLb.text = bean.text;
        return cell;
    }else{
        static NSString *identify = @"YLScoreCell";
        YLOptionBean *bean = self.dataArray3[indexPath.row];
        YLScoreCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
        [cell initWithDate:bean];
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(0.01,0.01);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0.1, 0.1, 0.1, 4);
}

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 135;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"YLEvaluaCell";
    YLCommentBean *bean = _commentArray[indexPath.row];
    YLEvaluaCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer forIndexPath:indexPath];
    [cell initWithDate:bean];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(likeTapped:)];
    [cell.likeIv setUserInteractionEnabled:YES];
    [cell.likeIv addGestureRecognizer:tapGesture];
    cell.likeIv.tag = indexPath.row+111;
    return cell;
}

- (void)likeTapped:(UITapGestureRecognizer *)sender {
    YLCommentBean *bean = _commentArray[sender.view.tag-111];
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"commentID"] = bean.cId;
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodPost URLString:@"/api/order/upvote" parameters:dic complete:^(id ob) {
        bean.upvote = bean.upvote + 1;
        [self.evaluateTabV reloadData];
    } fail:^(id ob) {
    }];
}
@end
