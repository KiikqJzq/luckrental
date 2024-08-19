//
//  YLOrderInfoVC.m
//  luckrental
//
//  Created by kiikqjzq on 2023/10/5.
//

#import "YLOrderInfoVC.h"
#import "YLOrderBean.h"
#import "UIView+Additions.h"
#import "YLPayOrder.h"

@interface YLOrderInfoVC ()
@property (weak, nonatomic) IBOutlet UIImageView *backIV;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic)YLOrderBean *orderBean;
@property (weak, nonatomic) IBOutlet UIImageView *carIV;
@property (weak, nonatomic) IBOutlet UILabel *carNameLb;
@property (weak, nonatomic) IBOutlet UILabel *carInfoLb;
@property (weak, nonatomic) IBOutlet UILabel *carPriceLb;

@property (weak, nonatomic) IBOutlet UILabel *startTimeLb;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLb;
@property (weak, nonatomic) IBOutlet UITextField *startPlaceTF;
@property (weak, nonatomic) IBOutlet UITextField *endPlaceTF;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *mobileTF;
@property (weak, nonatomic) IBOutlet UITextField *idCardTF;
@property (weak, nonatomic) IBOutlet UITextField *seatNumLb;
@property (weak, nonatomic) IBOutlet UITextField *insuranceNumLb;
@property (weak, nonatomic) IBOutlet UIImageView *airportIV;
@property (weak, nonatomic) IBOutlet UIImageView *etcIV;
@property (weak, nonatomic) IBOutlet UIView *topPayV;
@property (weak, nonatomic) IBOutlet UILabel *cancelPay;
@property (weak, nonatomic) IBOutlet UILabel *waitPayLb;
@property (weak, nonatomic) IBOutlet UILabel *payTipLb;
@property (weak, nonatomic) IBOutlet UILabel *priceLb;
@property (weak, nonatomic) IBOutlet UILabel *priceDetailLb;
@property (weak, nonatomic) IBOutlet UILabel *topCancelLb;
@property (weak, nonatomic) IBOutlet UILabel *payLb;
@property (weak, nonatomic) IBOutlet UILabel *status1Lb;
@property (weak, nonatomic) IBOutlet UILabel *status2Lb;
@property (weak, nonatomic) IBOutlet UILabel *status3Lb;
@property (weak, nonatomic) IBOutlet UILabel *status4Lb;
@property (weak, nonatomic) IBOutlet UILabel *status5Lb;
@property (weak, nonatomic) IBOutlet UILabel *status6Lb;
@property (weak, nonatomic) IBOutlet UILabel *carDayUnitLb;
@property (weak, nonatomic) IBOutlet UILabel *startTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *endTittleLb;
@property (weak, nonatomic) IBOutlet UILabel *startPlaceLb;
@property (weak, nonatomic) IBOutlet UILabel *endPlaceLb;
@property (weak, nonatomic) IBOutlet UILabel *basicInfoLb;
@property (weak, nonatomic) IBOutlet UILabel *nameTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *phoneTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *idCardTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *seatTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *insuranceTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *airportLb;
@property (weak, nonatomic) IBOutlet UILabel *cancelTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *orderInfoLb;
@property (weak, nonatomic) IBOutlet UITextView *cancelTV;
@property (weak, nonatomic) IBOutlet UILabel *cancelBottomLb;
@property (weak, nonatomic) IBOutlet UIImageView *iv1;
@property (weak, nonatomic) IBOutlet UIImageView *iv2;
@property (weak, nonatomic) IBOutlet UIImageView *iv3;
@property (weak, nonatomic) IBOutlet UIImageView *iv4;
@property (weak, nonatomic) IBOutlet UIImageView *iv5;
@property (weak, nonatomic) IBOutlet UIImageView *iv6;
@property (weak, nonatomic) IBOutlet UILabel *rentalDayLb;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UIView *progressV;

@end

@implementation YLOrderInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _backIV.userInteractionEnabled = YES;
    [_backIV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBack)]];
    
    _payLb.userInteractionEnabled = YES;
    [_payLb addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goPay)]];
    
    _titleLb.text = MyString(@"order_info");
    _waitPayLb.text = MyString(@"waiting_for_payment");
    _payTipLb.text = MyString(@"order_submitted2");
    _topCancelLb.text = MyString(@"cancel_order");
    _payLb.text = MyString(@"order_payment");
    _status1Lb.text = MyString(@"to_be_paid");
    _status2Lb.text = MyString(@"store_confirmation");
    _status3Lb.text = MyString(@"awaiting_vehicle_assignment");
    _status4Lb.text = MyString(@"awaiting_pickup");
    _status5Lb.text = MyString(@"in_use");
    _status6Lb.text = MyString(@"order_completed");
    _carDayUnitLb.text = MyString(@"days");
    _startTitleLb.text = MyString(@"pickup_time");
    _endTittleLb.text = MyString(@"return_time");
    _startPlaceLb.text = MyString(@"rental_location");
    _endPlaceLb.text = MyString(@"return_location");
    _basicInfoLb.text = MyString(@"basic_information");
    _nameTitleLb.text = MyString(@"booking_person_name");
    _phoneTitleLb.text = MyString(@"phone_number");
    _idCardTitleLb.text = MyString(@"id_number");
    _seatTitleLb.text = MyString(@"child_seat");
    _insuranceTitleLb.text = MyString(@"insurance");
    _airportLb.text = MyString(@"airport_transfer");
    _cancelTitleLb.text = MyString(@"cancellation_policy");
    _cancelTV.text = MyString(@"cancellation_policy1");
    _cancelBottomLb.text = MyString(@"cancel_order");
    _orderInfoLb.text = MyString(@"order_information");
}


- (void)getData{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"id"] = self.orderId;
    
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/order/getOrderInfoByID" parameters:dic complete:^(id ob) {
        self.orderBean = [YLOrderBean mj_objectWithKeyValues:ob];
        [self refreshUI];
    }];
}

-(void)refreshUI{
    if(![_orderBean.status isEqualToString:@"0"]){
        [_topPayV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.1);
        }];
        _topPayV.hidden = YES;
        [_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@950);
        }];
    }
    [self dealProgressUI];
    [_carIV sd_setImageWithURL:[NSURL URLWithString:_orderBean.carInfo.mobileUrl]];
    _carNameLb.text = _orderBean.carInfo.carTitle;
    _carInfoLb.text = [_orderBean.carInfo.lableList componentsJoinedByString:@" "];
    _carPriceLb.text = _orderBean.price;
    if(_orderBean.pickCarDate){
        _startTimeLb.text = [self convertOriginalDateString:_orderBean.pickCarDate fromFormat:@"yyyy-MM-dd HH:mm:ss" toFormat:@"yyyy-MM-dd HH"];
    }
    if(_orderBean.returnCarDate){
        _endTimeLb.text = [self convertOriginalDateString:_orderBean.returnCarDate fromFormat:@"yyyy-MM-dd HH:mm:ss" toFormat:@"yyyy-MM-dd HH"];
    }

    if(_orderBean.pickCarDate && _orderBean.returnCarDate){
        NSDateFormatter *originalDateFormatter = [[NSDateFormatter alloc] init];
        originalDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSDate *pickCarDate = [originalDateFormatter dateFromString:_orderBean.pickCarDate];
        NSDate *returnCarDate = [originalDateFormatter dateFromString:_orderBean.returnCarDate];
        long days = [self daysBetweenStartDate:pickCarDate andEndDate:returnCarDate];
        _rentalDayLb.text = [NSString stringWithFormat:@"%ld%@",days,MyString(@"day")];
//        daysBetweenStartDate

//        _rentalDayLb.text =
    }
    _startPlaceTF.text = _orderBean.pickCarAddress;
    _endPlaceTF.text = _orderBean.returnCarAddress;
    _nameTF.text = _orderBean.reserveName;
    _mobileTF.text = _orderBean.reservePhone;
    _idCardTF.text = _orderBean.reserveCard;
    _seatNumLb.text = _orderBean.seatServiceNum;
    _priceLb.text = _orderBean.actualPrice;
    if(_orderBean.insuranceService){
        if([_orderBean.insuranceService isEqualToString:@"0"]){
            _insuranceNumLb.text = MyString(@"rental_two_factor_auth");
        }else if([_orderBean.insuranceService isEqualToString:@"1"]){
            _insuranceNumLb.text = MyString(@"disclaimer_only");
        }else if([_orderBean.insuranceService isEqualToString:@"2"]){
            _insuranceNumLb.text = MyString(@"not_join");
        }
    }
    if(_orderBean.receiveService && [_orderBean.receiveService isEqualToString:@"1"]){
        [_airportIV setImage:[UIImage imageNamed:@"ic_hook_sel"]];
    }else{
        [_airportIV setImage:[UIImage imageNamed:@"ic_hook_nor"]];
    }
    if(_orderBean.etcService && [_orderBean.etcService isEqualToString:@"1"]){
        [_etcIV setImage:[UIImage imageNamed:@"ic_hook_sel"]];
    }else{
        [_etcIV setImage:[UIImage imageNamed:@"ic_hook_nor"]];
    }
    NSString *detail = [NSString stringWithFormat:MyString(@"order_submitted"),_orderBean.actualPrice,_orderBean.pointDeduction];
    _priceDetailLb.text = detail;
}

-(void)dealProgressUI{
    if([_orderBean.status isEqualToString:@"6"]){
        _progressV.alpha = 0;
        UIImageView *iv = [[UIImageView new] initWithImage:[UIImage imageNamed:@"ic_invalid"]];
        [self.view addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_progressV);
            make.size.mas_equalTo(80);
        }];
        
        UILabel *lb = [UILabel new];
        lb.textColor = HEXCOLOR(0xf2b252);
        lb.text = MyString(@"order_failed");
        lb.font = [UIFont systemFontOfSize:20];
        [self.view addSubview:lb];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(iv);
            make.top.equalTo(iv.mas_bottom).offset(8);
        }];
        
    }else if([_orderBean.status isEqualToString:@"5"]){
        
    }else if([_orderBean.status isEqualToString:@"4"]){
        [_iv6 setImage:[UIImage imageNamed:@"ic_order_progress_n"]];
    }else if([_orderBean.status isEqualToString:@"3"]){
        [_iv6 setImage:[UIImage imageNamed:@"ic_order_progress_n"]];
        [_iv5 setImage:[UIImage imageNamed:@"ic_order_progress_n"]];
    }else if([_orderBean.status isEqualToString:@"2"]){
        [_iv6 setImage:[UIImage imageNamed:@"ic_order_progress_n"]];
        [_iv5 setImage:[UIImage imageNamed:@"ic_order_progress_n"]];
        [_iv4 setImage:[UIImage imageNamed:@"ic_order_progress_n"]];
    }else if([_orderBean.status isEqualToString:@"1"]){
        [_iv6 setImage:[UIImage imageNamed:@"ic_order_progress_n"]];
        [_iv5 setImage:[UIImage imageNamed:@"ic_order_progress_n"]];
        [_iv4 setImage:[UIImage imageNamed:@"ic_order_progress_n"]];
        [_iv3 setImage:[UIImage imageNamed:@"ic_order_progress_n"]];
    }else if([_orderBean.status isEqualToString:@"0"]){
        [_iv6 setImage:[UIImage imageNamed:@"ic_order_progress_n"]];
        [_iv5 setImage:[UIImage imageNamed:@"ic_order_progress_n"]];
        [_iv4 setImage:[UIImage imageNamed:@"ic_order_progress_n"]];
        [_iv3 setImage:[UIImage imageNamed:@"ic_order_progress_n"]];
        [_iv2 setImage:[UIImage imageNamed:@"ic_order_progress_n"]];
    }
}

-(void)goPay{
    YLPayOrder *vc = [YLPayOrder new];
    vc.orderId = _orderId;
    [self.navigationController pushViewController:vc animated:NO];
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
