//
//  YLAboutUSVC.m
//  luckrental
//
//  Created by kiikqjzq on 2023/9/15.
//

#import "YLAboutUSVC.h"
#import "YLPartnersCell.h"
#import "YLPartnersBean.h"
#import "YLCommentBean.h"
#import "YLEvaluaCell.h"

@interface YLAboutUSVC ()<UICollectionViewDelegate, UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *logoIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *versionLb;
@property (weak, nonatomic) IBOutlet UILabel *describeLb;
@property (weak, nonatomic) IBOutlet UILabel *companyProfileLb;
@property (weak, nonatomic) IBOutlet UILabel *multilateralCooperationLb;
@property (weak, nonatomic) IBOutlet UILabel *customerReviewsLb;
@property (weak, nonatomic) IBOutlet UICollectionView *cv;
@property (strong, nonatomic)NSMutableArray *dataArray;

@property (weak, nonatomic) IBOutlet UITableView *commentTabV;
@property (strong, nonatomic)NSMutableArray *commentArray;

@end

@implementation YLAboutUSVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = MyString(@"about_us");
    _companyProfileLb.text = MyString(@"company_profile");
    _multilateralCooperationLb.text = MyString(@"social_platform");
    _customerReviewsLb.text = MyString(@"customer_reviews");
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(50, 50); // 每个 cell 的大小
    flowLayout.minimumInteritemSpacing = 20; // 列间距
    flowLayout.minimumLineSpacing = 12; // 行间距
    _cv.collectionViewLayout=flowLayout;
    [_cv setShowsHorizontalScrollIndicator:NO];
    [_cv setShowsVerticalScrollIndicator:NO];
    _cv.scrollEnabled = NO;
    _cv.delegate = self;
    _cv.dataSource = self;
    [_cv registerNib:[UINib nibWithNibName:NSStringFromClass([YLPartnersCell class])bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"YLPartnersCell"];
    
    [_commentTabV registerNib:[UINib nibWithNibName:@"YLEvaluaCell" bundle:nil] forCellReuseIdentifier:@"YLEvaluaCell"];
    _commentTabV.delegate = self;
    _commentTabV.dataSource = self;
    [_commentTabV setScrollEnabled:NO];
    _commentTabV.separatorStyle = UITableViewCellSeparatorStyleNone;
    _commentTabV.showsVerticalScrollIndicator = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)getPromotionCodeByCode{

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"YLPartnersCell";
    YLPartnersBean *bean = self.dataArray[indexPath.row];
    YLPartnersCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.lb.text = bean.title;
    [cell.iv sd_setImageWithURL:[NSURL URLWithString:bean.url]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    YLPartnersBean *bean = self.dataArray[indexPath.row];
    NSURL *url = [NSURL URLWithString:bean.access];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        } else {
            NSLog(@"无法打开指定的 URL");
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

- (void)getData{
    [super getData];
    PXWeakSelf
    
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/aboutUS/get" parameters:nil complete:^(id ob) {
        [self.logoIV sd_setImageWithURL:[NSURL URLWithString:ob[@"logoUrl"]]];
        self.nameLb.text = ob[@"title"];
        self.versionLb.text = ob[@"version"];
        self.describeLb.text = ob[@"description"];
    }];
    [self getPromotionCodeByCode];
    
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/aboutUS/getPartner" parameters:nil complete:^(id ob) {
        weakSelf.dataArray = [YLPartnersBean mj_objectArrayWithKeyValuesArray:ob];
        [weakSelf.cv reloadData];
    } fail:^(id ob) {
    }];
    
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/aboutUS/getComment" parameters:nil complete:^(id ob) {
        self.commentArray = [YLCommentBean mj_objectArrayWithKeyValuesArray:ob];
        [self.commentTabV reloadData];
    } fail:^(id ob) {
    }];
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
        [self.commentTabV reloadData];
    } fail:^(id ob) {
    }];
}
@end
