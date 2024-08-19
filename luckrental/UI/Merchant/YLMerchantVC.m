//
//  YLMerchantVC.m
//  luckrental
//
//  Created by kiikqjzq on 2023/10/6.
//

#import "YLMerchantVC.h"
#import "YLMerchantBean.h"
#import "YLCommentBean.h"
#import "YLEvaluaCell.h"
@interface YLMerchantVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)YLMerchantBean *merchantBean;
@property (weak, nonatomic) IBOutlet UIImageView *backBtn;
@property (weak, nonatomic) IBOutlet UIImageView *coverIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UICollectionView *starCV;
@property (weak, nonatomic) IBOutlet UICollectionView *infoCV;
@property (weak, nonatomic) IBOutlet UILabel *describeLb;
@property (weak, nonatomic) IBOutlet UILabel *infoLb;
@property (weak, nonatomic) IBOutlet UILabel *detailsTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *evaluateTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *moreLb;
@property (weak, nonatomic) IBOutlet UILabel *scoreLb;
@property (weak, nonatomic) IBOutlet UILabel *priceLb;
@property (weak, nonatomic) IBOutlet UILabel *tagLb;
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
@property (weak, nonatomic) IBOutlet UITableView *commentTabV;
@property (strong, nonatomic)NSMutableArray *commentArray;

@end

@implementation YLMerchantVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _detailsTitleLb.text = MyString(@"merchant_details");
    _evaluateTitleLb.text = MyString(@"historical_reviews");
    _moreLb.text = MyString(@"more");
    _backBtn.userInteractionEnabled = YES;
    [_backBtn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBack)]];
    
    [_commentTabV registerNib:[UINib nibWithNibName:@"YLEvaluaCell" bundle:nil] forCellReuseIdentifier:@"YLEvaluaCell"];
    _commentTabV.delegate = self;
    _commentTabV.dataSource = self;
    _commentTabV.separatorStyle = UITableViewCellSeparatorStyleNone;
    _commentTabV.showsVerticalScrollIndicator = NO;
    
}

-(void)getData{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *i18nConfig = [defaults objectForKey:@"i18nConfig"];
    NSString *url = [NSString stringWithFormat:@"/api/merchant/getMerchantByID/%@/%@",self.merchantId,i18nConfig];
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:url parameters:nil complete:^(id ob) {
        self.merchantBean = [YLMerchantBean mj_objectWithKeyValues:ob];
        self.commentArray = [YLCommentBean mj_objectArrayWithKeyValuesArray:self.merchantBean.jcCommentList];
        [self refreshUI];
        [self.commentTabV reloadData];
    }];
}

- (void)initUI{
    self.backBtn.userInteractionEnabled = YES;
    [self.backBtn addGestureRecognizer:[[UIGestureRecognizer alloc] initWithTarget:self action:@selector(goBack)]];
    
}
-(void)refreshUI{
    [_coverIV sd_setImageWithURL:[NSURL URLWithString:_merchantBean.mobileUrl]];
    _nameLb.text = _merchantBean.title;
    self.infoLb.text = _merchantBean.address;
    self.scoreLb.text = [NSString stringWithFormat:@"%@:%@",MyString(@"user_rating"),_merchantBean.pinfen];
    self.priceLb.text = [NSString stringWithFormat:@"%@:%@",MyString(@"average_price"),_merchantBean.junjia];;
    self.tagLb.text = _merchantBean.subheading;
    self.timeLb.text = _merchantBean.openingHours;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
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
