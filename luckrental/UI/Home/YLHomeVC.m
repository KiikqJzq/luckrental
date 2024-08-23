//
//  YLHomeVC.m
//  luckrental
//
//  Created by kiikqjzq on 2023/9/14.
//

#import "YLHomeVC.h"
#import "YLCarBean.h"
#import "YLMerchantBean.h"
#import "YLHomeVC.h"
#import "YLCarListCell.h"
#import "YLMerchantCell.h"
#import "YLCarListVC.h"
#import "YLCarInfoVC.h"
#import "SDCycleScrollView.h"
#import "YLBannerBean.h"
#import "YLCarListVC.h"
#import "YLMerchantListVC.h"
#import "YLMerchantVC.h"
#import "RCDLanguageManager.h"
#import "AppDelegate.h"
#import "RCDMainTabBarViewController.h"
#import "RCDNavigationViewController.h"
#import "NSBundle+language.h"
#import <CoreTelephony/CTCellularData.h>

@interface YLHomeVC ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollV;
@property (weak, nonatomic) IBOutlet UIView *contentV;
@property (weak, nonatomic) IBOutlet UITableView *carTabV;
@property (weak, nonatomic) IBOutlet UITableView *merchantTabv;
@property (weak, nonatomic) IBOutlet UILabel *moreCarLb;
@property (weak, nonatomic) IBOutlet UILabel *moreMerchantLb;
@property (weak, nonatomic) IBOutlet UILabel *homeLb;
@property (weak, nonatomic) IBOutlet UILabel *searchHintLb;
@property (weak, nonatomic) IBOutlet UILabel *searchLb;
@property (weak, nonatomic) IBOutlet UILabel *hotCarLb;
@property (weak, nonatomic) IBOutlet UILabel *carMoreLb;
@property (weak, nonatomic) IBOutlet UILabel *hotMerchantLb;
@property (weak, nonatomic) IBOutlet UILabel *merchantMoreLb;

@property(nonatomic,strong)NSMutableArray *carArray;
@property(nonatomic,strong)NSMutableArray *merchantArray;
@property (weak, nonatomic) IBOutlet UIView *bannerV;
@property (nonatomic, strong) SDCycleScrollView *banner;
@property (nonatomic, strong) NSMutableArray *bArray;
@property (weak, nonatomic) IBOutlet UILabel *languageLb;

@property (strong, nonatomic) UIPickerView *countryPicker;
@property (strong, nonatomic) NSArray *languageArray;
@property (strong, nonatomic) UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIView *searchV;

@end

@implementation YLHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _languageArray = @[@"English",@"繁體",@"한국어",@"日本語"];
}


- (void)initUI{
    
    _banner = [SDCycleScrollView new];
    _banner.delegate = self;
    
    [self.view addSubview:_banner];
    [_banner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bannerV).offset(0);
        make.size.equalTo(self.bannerV).offset(0);
    }];
    
    [_carTabV registerNib:[UINib nibWithNibName:@"YLCarListCell" bundle:nil] forCellReuseIdentifier:@"YLCarListCell"];
    _carTabV.delegate = self;
    _carTabV.dataSource = self;
    _carTabV.separatorStyle = UITableViewCellSeparatorStyleNone;
    _carTabV.showsVerticalScrollIndicator = NO;
    _carTabV.scrollEnabled = NO;
    _carTabV.tag = 111;
    
    [_merchantTabv registerNib:[UINib nibWithNibName:@"YLMerchantCell" bundle:nil] forCellReuseIdentifier:@"YLMerchantCell"];
    _merchantTabv.delegate = self;
    _merchantTabv.dataSource = self;
    _merchantTabv.separatorStyle = UITableViewCellSeparatorStyleNone;
    _merchantTabv.showsVerticalScrollIndicator = NO;
    _merchantTabv.scrollEnabled = NO;
    _merchantTabv.tag = 222;
    
    self.moreCarLb.userInteractionEnabled = YES;
    [self.moreCarLb addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goCarList)]];
    
    self.moreMerchantLb.userInteractionEnabled = YES;
    [self.moreMerchantLb addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goMerchantList)]];
    
    self.searchV.userInteractionEnabled = YES;
    [self.searchV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goCarList)]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *i18nConfig = [defaults objectForKey:@"i18nConfig"];
    if (i18nConfig && i18nConfig.length > 0) {
        NSString *languageStr = @"繁體";
        if([i18nConfig isEqualToString:@"English"]){
            languageStr = @"English";
        }else if([i18nConfig isEqualToString:@"Chinese"]){
            languageStr = @"繁體";
        }else if([i18nConfig isEqualToString:@"Korean"]){
            languageStr = @"한국어";
        }else if([i18nConfig isEqualToString:@"Japan"]){
            languageStr = @"日本語";
        }
        self.languageLb.text = languageStr;
    }
    
    self.languageLb.userInteractionEnabled = YES;
    [self.languageLb addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicker)]];
    
    
    _homeLb.text = MyString(@"home");
    _searchHintLb.text = MyString(@"enter_keywords");
    _searchLb.text = MyString(@"search");
    _hotCarLb.text = MyString(@"popular_vehicles");
    _carMoreLb.text = MyString(@"more");
    _hotMerchantLb.text = MyString(@"popular_merchants");
    
//    NSString *appName = @"Test";
//    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
//    NSString *buildVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
//    NSString *resultString = [NSString stringWithFormat:@"%@ %@ Build %@", appName, version, buildVersion];
//    
//    UILabel *testLb = [UILabel new];
//    testLb.textColor = UIColor.blueColor;
//    testLb.text = resultString;
//    testLb.font = [UIFont systemFontOfSize:20];
//    [self.view addSubview:testLb];
//    [testLb mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view);
//        make.top.equalTo(self.view).offset(50);
//    }];
    
}

- (void)getData{
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/car/getHotCarList" parameters:nil complete:^(id ob) {
        self.carArray = [YLCarBean mj_objectArrayWithKeyValuesArray:ob];
//test
//        [self.carArray addObject:self.carArray[0]];
//        [self.carArray addObject:self.carArray[0]];
//        [self.carArray addObject:self.carArray[0]];
        if(self.carArray.count >=3 && self.merchantArray.count >=3){
            [self.contentV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.bottom.equalTo(self.scrollV);
                make.height.mas_equalTo(930);
            }];
        }else{
            [self.contentV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.bottom.equalTo(self.scrollV);
                make.height.mas_equalTo(180+self.carArray.count*125+self.merchantArray.count*125);
            }];
        }
        if(self.carArray.count <3){
            [self.carTabV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.hotCarLb.mas_bottom).offset(16);
                make.left.equalTo(self.contentV).offset(13);
                make.right.equalTo(self.contentV).offset(-13);
                make.height.mas_equalTo(self.carArray.count*125);
            }];
        }else{
            [self.carTabV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.hotCarLb.mas_bottom).offset(16);
                make.left.equalTo(self.contentV).offset(13);
                make.right.equalTo(self.contentV).offset(-13);
                make.height.mas_equalTo(375);
            }];
        }
        [self.carTabV reloadData];
    }];

    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/merchant/getHotMerchantList" parameters:nil complete:^(id ob) {
        self.merchantArray = [YLMerchantBean mj_objectArrayWithKeyValuesArray:ob];
        //test
//        [self.merchantArray addObject:self.merchantArray[0]];
//        [self.merchantArray addObject:self.merchantArray[0]];
//        [self.merchantArray addObject:self.merchantArray[0]];
        
        if(self.carArray.count >=3 && self.merchantArray.count >=3){
            [self.contentV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.bottom.equalTo(self.scrollV);
                make.height.mas_equalTo(930);
            }];
        }else{
            [self.contentV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.bottom.equalTo(self.scrollV);
                make.height.mas_equalTo(180+self.carArray.count*125+self.merchantArray.count*125);
            }];
        }
        
        if(self.merchantArray.count <3){
            [self.merchantTabv mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.hotMerchantLb.mas_bottom).offset(16);
                make.left.equalTo(self.contentV).offset(13);
                make.right.equalTo(self.contentV).offset(-13);
                make.height.mas_equalTo(self.merchantArray.count*125);
            }];
        }else{
            [self.merchantTabv mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.hotMerchantLb.mas_bottom).offset(16);
                make.left.equalTo(self.contentV).offset(13);
                make.right.equalTo(self.contentV).offset(-13);
                make.height.mas_equalTo(375);
            }];
        }

        [self.merchantTabv reloadData];
    }];
    
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/slideshow/getRecommend" parameters:nil complete:^(id ob) {
        self.bArray = [YLBannerBean mj_objectArrayWithKeyValuesArray:ob];
        NSMutableArray *imgArray = [NSMutableArray new];
        for (YLBannerBean *bean in self.bArray) {
            if(bean.mobileUrl){
                [imgArray addObject:bean.mobileUrl];
            }
        }
        [self.banner setImageURLStringsGroup:imgArray];
    }];
}


#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView.tag == 111){
        return self.carArray.count;
    }else{
        return self.merchantArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView.tag == 111){
        return 125;
    }else{
        return 125;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView.tag == 111){
        static NSString *identifer = @"YLCarListCell";
        YLCarBean *bean = _carArray[indexPath.row];
        YLCarListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer forIndexPath:indexPath];
        [cell initWithDate:bean];
    //    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }else{
        static NSString *identifer = @"YLMerchantCell";
        YLMerchantBean *bean = _merchantArray[indexPath.row];
        YLMerchantCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer forIndexPath:indexPath];
        [cell initWithDate:bean];
    //    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(tableView.tag == 111){
        YLCarBean *bean = _carArray[indexPath.row];
        YLCarInfoVC *vc = [YLCarInfoVC new];
        vc.carId = bean.carId;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        YLMerchantBean *bean = _merchantArray[indexPath.row];
        YLMerchantVC *vc = [YLMerchantVC new];
        vc.merchantId = bean.merchantId;
        [self.navigationController pushViewController:vc animated:YES];
    
    }
    
}


-(void)goCarList{
    YLCarListVC *vc = [YLCarListVC new];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)goMerchantList{
    YLMerchantListVC *vc = [YLMerchantListVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)showPicker{
    // 创建PickerView
    self.countryPicker = [UIPickerView new];
    self.countryPicker.backgroundColor = UIColor.whiteColor;
    self.countryPicker.delegate = self;
    self.countryPicker.dataSource = self;
    
    // 创建Toolbar
    _toolbar = [UIToolbar new];
    _toolbar.backgroundColor = UIColor.whiteColor;
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:MyString(@"cancel") style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonTapped)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:MyString(@"confirm") style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonTapped)];
    _toolbar.items = @[cancelButton, flexibleSpace, doneButton];
    
    // 将PickerView和Toolbar添加到视图中
    [self.view addSubview:self.countryPicker];
    [self.view addSubview:_toolbar];
    [self.countryPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(@300);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    [_toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(@44);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.countryPicker.mas_top);
    }];
    
}

#pragma mark - UIPickerViewDelegate and UIPickerViewDataSource methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1; // 选择1列
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.languageArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.languageArray[row];
}

#pragma mark - Button actions

- (void)cancelButtonTapped {
    // 处理取消按钮点击事件
    [self.countryPicker removeFromSuperview];
    [self.toolbar removeFromSuperview];
}

- (void)doneButtonTapped {
    // 处理完成按钮点击事件
    NSInteger selectedRow = [self.countryPicker selectedRowInComponent:0];
    NSString *selectedStr = self.languageArray[selectedRow];
    _languageLb.text = selectedStr;
    [self.countryPicker removeFromSuperview];
    [self.toolbar removeFromSuperview];
    
    if([selectedStr isEqualToString:@"English"]){
        [self changeLanguage:@"en"];
    }else if([selectedStr isEqualToString:@"繁體"]){
        [self changeLanguage:@"zh-Hant"];
    }else if([selectedStr isEqualToString:@"한국어"]){
        [self changeLanguage:@"ko"];
    }else if([selectedStr isEqualToString:@"日本語"]){
        [self changeLanguage:@"ja"];
    }

}

- (void)changeLanguage:(NSString *)newLanguage {
    [NSBundle setLanguage:newLanguage];
//    [[NSUserDefaults standardUserDefaults] setObject:newLanguage forKey:@"appLanguage"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    // 设置新语言
//    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:newLanguage, nil] forKey:@"AppleLanguages"];
//    [[NSUserDefaults standardUserDefaults] synchronize];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([newLanguage isEqualToString:@"en"]){
        [defaults setObject:@"English" forKey:@"i18nConfig"];
    }else if([newLanguage isEqualToString:@"zh-Hant"]){
        [defaults setObject:@"Chinese" forKey:@"i18nConfig"];
    }else if([newLanguage isEqualToString:@"ko"]){
        [defaults setObject:@"Korean" forKey:@"i18nConfig"];
    }else if([newLanguage isEqualToString:@"ja"]){
        [defaults setObject:@"Japan" forKey:@"i18nConfig"];
    }
    [defaults synchronize];
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    RCDMainTabBarViewController *mainTabBarVC = [[RCDMainTabBarViewController alloc] init];
    RCDNavigationViewController *nav = [[RCDNavigationViewController alloc] initWithRootViewController:mainTabBarVC];
    app.window.rootViewController = nav;
    
}

@end
