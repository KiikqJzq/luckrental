//
//  YLPayOrder.m
//  luckrental
//
//  Created by kiikqjzq on 2023/9/26.
//

#import "YLPayOrder.h"
#import "YLPayRateV.h"
#import "UIView+Nib.h"
#import "YLOrderBean.h"



@interface YLPayOrder ()
@property (weak, nonatomic) IBOutlet UIButton *summitBtn;
@property (weak, nonatomic) IBOutlet UIImageView *backIV;
@property (weak, nonatomic) IBOutlet UIImageView *zskIV;
@property (weak, nonatomic) IBOutlet UIImageView *cashIV;
@property (weak, nonatomic) IBOutlet UILabel *orderPriceLb;
@property (weak, nonatomic) IBOutlet UIImageView *carIV;
@property (weak, nonatomic) IBOutlet UILabel *carNameLb;
@property (weak, nonatomic) IBOutlet UILabel *carInfoLb;
@property (weak, nonatomic) IBOutlet UILabel *carPriceLb;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLb;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLb;
@property (weak, nonatomic) IBOutlet UILabel *rentDaysLb;
@property (weak, nonatomic) IBOutlet UITextField *startPlace;
@property (weak, nonatomic) IBOutlet UITextField *endPlace;
@property (weak, nonatomic) IBOutlet UILabel *bookNameLb;
@property (weak, nonatomic) IBOutlet UILabel *bookMobileLb;
@property (weak, nonatomic) IBOutlet UILabel *orderIdLb;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *cardayUnitLb;
@property (weak, nonatomic) IBOutlet UILabel *startTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *endTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *startPlaceTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *endPlaceTItleLb;
@property (weak, nonatomic) IBOutlet UILabel *basicInfoLb;
@property (weak, nonatomic) IBOutlet UILabel *nameTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *mobileTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *cardTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *payTypeLb;
@property (weak, nonatomic) IBOutlet UILabel *zskLb;
@property (weak, nonatomic) IBOutlet UILabel *cashLb;

@property (strong, nonatomic)NSString *payType;
@property (strong, nonatomic)YLOrderBean *orderBean;



@end

@implementation YLPayOrder

- (void)viewDidLoad {
    [super viewDidLoad];
    _payType = @"1";
    self.titleLb.text = MyString(@"order_payment");
    self.cardayUnitLb.text = MyString(@"days");
    self.startTitleLb.text = MyString(@"pickup_time");
    self.endTitleLb.text = MyString(@"return_time");
    
    self.startTimeLb.text = MyString(@"select_time");
    self.endTimeLb.text = MyString(@"select_time");
    self.startPlaceTitleLb.text = MyString(@"rental_location");
    self.endPlaceTItleLb.text = MyString(@"return_location");
    self.basicInfoLb.text = MyString(@"basic_information");
    self.nameTitleLb.text = MyString(@"booking_person_name");
    self.mobileTitleLb.text = MyString(@"phone_number");
    self.cardTitleLb.text = MyString(@"id_number");
    self.payTypeLb.text =  MyString(@"payment_method");
    self.zskLb.text =  MyString(@"fast_transfer");
    self.cashLb.text = MyString(@"cash_payment");
    
    [_summitBtn setTitle: MyString(@"confirm_payment") forState:UIControlStateNormal];
    
    [_summitBtn addTarget:self action:@selector(showPayDialog) forControlEvents:UIControlEventTouchUpInside];
    
    _backIV.userInteractionEnabled = YES;
    [_backIV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBack)]];
    
    _zskIV.userInteractionEnabled = YES;
    [_zskIV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setZsk)]];
    
    _cashIV.userInteractionEnabled = YES;
    [_cashIV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setCash)]];
}

- (void)getData{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"id"] = self.orderId;
    
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/order/getOrderInfoByID" parameters:dic complete:^(id ob) {
        self.orderBean = [YLOrderBean mj_objectWithKeyValues:ob];
        [self refreshUI];
    }];

    
}

- (void)viewDidDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)showPayDialog {
    YLPayRateV *v = [YLPayRateV viewFormNib_];
    v.orderId = self.orderId;
    v.amount = self.orderBean.actualPrice;
    v.payType = self.payType;
    v.dialogType = 2;
    v.superVc = self;
    [v show:^{
        NSLog(@"123");
    }];
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

-(void)refreshUI{
    
    [_carIV sd_setImageWithURL:[NSURL URLWithString:_orderBean.carInfo.mobileUrl]];
    _carNameLb.text = _orderBean.carInfo.carTitle;
    _carInfoLb.text = [_orderBean.carInfo.lableList componentsJoinedByString:@" "];
    _carPriceLb.text = _orderBean.price;
    _startTimeLb.text = [self convertOriginalDateString:_orderBean.pickCarDate fromFormat:@"yyyy-MM-dd HH:mm:ss" toFormat:@"yyyy-MM-dd HH"];
    _endTimeLb.text = [self convertOriginalDateString:_orderBean.returnCarDate fromFormat:@"yyyy-MM-dd HH:mm:ss" toFormat:@"yyyy-MM-dd HH"];
    _startPlace.text = _orderBean.pickCarAddress;
    _endPlace.text = _orderBean.returnCarAddress;
    _bookNameLb.text = _orderBean.reserveName;
    _bookMobileLb.text = _orderBean.reservePhone;
    _orderIdLb.text = _orderBean.reserveCard;
    _orderPriceLb.text = _orderBean.actualPrice;
    
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
          dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
  NSDate *date1 = [dateFormatter dateFromString:_orderBean.pickCarDate];
  NSDate *date2 = [dateFormatter dateFromString:_orderBean.returnCarDate];
    _rentDaysLb.text = [NSString stringWithFormat:@"%ld%@",(long)[self daysBetweenStartDate:date1 andEndDate:date2],MyString(@"day")];
//    _seatNumLb.text = _orderBean.seatServiceNum;
//    _insuranceNumLb.text = _orderBean.insuranceServiceNum;
//    if(_orderBean.receiveService && [_orderBean.receiveService isEqualToString:@"1"]){
//        [_airportIV setImage:[UIImage imageNamed:@"ic_hook_sel"]];
//    }else{
//        [_airportIV setImage:[UIImage imageNamed:@"ic_hook_nor"]];
//    }
//    if(_orderBean.etcService && [_orderBean.etcService isEqualToString:@"1"]){
//        [_etcIV setImage:[UIImage imageNamed:@"ic_hook_sel"]];
//    }else{
//        [_etcIV setImage:[UIImage imageNamed:@"ic_hook_nor"]];
//    }
}


- (NSInteger)daysBetweenStartDate:(NSDate *)startDate andEndDate:(NSDate *)endDate {
    // 获取默认的日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];

    // 设置计算时间差的单位为天
    NSCalendarUnit unit = NSCalendarUnitDay;
    
    // 获取日期组件
    NSDateComponents *components = [calendar components:unit
                                               fromDate:startDate
                                                 toDate:endDate
                                                options:0];

    // 计算天数差，不满一天算一天
    NSInteger daysDifference = components.day + (components.hour > 0  ? 1 : 0);


    return daysDifference;
}

- (NSString *)convertOriginalDateString:(NSString *)originalDateString fromFormat:(NSString *)fromFormat toFormat:(NSString *)toFormat {
    // 创建原始字符串的日期格式化器
    NSDateFormatter *originalDateFormatter = [[NSDateFormatter alloc] init];
    originalDateFormatter.dateFormat = fromFormat;

    // 将原始字符串转换为NSDate对象
    NSDate *originalDate = [originalDateFormatter dateFromString:originalDateString];

    if (originalDate) {
        // 创建新字符串的日期格式化器
        NSDateFormatter *newDateFormatter = [[NSDateFormatter alloc] init];
        newDateFormatter.dateFormat = toFormat;

        // 将NSDate对象转换为新的字符串
        NSString *newDateString = [newDateFormatter stringFromDate:originalDate];

        return newDateString;
    } else {
        NSLog(@"日期格式不正确");
        return nil;
    }
}

@end
