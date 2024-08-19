//
//  YLTravelInfoVC.m
//  luckrental
//
//  Created by kiikqjzq on 2024/8/12.
//

#import "YLTravelInfoVC.h"
#import <WebKit/WebKit.h>
#import "SDCycleScrollView.h"
#import "YLOptionBean.h"
#import "YLCarFuncCell.h"
#import "YLScoreCell.h"
#import "YLCommentBean.h"
#import "YLEvaluaCell2.h"
#import "YLCommentV.h"
#import "UIView+Nib.h"

@interface YLTravelInfoVC ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource,WKNavigationDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollV;
@property (weak, nonatomic) IBOutlet UIView *contentV;
@property (weak, nonatomic) IBOutlet UIView *bannerV;
@property (weak, nonatomic) IBOutlet UILabel *introLb;
@property (weak, nonatomic) IBOutlet UICollectionView *cv1;
@property (weak, nonatomic) IBOutlet UILabel *scoreLb;
@property (weak, nonatomic) IBOutlet UICollectionView *cv2;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLb;
@property (weak, nonatomic) IBOutlet UILabel *priceTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *priceLb;
@property (weak, nonatomic) IBOutlet UILabel *originalPriceTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *originalPriceLb;
@property (weak, nonatomic) IBOutlet WKWebView *webV;
@property (weak, nonatomic) IBOutlet UITableView *evaluateTabV;
@property (weak, nonatomic) IBOutlet UIButton *goCommentBtn;
@property(nonatomic,strong)YLTravelInfoBean *bean;
@property (nonatomic, strong) SDCycleScrollView *banner;
@property (nonatomic, strong) NSMutableArray *bArray;
@property (strong, nonatomic)NSMutableArray *dataArray1;
@property (strong, nonatomic)NSMutableArray *dataArray2;
@property (strong, nonatomic)NSMutableArray *commentArray;

@end

@implementation YLTravelInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)initUI{
    
    _banner = [SDCycleScrollView new];
    _banner.delegate = self;
    [self.view addSubview:_banner];
    [_banner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bannerV).offset(0);
        make.size.equalTo(self.bannerV).offset(0);
    }];
    
    UICollectionViewFlowLayout *flowLayout2 = [[UICollectionViewFlowLayout alloc] init];
    flowLayout2.itemSize = CGSizeMake(50, 20); // 每个 cell 的大小
    flowLayout2.minimumInteritemSpacing = 4; // 列间距
    flowLayout2.minimumLineSpacing = 0; // 行间距
    _cv1.collectionViewLayout=flowLayout2;
    [_cv1 setShowsHorizontalScrollIndicator:NO];
    [_cv1 setShowsVerticalScrollIndicator:NO];
    _cv1.scrollEnabled = NO;
    _cv1.delegate = self;
    _cv1.dataSource = self;
    _cv1.tag = 111;
    [_cv1 registerNib:[UINib nibWithNibName:NSStringFromClass([YLCarFuncCell class])bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"YLCarFuncCell"];
    
    UICollectionViewFlowLayout *flowLayout3 = [[UICollectionViewFlowLayout alloc] init];
    flowLayout3.itemSize = CGSizeMake(20, 20); // 每个 cell 的大小
    flowLayout3.minimumInteritemSpacing = 4; // 列间距
    flowLayout3.minimumLineSpacing = 0; // 行间距
    _cv2.collectionViewLayout=flowLayout3;
    [_cv2 setShowsHorizontalScrollIndicator:NO];
    [_cv2 setShowsVerticalScrollIndicator:NO];
    _cv2.scrollEnabled = NO;
    _cv2.delegate = self;
    _cv2.dataSource = self;
    _cv2.tag = 333;
    [_cv2 registerNib:[UINib nibWithNibName:NSStringFromClass([YLScoreCell class])bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"YLScoreCell"];
    
    [_evaluateTabV registerNib:[UINib nibWithNibName:@"YLEvaluaCell2" bundle:nil] forCellReuseIdentifier:@"YLEvaluaCell2"];
    _evaluateTabV.delegate = self;
    _evaluateTabV.dataSource = self;
    _evaluateTabV.separatorStyle = UITableViewCellSeparatorStyleNone;
    _evaluateTabV.showsVerticalScrollIndicator = NO;
    
    [self.goCommentBtn setTitle:MyString(@"reviews") forState:UIControlStateNormal];
    [self.goCommentBtn  addTarget:self action:@selector(showCommentV) forControlEvents:UIControlEventTouchUpInside];

    self.webV.navigationDelegate = self;
    
    self.scrollV.showsVerticalScrollIndicator = NO;
    self.evaluateTabV.showsVerticalScrollIndicator = NO;
}


- (void)getData{
    PXWeakSelf
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"id"] = self.tid;
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/travel/getTravelByID" parameters:dic complete:^(id ob) {
        weakSelf.bean = [YLTravelInfoBean mj_objectWithKeyValues:ob];
        [weakSelf updateUI];
    }];
}


- (void)updateUI{
    self.title = self.bean.title;
    self.introLb.text = self.bean.place;
    NSMutableArray *imgArray = [NSMutableArray new];
    [imgArray addObject:self.bean.mobileImg];
    [self.banner setImageURLStringsGroup:imgArray];
    self.scoreLb.text = [NSString stringWithFormat:MyString(@"score_format"),_bean.recommend];
    self.priceLb.text = self.bean.price;
    self.originalPriceLb.text = self.bean.originalPrice;
    self.commentCountLb.text = [NSString stringWithFormat:MyString(@"reviews_count"),_bean.commentList.count];
    
    
    _dataArray2 = [NSMutableArray new];
    YLOptionBean *bean31 = [YLOptionBean new];
    bean31.isSelected = _bean.recommend>0;
    [_dataArray2 addObject:bean31];
    YLOptionBean *bean32 = [YLOptionBean new];
    bean32.isSelected = _bean.recommend>1;
    [_dataArray2 addObject:bean32];
    YLOptionBean *bean33 = [YLOptionBean new];
    bean33.isSelected = _bean.recommend>2;
    [_dataArray2 addObject:bean33];
    YLOptionBean *bean34 = [YLOptionBean new];
    bean34.isSelected = _bean.recommend>3;
    [_dataArray2 addObject:bean34];
    YLOptionBean *bean35 = [YLOptionBean new];
    bean35.isSelected = _bean.recommend>4;
    [_dataArray2 addObject:bean35];
    [self.cv2 reloadData];
    
    _dataArray1 = [NSMutableArray new];
    NSArray *labelArray = [_bean.label componentsSeparatedByString:@","];
    for (NSString *item in labelArray) {
        YLOptionBean *bean = [YLOptionBean new];
        bean.text = item;
        bean.isSelected = YES;
        [_dataArray1 addObject:bean];
    }
    [self.cv1 reloadData];
    
    
    [self.webV loadHTMLString:self.bean.content baseURL:nil];
    
    self.commentArray = [YLCommentBean mj_objectArrayWithKeyValuesArray:self.bean.commentList];
    [_evaluateTabV reloadData];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(collectionView.tag == 111){
        return _dataArray1.count;
    }else{
        return _dataArray2.count;
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
        YLOptionBean *bean = self.dataArray2[indexPath.row];
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"YLEvaluaCell2";
    YLCommentBean *bean = _commentArray[indexPath.row];
    YLEvaluaCell2 *cell = [tableView dequeueReusableCellWithIdentifier:identifer forIndexPath:indexPath];
    [cell initWithDate:bean];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)showCommentV{
    PXWeakSelf
    YLCommentV *v = [YLCommentV viewFormNib_];
    v.superVc = self;
    v.travelId = self.bean.tId;
    [v show:^{

    }];
    v.didClose = ^{
        [weakSelf getData];
    };
}

//- (void)viewWillDisappear:(BOOL)animated{
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
//
//}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

// 在页面加载完成后执行 JavaScript 调整字体大小
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSString *jsString = @"document.getElementsByTagName('body')[0].style.fontSize='50px'";
    [webView evaluateJavaScript:jsString completionHandler:nil];
}
@end
