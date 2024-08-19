//
//  YLSummitOrderVC.m
//  luckrental
//
//  Created by kiikqjzq on 2023/9/25.
//

#import "YLSummitOrderVC.h"
#import "YLPayOrder.h"
#import "YLServicesBean.h"
#import "YLMerchantBean.h"
#import "YLLocationBean.h"
#import "YLAreaCodeBean.h"
#import <BRPickerView.h>


@interface YLSummitOrderVC ()<UIPickerViewDelegate, UIPickerViewDataSource,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *summitBtn;
@property (weak, nonatomic) IBOutlet UIImageView *carIV;
@property (weak, nonatomic) IBOutlet UILabel *carNameLb;
@property (weak, nonatomic) IBOutlet UILabel *carInfoLb;
@property (weak, nonatomic) IBOutlet UILabel *carDayPriceLb;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLb;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLb;
@property (weak, nonatomic) IBOutlet UILabel *startPlaceLb;
@property (weak, nonatomic) IBOutlet UILabel *endPlaceLb;

@property (weak, nonatomic) IBOutlet UITextField *bookNameTF;
@property (weak, nonatomic) IBOutlet UITextField *mobileTF;
@property (weak, nonatomic) IBOutlet UITextField *idCardTF;
@property (weak, nonatomic) IBOutlet UITextField *seatTF;
@property (weak, nonatomic) IBOutlet UIImageView *seatPlusIV;
@property (weak, nonatomic) IBOutlet UIImageView *seatReduceIV;
@property (weak, nonatomic) IBOutlet UITextField *insuranceTF;
@property (weak, nonatomic) IBOutlet UIImageView *insurancePlusIV;
@property (weak, nonatomic) IBOutlet UIImageView *insuranceReduceIV;
@property (weak, nonatomic) IBOutlet UIImageView *serviceIV;
@property (weak, nonatomic) IBOutlet UIImageView *etcIV;
@property (weak, nonatomic) IBOutlet UILabel *totalLb;
@property (weak, nonatomic) IBOutlet UITextView *carInfoTV;
@property (weak, nonatomic) IBOutlet UILabel *daysLb;
@property (weak, nonatomic) IBOutlet UILabel *totalTitleLb;
@property (weak, nonatomic) IBOutlet UITextField *pointTF;
@property (weak, nonatomic) IBOutlet UILabel *startTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *endTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *startPlaceTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *endPlaceTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *baseTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *nameTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *phoneTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *carTittleLb;
@property (weak, nonatomic) IBOutlet UILabel *seatTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *airportLb;
@property (weak, nonatomic) IBOutlet UILabel *ruleLb;
@property (weak, nonatomic) IBOutlet UITextView *ruleInfoLb;
@property (weak, nonatomic) IBOutlet UILabel *carDayUnitLb;
@property (weak, nonatomic) IBOutlet UILabel *usePointLb;
@property(nonatomic,strong)YLServicesBean *servicesBean;
@property (assign, nonatomic)  bool isService;
@property (assign, nonatomic)  bool isETC;
@property (nonatomic, strong) UIView *datePickerV;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property(nonatomic,strong)NSMutableArray *merchantArray;

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *selectMerchantTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *selectMerchantLb;
@property (strong, nonatomic) UIPickerView *merchantPicker;
@property (strong, nonatomic) UIPickerView *areaCodePicker;
@property (strong, nonatomic) UIToolbar *toolbar;
@property (nonatomic, strong) NSString *merchantId;
@property (weak, nonatomic) IBOutlet UIView *seatV;
@property (weak, nonatomic) IBOutlet UILabel *seatDetailsLb;
@property (weak, nonatomic) IBOutlet UILabel *seatDetailsLb2;
@property (weak, nonatomic) IBOutlet UIButton *noEtcBtn;
@property (weak, nonatomic) IBOutlet UIButton *needEtcBtn;
@property (weak, nonatomic) IBOutlet UIView *etcV;
@property (weak, nonatomic) IBOutlet UILabel *etcDetailsLb;
@property (weak, nonatomic) IBOutlet UILabel *etcDetails2Lb;
@property (weak, nonatomic) IBOutlet UILabel *tireTitleLb;
@property (weak, nonatomic) IBOutlet UIButton *tireNoUseBtn;
@property (weak, nonatomic) IBOutlet UIButton *tireUserBtn;
@property (weak, nonatomic) IBOutlet UIView *tireV;
@property (weak, nonatomic) IBOutlet UILabel *tireDetailsLb;
@property (weak, nonatomic) IBOutlet UILabel *insuranceTitleLb;
@property (weak, nonatomic) IBOutlet UIButton *insurance1Btn;
@property (weak, nonatomic) IBOutlet UIView *insurance1V;
@property (weak, nonatomic) IBOutlet UILabel *insurance1Details1Lb;
@property (weak, nonatomic) IBOutlet UILabel *insurance1Details2Lb;
@property (weak, nonatomic) IBOutlet UIButton *insurance2Btn;
@property (weak, nonatomic) IBOutlet UIView *insurance2V;
@property (weak, nonatomic) IBOutlet UILabel *insurance2Details1Lb;
@property (weak, nonatomic) IBOutlet UIButton *insurance3Btn;
@property (weak, nonatomic) IBOutlet UIView *insurance3V;
@property (weak, nonatomic) IBOutlet UILabel *insurance3Details1Lb;
@property (weak, nonatomic) IBOutlet UILabel *licenseTitleLb;
@property (weak, nonatomic) IBOutlet UIButton *license1Btn;
@property (weak, nonatomic) IBOutlet UIButton *license2Btn;
@property (weak, nonatomic) IBOutlet UIButton *license3Btn;
@property (weak, nonatomic) IBOutlet UIView *license3V;
@property (weak, nonatomic) IBOutlet UILabel *license3DetailsLb;
@property (weak, nonatomic) IBOutlet UILabel *flightTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *startFlightTitleLb;
@property (weak, nonatomic) IBOutlet UITextField *startFlightCompanyTv;
@property (weak, nonatomic) IBOutlet UITextField *startFlightNumTv;
@property (weak, nonatomic) IBOutlet UILabel *endFlightTitleLb;
@property (weak, nonatomic) IBOutlet UITextField *endFlightCompanyTv;
@property (weak, nonatomic) IBOutlet UITextField *endFlightNumTv;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UISwitch *codeSwitch;

@property (nonatomic, strong) NSString *insuranceService;
@property (nonatomic, strong) NSString *driverType;
@property (nonatomic, strong) NSString *winterTire;
@property (nonatomic, strong) NSString *driverCountry;
@property(nonatomic,strong)NSMutableArray *location1Array;
@property(nonatomic,strong)NSMutableArray *location2Array;
@property (strong, nonatomic) UIPickerView *location1Picker;
@property (strong, nonatomic) UIToolbar *location1Toolbar;
@property (strong, nonatomic) UIPickerView *location2Picker;
@property (strong, nonatomic) UIToolbar *location2Toolbar;
@property (weak, nonatomic) IBOutlet UILabel *brithdayLb;
@property (weak, nonatomic) IBOutlet UILabel *brithdayTitleDay;
@property (weak, nonatomic) IBOutlet UIView *serviceV;
@property (weak, nonatomic) IBOutlet UIView *contentV;
@property (weak, nonatomic) IBOutlet UIView *license1V;
@property (weak, nonatomic) IBOutlet UIView *license2V;
@property (weak, nonatomic) IBOutlet UILabel *license1Lb;
@property (weak, nonatomic) IBOutlet UILabel *license2Lb;

@property (strong, nonatomic) UIPickerView *region1Picker;
@property (strong, nonatomic) UIToolbar *region1Toolbar;
@property (strong, nonatomic) UIPickerView *region2Picker;
@property (strong, nonatomic) UIToolbar *region2Toolbar;
@property(nonatomic,strong)NSArray *region1Array;
@property(nonatomic,strong)NSArray *region2Array;
@property (weak, nonatomic) IBOutlet UILabel *pointBalanceLb;
@property (weak, nonatomic) IBOutlet UILabel *allUseLb;
@property(nonatomic,assign)int point;
@property (weak, nonatomic) IBOutlet UILabel *passportTipLb;
@property(nonatomic,strong)NSMutableArray *areaCodeArray;
@property (nonatomic, strong) NSString *areaCode;
@property (weak, nonatomic) IBOutlet UILabel *areaCodeTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *areaCodeLb;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollV;
@property(nonatomic,assign)long rentDays;
@property (weak, nonatomic) IBOutlet UILabel *timeTipLb;
@property (weak, nonatomic) IBOutlet UILabel *carTotalPriceLb;
@property (weak, nonatomic) IBOutlet UIImageView *carPriceDesIv;

@property (nonatomic, strong) NSString *carTotalPrice;
@property (nonatomic, strong) NSString *priceDesc;
@property (nonatomic, strong) NSString *rate;
@property (nonatomic, strong) NSString *codeDeduction;
@property (nonatomic, strong) NSString *unitPrice;


@property (nonatomic, assign) int linsurancePrice;
@property (nonatomic, assign) int seatPrice;
@property (nonatomic, assign) int etcPrice;

@end

@implementation YLSummitOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = MyString(@"confirm_order");
    self.carDayUnitLb.text = MyString(@"days");
    self.startTitleLb.text = MyString(@"pickup_time");
    self.endTitleLb.text = MyString(@"return_time");
    self.startTimeLb.text = MyString(@"select_time");
    self.endTimeLb.text = MyString(@"select_time");
    self.startPlaceTitleLb.text = MyString(@"rental_location");
    self.endPlaceTitleLb.text = MyString(@"return_location");
    self.baseTitleLb.text = MyString(@"basic_information");
    self.nameTitleLb.text = MyString(@"booking_person_name");
    self.phoneTitleLb.text = MyString(@"phone_number");
    self.carTittleLb.text = MyString(@"id_number");
    self.seatTitleLb.text = MyString(@"child_seat");
    self.insuranceTitleLb.text = MyString(@"insurance");
    self.airportLb.text = MyString(@"airport_transfer");
    self.ruleLb.text = MyString(@"points_usage_rules");
    self.ruleInfoLb.text = MyString(@"user_choose_points_payment");
    self.usePointLb.text = MyString(@"use_points");
    self.totalTitleLb.text = MyString(@"total_price");
    [self.summitBtn setTitle:MyString(@"submit_order") forState:UIControlStateNormal];
    self.startPlaceLb.text = MyString(@"please_select");
    self.endPlaceLb.text = MyString(@"please_select");
    self.bookNameTF.placeholder = MyString(@"enter");
    self.mobileTF.placeholder = MyString(@"enter");
    self.idCardTF.placeholder = MyString(@"enter");
    self.selectMerchantLb.text = MyString(@"please_select");
    self.selectMerchantTitleLb.text = MyString(@"select_merchant");
    self.brithdayLb.text = MyString(@"please_select");
    self.brithdayTitleDay.text = MyString(@"birth_date");
    [self.needEtcBtn setTitle:MyString(@"yes") forState:UIControlStateNormal];
    [self.noEtcBtn setTitle:MyString(@"no") forState:UIControlStateNormal];
    [self.tireUserBtn setTitle:MyString(@"yes") forState:UIControlStateNormal];
    [self.tireNoUseBtn setTitle:MyString(@"no") forState:UIControlStateNormal];
    
    [self.insurance1Btn setTitle:MyString(@"rental_two_factor_auth") forState:UIControlStateNormal];
    [self.insurance2Btn setTitle:MyString(@"disclaimer_only") forState:UIControlStateNormal];
    [self.insurance3Btn setTitle:MyString(@"not_join") forState:UIControlStateNormal];
    
    self.licenseTitleLb.text = MyString(@"license_type");
    [self.license1Btn setTitle:MyString(@"geneva_convention_license") forState:UIControlStateNormal];
    [self.license2Btn setTitle:MyString(@"foreign_license_with_translation") forState:UIControlStateNormal];
    [self.license3Btn setTitle:MyString(@"japan_issued_license") forState:UIControlStateNormal];
    
    self.flightTitleLb.text = MyString(@"flight_information");
    self.startFlightTitleLb.text = MyString(@"depart");
    self.endFlightTitleLb.text = MyString(@"arrive");
    self.startFlightCompanyTv.placeholder = MyString(@"airline");
    self.startFlightNumTv.placeholder = MyString(@"flight_number");
    self.endFlightCompanyTv.placeholder = MyString(@"airline");
    self.endFlightNumTv.placeholder = MyString(@"flight_number");
    
    self.license1Lb.text = MyString(@"please_select");
    self.license2Lb.text = MyString(@"please_select");
    self.pointBalanceLb.text = MyString(@"points_balance");
    self.allUseLb.text = MyString(@"all_use");
    self.passportTipLb.text = MyString(@"no_need_input_brackets");
    self.areaCodeTitleLb.text = MyString(@"mobile_area_code");
    self.areaCodeLb.text = MyString(@"please_select");
    self.tireDetailsLb.text = MyString(@"winter_tire");
    self.pointTF.placeholder = MyString(@"enter");
    self.codeTF.placeholder = MyString(@"enter_coupon");
    self.timeTipLb.text = MyString(@"pickup_return_time_constraint");
    
    
    self.ruleInfoLb.editable = NO;
    self.insuranceService = @"2";
    self.driverType = @"0";
    self.winterTire = @"0";
    self.codeDeduction = @"0";
    self.priceDesc = @"";
    self.unitPrice = @"";
    
    self.scrollV.delegate = self;
    
    
    
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:tapGesture2];
    
    _summitBtn.userInteractionEnabled = YES;
    [_summitBtn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goPayOrder)]];
    
    _serviceIV.userInteractionEnabled = YES;
    [_serviceIV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(serviceHook)]];
    
    _etcIV.userInteractionEnabled = YES;
    [_etcIV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(etcHook)]];
    
    _startTimeLb.userInteractionEnabled = YES;
    _startTimeLb.tag = 111;
    [_startTimeLb addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDatePicker:)]];
    

    _endTimeLb.userInteractionEnabled = YES;
    _endTimeLb.tag = 222;
    [_endTimeLb addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDatePicker:)]];
    
    _seatPlusIV.userInteractionEnabled = YES;
    [_seatPlusIV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seatPlus)]];
    
    _seatReduceIV.userInteractionEnabled = YES;
    [_seatReduceIV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seatReduce)]];
    
    _insurancePlusIV.userInteractionEnabled = YES;
    [_insurancePlusIV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(insurancePlus)]];
    
    _insuranceReduceIV.userInteractionEnabled = YES;
    [_insuranceReduceIV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(insuranceReduce)]];
    
    [self.pointTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    _selectMerchantLb.userInteractionEnabled = YES;
    [_selectMerchantLb addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicker)]];
    
    _needEtcBtn.tag = 111;
    _noEtcBtn.tag = 222;
    [_needEtcBtn addTarget:self action:@selector(etcClick:) forControlEvents:UIControlEventTouchUpInside];
    [_noEtcBtn addTarget:self action:@selector(etcClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _tireUserBtn.tag = 333;
    _tireNoUseBtn.tag = 444;
    [_tireUserBtn addTarget:self action:@selector(tireClick:) forControlEvents:UIControlEventTouchUpInside];
    [_tireNoUseBtn addTarget:self action:@selector(tireClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _insurance1Btn.tag = 555;
    _insurance2Btn.tag = 666;
    _insurance3Btn.tag = 777;
    [_insurance1Btn addTarget:self action:@selector(insuranceClick:) forControlEvents:UIControlEventTouchUpInside];
    [_insurance2Btn addTarget:self action:@selector(insuranceClick:) forControlEvents:UIControlEventTouchUpInside];
    [_insurance3Btn addTarget:self action:@selector(insuranceClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _license1Btn.tag = 888;
    _license2Btn.tag = 999;
    _license3Btn.tag = 1010;
    [_license1Btn addTarget:self action:@selector(licenseClick:) forControlEvents:UIControlEventTouchUpInside];
    [_license2Btn addTarget:self action:@selector(licenseClick:) forControlEvents:UIControlEventTouchUpInside];
    [_license3Btn addTarget:self action:@selector(licenseClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _startPlaceLb.userInteractionEnabled = YES;
    [_startPlaceLb addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showLocatioin1Picker)]];
    
    _endPlaceLb.userInteractionEnabled = YES;
    [_endPlaceLb addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showLocatioin2Picker)]];
    
    
    _brithdayLb.userInteractionEnabled = YES;
    _brithdayLb.tag = 333;
    [_brithdayLb addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDatePicker:)]];
    
    _license1V.userInteractionEnabled = YES;
    [_license1V addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showRegion1Picker)]];
    
    _license2V.userInteractionEnabled = YES;
    [_license2V addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showRegion2Picker)]];
    
    self.region1Array = @[@"Hong Kong",@"Macao",@"India",@"Thailand",@"Bangladesh",@"Malaysia",@"Singapore",@"Sri Lanka",@"Other"];
    self.region2Array = @[@"Germany",@"France",@"Switzerland",@"Belgium",@"Monaco",@"Taiwan"];
    
    _allUseLb.userInteractionEnabled = YES;
    [_allUseLb addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(useAll)]];
    
    _areaCodeLb.userInteractionEnabled = YES;
    [_areaCodeLb addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAreaCodePicker)]];
    
    [_codeSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_codeTF addTarget:self action:@selector(codeTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    _carPriceDesIv.userInteractionEnabled = YES;
    [_carPriceDesIv addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPopupWithContent)]];
    
    [self refreshUI];
}
- (void)getData{
    PXWeakSelf
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/order/getServices" parameters:nil complete:^(id ob) {
        weakSelf.servicesBean = [YLServicesBean mj_objectWithKeyValues:ob];
        [weakSelf refreshServiceUI];
    }];
    
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/merchant/getAllMerchant" parameters:nil complete:^(id ob) {
        weakSelf.merchantArray = [YLMerchantBean mj_objectArrayWithKeyValuesArray:ob];
    }];
    
    
    NSMutableDictionary *dic1 = [NSMutableDictionary new];
    dic1[@"type"] = @"1";
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/order/getLocationService" parameters:dic1 complete:^(id ob) {
        weakSelf.location1Array = [YLLocationBean mj_objectArrayWithKeyValuesArray:ob];
    }];
    
    NSMutableDictionary *dic2 = [NSMutableDictionary new];
    dic2[@"type"] = @"2";
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/order/getLocationService" parameters:dic2 complete:^(id ob) {
        weakSelf.location2Array = [YLLocationBean mj_objectArrayWithKeyValuesArray:ob];
    }];
    
    
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/member/getBalance" parameters:nil complete:^(id ob) {
        self.point = [ob intValue];
        //        self.point = 100;
        
        // 在你的方法中使用以下代码
        NSString *pointsBalanceString = MyString(@"points_balance");
        NSString *stringValue = [ob stringValue];
        //        stringValue = @"100";
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@: %@", MyString(@"points_balance"), stringValue]];
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, pointsBalanceString.length + 2)];
        [attributedString addAttributes:@{NSForegroundColorAttributeName: HEXCOLOR(0xFEAE3A), NSFontAttributeName: [UIFont systemFontOfSize:16]} range:NSMakeRange(pointsBalanceString.length + 2, stringValue.length)];
        
        weakSelf.pointBalanceLb.attributedText = attributedString;
        
        //        weakSelf.pointBalanceLb.text = [NSString stringWithFormat:@"%@:%@",MyString(@"points_balance"),[ob stringValue]];
    }];
    
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/aboutUS/getAreaCode" parameters:nil complete:^(id ob) {
        weakSelf.areaCodeArray = [YLAreaCodeBean mj_objectArrayWithKeyValuesArray:ob];
    }];
    
}

- (void)goPayOrder {
    
    NSString *name = _bookNameTF.text;
    NSString *mobile = _mobileTF.text;
    NSString *idCard = _idCardTF.text;
    
    if(!self.merchantId){
        [self.view makeToast:MyString(@"select_merchant")];
        return;
    }
    
    if(!_startDate){
        [self.view makeToast:MyString(@"select_pickup_time")];
        return;
    }
    
    if(!_endDate){
        [self.view makeToast:MyString(@"select_return_time")];
        return;
    }
    
    if(_startPlaceLb.text.length == 0 || [_startPlaceLb.text isEqualToString:MyString(@"please_select")]){
        [self.view makeToast:MyString(@"enter_pickup_location")];
        return;
    }
    
    if(_endPlaceLb.text.length == 0 || [_endPlaceLb.text isEqualToString:MyString(@"please_select")]){
        [self.view makeToast:MyString(@"enter_return_location")];
        return;
    }
    
    if(!name || name.length==0){
        [self.view makeToast:MyString(@"enter_name")];
        return;
    }
    
    if(!mobile || mobile.length==0){
        [self.view makeToast:MyString(@"enter_phone_number")];
        return;
    }
    
    if(!idCard || idCard.length==0){
        [self.view makeToast:MyString(@"enter_id_number")];
        return;
    }
    
    if(!self.areaCode || self.areaCode.length==0){
        [self.view makeToast:MyString(@"select_mobile_country_code")];
        return;
    }
    
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"actualPrice"] = _totalLb.text;
    dic[@"carId"] = _carBean.carId;
    dic[@"etcService"] = _isETC?@(1):@(0);
    dic[@"insuranceService"] = [_insuranceTF.text intValue]>0?@(1):@(0);
    dic[@"insuranceServiceNum"] =@([_insuranceTF.text intValue]);
    dic[@"pickCarAddress"] = _startPlaceLb.text;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *selectedDate = [dateFormatter stringFromDate:_startDate];
    NSString *selectedDate2 = [dateFormatter stringFromDate:_endDate];
    dic[@"pickCarDate"] = selectedDate;
    dic[@"pointDeduction"] = _pointTF.text;
    dic[@"price"] = _unitPrice;
    dic[@"receiveService"] = _isService?@(1):@(0);
    dic[@"reserveCard"] = idCard;
    dic[@"reserveName"] = name;
    dic[@"reservePhone"] = [NSString stringWithFormat:@"%@%@",self.areaCode,mobile];;
    dic[@"returnCarAddress"] = _endPlaceLb.text;
    dic[@"returnCarDate"] =  selectedDate2;
    dic[@"seatService"] = [_seatTF.text intValue]>0?@(1):@(0);
    dic[@"seatServiceNum"] = @([_seatTF.text intValue]);
    dic[@"merchantId"] = self.merchantId;
    dic[@"startAviationCompany"] = _startFlightCompanyTv.text;
    dic[@"startFlightCode"] = _startFlightNumTv.text;
    dic[@"endAviationCompany"] = _endFlightCompanyTv.text;
    dic[@"endFlightCode"] =_endFlightNumTv.text;
    dic[@"winterTire"] = self.winterTire;
    dic[@"driverType"] = self.driverType;
    dic[@"insuranceService"] = self.insuranceService;
    dic[@"driverCountry"] = self.driverCountry;
    dic[@"reserveBirthday"] = self.brithdayLb.text;
    dic[@"promotionCode"] = self.codeTF.text;
    dic[@"codeDeduction"] = self.codeDeduction;
    dic[@"priceDetail"] = self.priceDesc;
    dic[@"linsurancePrice"] = [NSString stringWithFormat:@"%d",self.linsurancePrice];
    dic[@"seatPrice"] = [NSString stringWithFormat:@"%d",self.seatPrice];
    dic[@"etcPrice"] = [NSString stringWithFormat:@"%d",self.etcPrice];
    
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodPost URLString:@"/api/order/submitOrder" parameters:dic complete:^(id ob) {
        YLPayOrder *vc = [YLPayOrder new];
        vc.orderId = ob;
        [self.navigationController pushViewController:vc animated:YES];
    }];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)refreshUI {
    [_carIV sd_setImageWithURL:[NSURL URLWithString:_carBean.mobileUrl]];
    _carDayPriceLb.text = _carBean.price;
    _carNameLb.text = _carBean.carTitle;
    _carInfoLb.text = _carBean.descript;
}

- (void)refreshServiceUI {
    if(_servicesBean.tyreAble == 0){
        [_serviceV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@550);
        }];
        [_contentV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@2550);
        }];
    }
    
    _seatDetailsLb.text = _servicesBean.seatPriceDesc;
    _seatDetailsLb2.text = _servicesBean.seatDesc;
    
    _etcDetailsLb.text = _servicesBean.etcPriceDesc;
    _etcDetails2Lb.text = _servicesBean.etcDesc;
    _tireDetailsLb.text = _servicesBean.tyreDesc;
    
    //    CGFloat seatDetailsLb2Height = [self calculateLabelHeightIncrease:_seatDetailsLb2];
    //    CGFloat etcDetails2LbHeight = [self calculateLabelHeightIncrease:_etcDetails2Lb];
    //    CGFloat tireDetailsLbHeight = [self calculateLabelHeightIncrease:_tireDetailsLb];
    //
    //    if(seatDetailsLb2Height>0){
    //        [_seatDetailsLb2 mas_makeConstraints:^(MASConstraintMaker *make) {
    //            make.height.mas_equalTo([self calculateLabelHeight:_seatDetailsLb2]);
    //        }];
    //        [_seatV mas_makeConstraints:^(MASConstraintMaker *make) {
    //            make.height.mas_equalTo(_seatV.frame.size.height+seatDetailsLb2Height);
    //        }];
    //
    //        [_seatDetailsLb2 mas_updateConstraints:^(MASConstraintMaker *make) {
    //            make.height.mas_equalTo([self calculateLabelHeight:_seatDetailsLb2]);
    //        }];
    //        [_seatV mas_updateConstraints:^(MASConstraintMaker *make) {
    //            make.height.mas_equalTo(_seatV.frame.size.height+seatDetailsLb2Height);
    //        }];
    //    }
    
    
    //    [_etcDetails2Lb mas_updateConstraints:^(MASConstraintMaker *make) {
    //        make.height.mas_equalTo([self calculateLabelHeight:_etcDetails2Lb]);
    //    }];
    //
    //    if(_servicesBean.tyreAble == 0){
    //        [_serviceV mas_updateConstraints:^(MASConstraintMaker *make) {
    //            make.height.mas_equalTo(550+seatDetailsLb2Height+etcDetails2LbHeight);
    //        }];
    //        [_contentV mas_updateConstraints:^(MASConstraintMaker *make) {
    //            make.height.mas_equalTo(2280+seatDetailsLb2Height+etcDetails2LbHeight);
    //        }];
    //    }else{
    //        [_tireDetailsLb mas_updateConstraints:^(MASConstraintMaker *make) {
    //            make.height.mas_equalTo(_tireDetailsLb.frame.size.height+seatDetailsLb2Height);
    //        }];
    //        [_serviceV mas_updateConstraints:^(MASConstraintMaker *make) {
    //            make.height.mas_equalTo(650+seatDetailsLb2Height+etcDetails2LbHeight+tireDetailsLbHeight);
    //        }];
    //        [_contentV mas_updateConstraints:^(MASConstraintMaker *make) {
    //            make.height.mas_equalTo(2380+seatDetailsLb2Height+etcDetails2LbHeight+tireDetailsLbHeight);
    //        }];
    //    }
    //    [_etcV mas_updateConstraints:^(MASConstraintMaker *make) {
    //        make.height.mas_equalTo(_etcV.frame.size.height+labelHeight);
    //    }];
    //
    //    [_serviceV mas_updateConstraints:^(MASConstraintMaker *make) {
    //        make.height.mas_equalTo(_serviceV.frame.size.height+labelHeight);
    //    }];
    
    
    
    
    _insurance1Details1Lb.text = _servicesBean.linsuranceItem1PriceDesc;
    _insurance1Details2Lb.text = _servicesBean.linsuranceItem1Desc;
    
    _insurance2Details1Lb.text = _servicesBean.linsuranceItem2PriceDesc;
    
    _insurance3Details1Lb.text = _servicesBean.linsuranceItem3Desc;
    _license3DetailsLb.text = _servicesBean.driverDesc;
    
    
    
}

- (void)seatPlus{
    int integerValue = [_seatTF.text intValue];
    if(integerValue >= 3){
        return;
    }
    integerValue ++;
    _seatTF.text = [NSString stringWithFormat:@"%d", integerValue];
    [self calculateTotalPrice];
}

- (void)seatReduce{
    int integerValue = [_seatTF.text intValue];
    if(integerValue > 0){
        integerValue --;
        _seatTF.text = [NSString stringWithFormat:@"%d", integerValue];
        [self calculateTotalPrice];
    }
}


- (void)insurancePlus{
    int integerValue = [_insuranceTF.text intValue];
    integerValue ++;
    _insuranceTF.text = [NSString stringWithFormat:@"%d", integerValue];
    [self calculateTotalPrice];
}

- (void)insuranceReduce{
    int integerValue = [_insuranceTF.text intValue];
    if(integerValue >0){
        integerValue --;
        _insuranceTF.text = [NSString stringWithFormat:@"%d", integerValue];
        [self calculateTotalPrice];
    }
}

- (void)serviceHook{
    if(_isService){
        [_serviceIV setImage:[UIImage imageNamed:@"ic_hook_nor"]];
    }else{
        [_serviceIV setImage:[UIImage imageNamed:@"ic_hook_sel"]];
    }
    _isService = !_isService;
    [self calculateTotalPrice];
}

- (void)etcHook{
    if(_isETC){
        [_etcIV setImage:[UIImage imageNamed:@"ic_hook_nor"]];
    }else{
        [_etcIV setImage:[UIImage imageNamed:@"ic_hook_sel"]];
    }
    _isETC = !_isETC;
    [self calculateTotalPrice];
}

- (void)showDatePicker :(UITapGestureRecognizer *)sender{
    // 1.创建日期选择器
    BRDatePickerView *datePickerView = [[BRDatePickerView alloc]init];
    // 设置自定义样式
    BRPickerStyle *customStyle = [[BRPickerStyle alloc]init];
    customStyle.cancelBtnTitle = MyString(@"cancel");
    customStyle.doneBtnTitle = MyString(@"confirm");
    customStyle.pickerColor = [UIColor whiteColor];
    customStyle.pickerTextColor = [UIColor blackColor];
    customStyle.separatorColor = HEXCOLOR(0xececec);
    datePickerView.pickerStyle = customStyle;
    datePickerView.customUnit = @{@"year": MyString(@"year"), @"month": MyString(@"month"), @"day": MyString(@"day"), @"hour": MyString(@"hour"), @"minute": MyString(@"minute"), @"second": MyString(@"second")};
    datePickerView.title = MyString(@"select_time");
    // 获取当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //    datePickerView.isAutoSelect = YES;
    if(sender.view.tag == 333){
        datePickerView.pickerMode = BRDatePickerModeYMD;
        datePickerView.selectDate = [NSDate br_setYear:1980 month:1 day:1];
        datePickerView.minDate = [NSDate br_setYear:1923 month:1 day:1];
    }else{
        datePickerView.pickerMode = BRDatePickerModeYMDHM;
        datePickerView.minuteInterval = 30;
        // 获取当前时间
        NSDate *currentDate = [NSDate date];
        // 获取当前时间的年、月、日、小时
        NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour fromDate:currentDate];
        
        // 检查当前小时是否小于 10
        if (components.hour < 10) {
            // 如果当前小时小于 10，则将小时设置为 10
            components.hour = 10;
        }
        
        // 将分钟和秒设置为0
        [components setMinute:0];
        [components setSecond:0];
        // 构建新的日期对象，即当前小时的0分0秒
        NSDate *curDate = [calendar dateFromComponents:components];
        
        // 获取六个月后的日期
        NSDateComponents *sixMonthsComponents = [[NSDateComponents alloc] init];
        sixMonthsComponents.month = 6;
        NSDate *sixMonthsLaterDate = [calendar dateByAddingComponents:sixMonthsComponents toDate:currentDate options:0];

        // 将其设置为当天的23:59:59
        NSDateComponents *components2 = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:sixMonthsLaterDate];
        components2.hour = 20;
        components2.minute = 0;
        components2.second = 0;
        NSDate *sixMonthsLaterEndOfDay = [calendar dateFromComponents:components2];
        datePickerView.maxDate = sixMonthsLaterEndOfDay;
        if(sender.view.tag == 111){
            datePickerView.minDate = curDate;
            if(_startDate){
                datePickerView.selectDate = _startDate;
            }else{
                datePickerView.selectDate = curDate;
            }
            if(_endDate){
                datePickerView.maxDate = _endDate;
            }
        }else{
            if(_endDate){
                datePickerView.selectDate = _endDate;
            }
            if(_startDate){
                datePickerView.minDate = _startDate;
            }else{
                _startDate = curDate;
            }
        }
    }
    PXWeakSelf
    datePickerView.resultBlock = ^(NSDate *selectDate, NSString *selectValue) {
        NSLog(@"选择的值：%@", selectValue);
        if(sender.view.tag ==111){
//            if([weakSelf isBefore10AMOrAfter8PM:selectDate]){
//                [weakSelf.view makeToast:MyString(@"pickup_return_time_constraint")];
//                return;
//            }
            weakSelf.startDate = selectDate;
            weakSelf.startTimeLb.text = selectValue;
            if(weakSelf.startDate && weakSelf.endDate){
                [weakSelf checkDateValide:weakSelf.startDate :weakSelf.endDate];
            }
        }else if(sender.view.tag ==222){
//            if([weakSelf isBefore10AMOrAfter8PM:selectDate]){
//                [weakSelf.view makeToast:MyString(@"pickup_return_time_constraint")];
//                return;
//            }
            weakSelf.endDate = selectDate;
            weakSelf.endTimeLb.text = selectValue;
            if(weakSelf.startDate && weakSelf.endDate){
                [weakSelf checkDateValide:weakSelf.startDate :weakSelf.endDate];
            }
        }else{
            weakSelf.brithdayLb.text = selectValue;
        }
        
        
    };
    // 3.显示
    [datePickerView show];
}



- (NSInteger)daysBetweenStartDate:(NSDate *)startDate andEndDate:(NSDate *)endDate {
    
    // 获取默认的日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 设置计算时间差的单位为天
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitHour;
    
    // 获取日期组件
    NSDateComponents *components = [calendar components:unit
                                               fromDate:startDate
                                                 toDate:endDate
                                                options:0];
    
    // 计算天数差，不满一天算一天
    NSInteger daysDifference = components.day + (components.hour > 0 ? 1 : 0);
    
    return daysDifference;
}

- (void)calculateTotalPrice{
    double totalPrice = 0;
    NSInteger num = 0;
    self.codeDeduction = @"0";
    if(_startDate && _endDate){
        num = [self daysBetweenStartDate:_startDate andEndDate:_endDate];
        if(_carTotalPrice){
            double ratePrice = 0;
            if(_rate && _codeSwitch.isOn){
                ratePrice = [_carTotalPrice doubleValue]* [_rate doubleValue];
                self.codeDeduction = [NSString stringWithFormat:@"%f",ratePrice];
            }
            totalPrice = [_carTotalPrice doubleValue] - ratePrice;
        }
        
    }
    
    if([_insuranceService isEqualToString:@"0"]){
        totalPrice += num *_servicesBean.linsuranceItem1Price;
        _linsurancePrice = (int)num *_servicesBean.linsuranceItem1Price;
    }else if([_insuranceService isEqualToString:@"1"]){
        totalPrice += num *_servicesBean.linsuranceItem2Price;
        _linsurancePrice = (int)num *_servicesBean.linsuranceItem2Price;
    }else{
        totalPrice += num *_servicesBean.linsuranceItem3Price;
        _linsurancePrice = (int)num *_servicesBean.linsuranceItem3Price;
    }
    
    if([_winterTire isEqualToString:@"0"]){
        totalPrice += 0;
    }else{
        totalPrice += _servicesBean.tyrePrice;
    }
    
    if([_seatTF.text intValue]>0){
        totalPrice += _servicesBean.seatPrice * [_seatTF.text intValue];
        _seatPrice = _servicesBean.seatPrice * [_seatTF.text intValue];
    }else{
        totalPrice += 0;
        _seatPrice = 0;
    }
    
    if(_isETC){
        totalPrice += _servicesBean.etcPrice;
        _etcPrice = _servicesBean.seatPrice;
    }else{
        totalPrice += 0;
        _etcPrice = 0;
    }
    
    
    if(_pointTF.text.length>0 && [_pointTF.text intValue]>0){
        totalPrice -= [_pointTF.text intValue];
        if(totalPrice < 0){
            totalPrice = 0;
        }
    }
    _totalLb.text = [NSString stringWithFormat:@"%.2f", totalPrice];
}


- (void)textFieldDidChange:(UITextField *)textField {
    NSString *point = textField.text;
    if(textField.text.length == 0){
        point = [NSString stringWithFormat:@"%d", 0];
    }
    int inputPoint = [point intValue];
    if (inputPoint>self.point) {
        inputPoint = self.point;
    }
    textField.text = [NSString stringWithFormat:@"%d", inputPoint];
    [self calculateTotalPrice];
}


- (void)hideKeyboard {
    [self.view endEditing:YES];
}


-(void)showPicker{
    if(self.merchantPicker.superview != nil){
        return;
    }
    // 创建PickerView
    self.merchantPicker = [UIPickerView new];
    self.merchantPicker.tag = 1111;
    self.merchantPicker.backgroundColor = UIColor.whiteColor;
    self.merchantPicker.delegate = self;
    self.merchantPicker.dataSource = self;
    // 创建Toolbar
    _toolbar = [UIToolbar new];
    _toolbar.backgroundColor = UIColor.whiteColor;
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:MyString(@"cancel") style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonTapped2)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:MyString(@"confirm") style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonTapped2)];
    _toolbar.items = @[cancelButton, flexibleSpace, doneButton];
    
    // 将PickerView和Toolbar添加到视图中
    [self.view addSubview:self.merchantPicker];
    [self.view addSubview:_toolbar];
    [self.merchantPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(@300);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    [_toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(@44);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.merchantPicker.mas_top);
    }];
    
}

-(void)showLocatioin1Picker{
    if(self.location1Picker.superview != nil){
        return;
    }
    // 创建PickerView
    self.location1Picker = [UIPickerView new];
    self.location1Picker.tag = 2222;
    self.location1Picker.backgroundColor = UIColor.whiteColor;
    self.location1Picker.delegate = self;
    self.location1Picker.dataSource = self;
    // 创建Toolbar
    _location1Toolbar = [UIToolbar new];
    _location1Toolbar.backgroundColor = UIColor.whiteColor;
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:MyString(@"cancel") style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonTapped3)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:MyString(@"confirm") style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonTapped3)];
    _location1Toolbar.items = @[cancelButton, flexibleSpace, doneButton];
    
    // 将PickerView和Toolbar添加到视图中
    [self.view addSubview:self.location1Picker];
    [self.view addSubview:_location1Toolbar];
    [self.location1Picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(@300);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    [_location1Toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(@44);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.location1Picker.mas_top);
    }];
    
}

-(void)showLocatioin2Picker{
    if(self.location2Picker.superview != nil){
        return;
    }
    // 创建PickerView
    self.location2Picker = [UIPickerView new];
    self.location2Picker.tag = 3333;
    self.location2Picker.backgroundColor = UIColor.whiteColor;
    self.location2Picker.delegate = self;
    self.location2Picker.dataSource = self;
    // 创建Toolbar
    _location2Toolbar = [UIToolbar new];
    _location2Toolbar.backgroundColor = UIColor.whiteColor;
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:MyString(@"cancel") style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonTapped4)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:MyString(@"confirm") style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonTapped4)];
    _location2Toolbar.items = @[cancelButton, flexibleSpace, doneButton];
    
    // 将PickerView和Toolbar添加到视图中
    [self.view addSubview:self.location2Picker];
    [self.view addSubview:_location2Toolbar];
    [self.location2Picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(@300);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    [_location2Toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(@44);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.location2Picker.mas_top);
    }];
    
}

-(void)showRegion1Picker{
    if(self.region1Picker.superview != nil){
        return;
    }
    // 创建PickerView
    self.region1Picker = [UIPickerView new];
    self.region1Picker.tag = 7777;
    self.region1Picker.backgroundColor = UIColor.whiteColor;
    self.region1Picker.delegate = self;
    self.region1Picker.dataSource = self;
    // 创建Toolbar
    _region1Toolbar = [UIToolbar new];
    _region1Toolbar.backgroundColor = UIColor.whiteColor;
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:MyString(@"cancel") style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonTapped5)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:MyString(@"confirm") style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonTapped5)];
    _region1Toolbar.items = @[cancelButton, flexibleSpace, doneButton];
    
    // 将PickerView和Toolbar添加到视图中
    [self.view addSubview:self.region1Picker];
    [self.view addSubview:_region1Toolbar];
    [self.region1Picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(@300);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    [_region1Toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(@44);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.region1Picker.mas_top);
    }];
    
}


-(void)showRegion2Picker{
    if(self.region2Picker.superview != nil){
        return;
    }
    // 创建PickerView
    self.region2Picker = [UIPickerView new];
    self.region2Picker.tag = 8888;
    self.region2Picker.backgroundColor = UIColor.whiteColor;
    self.region2Picker.delegate = self;
    self.region2Picker.dataSource = self;
    // 创建Toolbar
    _region2Toolbar = [UIToolbar new];
    _region2Toolbar.backgroundColor = UIColor.whiteColor;
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:MyString(@"cancel") style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonTapped6)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:MyString(@"confirm") style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonTapped6)];
    _region2Toolbar.items = @[cancelButton, flexibleSpace, doneButton];
    
    // 将PickerView和Toolbar添加到视图中
    [self.view addSubview:self.region2Picker];
    [self.view addSubview:_region2Toolbar];
    [self.region2Picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(@300);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    [_region2Toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(@44);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.region2Picker.mas_top);
    }];
    
}


-(void)showAreaCodePicker{
    if(self.areaCodePicker.superview != nil){
        return;
    }
    // 创建PickerView
    self.areaCodePicker = [UIPickerView new];
    self.areaCodePicker.tag = 9999;
    self.areaCodePicker.backgroundColor = UIColor.whiteColor;
    self.areaCodePicker.delegate = self;
    self.areaCodePicker.dataSource = self;
    // 创建Toolbar
    _toolbar = [UIToolbar new];
    _toolbar.backgroundColor = UIColor.whiteColor;
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:MyString(@"cancel") style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonTapped7)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:MyString(@"confirm") style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonTapped7)];
    _toolbar.items = @[cancelButton, flexibleSpace, doneButton];
    
    // 将PickerView和Toolbar添加到视图中
    [self.view addSubview:self.areaCodePicker];
    [self.view addSubview:_toolbar];
    [self.areaCodePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(@300);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    [_toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(@44);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.areaCodePicker.mas_top);
    }];
    
}

#pragma mark - UIPickerViewDelegate and UIPickerViewDataSource methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1; // 选择1列
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(pickerView.tag == 1111){
        return self.merchantArray.count;
    }else if(pickerView.tag == 2222){
        return self.location1Array.count;
    }else if(pickerView.tag == 3333){
        return self.location2Array.count;
    }else if(pickerView.tag == 7777){
        return self.region1Array.count;
    }if(pickerView.tag == 8888){
        return self.region2Array.count;
    }else{
        return self.areaCodeArray.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(pickerView.tag == 1111){
        YLMerchantBean * bean = [YLMerchantBean mj_objectWithKeyValues:self.merchantArray[row]];
        return bean.title;
    }else if(pickerView.tag == 2222){
        YLLocationBean * bean = self.location1Array[row];
        return bean.address;
    }else if(pickerView.tag == 3333){
        YLLocationBean * bean = self.location2Array[row];;
        return bean.address;
    }else if(pickerView.tag == 7777){
        NSString *bean = self.region1Array[row];
        return bean;
    }else if(pickerView.tag == 8888){
        NSString *bean = self.region2Array[row];
        return bean;
    }else{
        YLAreaCodeBean *bean = self.areaCodeArray[row];
        NSString *str = [NSString stringWithFormat:@"%@%@",bean.en,bean.code];
        return str;
    }
    
}

#pragma mark - Button actions

- (void)cancelButtonTapped2 {
    // 处理取消按钮点击事件
    [self.merchantPicker removeFromSuperview];
    [self.toolbar removeFromSuperview];
}

- (void)doneButtonTapped2 {
    // 处理完成按钮点击事件
    NSInteger selectedRow = [self.merchantPicker selectedRowInComponent:0];
    YLMerchantBean * bean = [YLMerchantBean mj_objectWithKeyValues:self.merchantArray[selectedRow]];
    NSString *selectedmerchant = bean.title;
    self.selectMerchantLb.text = selectedmerchant;
    self.merchantId = bean.merchantId;
    [self.merchantPicker removeFromSuperview];
    [self.toolbar removeFromSuperview];
}

- (void)cancelButtonTapped3 {
    // 处理取消按钮点击事件
    [self.location1Picker removeFromSuperview];
    [self.location1Toolbar removeFromSuperview];
}

- (void)doneButtonTapped3 {
    // 处理完成按钮点击事件
    NSInteger selectedRow = [self.location1Picker selectedRowInComponent:0];
    YLLocationBean * bean = self.location1Array[selectedRow];
    NSString *selectedmerchant = bean.address;
    self.startPlaceLb.text = selectedmerchant;
    [self.location1Picker removeFromSuperview];
    [self.location1Toolbar removeFromSuperview];
}

- (void)cancelButtonTapped4 {
    // 处理取消按钮点击事件
    [self.location2Picker removeFromSuperview];
    [self.location2Toolbar removeFromSuperview];
}

- (void)doneButtonTapped4 {
    // 处理完成按钮点击事件
    NSInteger selectedRow = [self.location2Picker selectedRowInComponent:0];
    YLLocationBean * bean = self.location2Array[selectedRow];
    NSString *selectedmerchant = bean.address;
    self.endPlaceLb.text = selectedmerchant;
    [self.location2Picker removeFromSuperview];
    [self.location2Toolbar removeFromSuperview];
}


- (void)cancelButtonTapped5 {
    // 处理取消按钮点击事件
    [self.region1Picker removeFromSuperview];
    [self.region1Toolbar removeFromSuperview];
}

- (void)doneButtonTapped5 {
    // 处理完成按钮点击事件
    NSInteger selectedRow = [self.region1Picker selectedRowInComponent:0];
    NSString *selectedmerchant = self.region1Array[selectedRow];
    self.license1Lb.text = selectedmerchant;
    self.driverCountry = selectedmerchant;
    [self.region1Picker removeFromSuperview];
    [self.region1Toolbar removeFromSuperview];
}

- (void)cancelButtonTapped6 {
    // 处理取消按钮点击事件
    [self.region2Picker removeFromSuperview];
    [self.region2Toolbar removeFromSuperview];
}

- (void)doneButtonTapped6 {
    // 处理完成按钮点击事件
    NSInteger selectedRow = [self.region2Picker selectedRowInComponent:0];
    NSString *selectedmerchant = self.region2Array[selectedRow];
    self.license2Lb.text = selectedmerchant;
    self.driverCountry = selectedmerchant;
    [self.region2Picker removeFromSuperview];
    [self.region2Toolbar removeFromSuperview];
}


- (void)cancelButtonTapped7 {
    // 处理取消按钮点击事件
    [self.areaCodePicker removeFromSuperview];
    [self.toolbar removeFromSuperview];
}

- (void)doneButtonTapped7 {
    // 处理完成按钮点击事件
    NSInteger selectedRow = [self.areaCodePicker selectedRowInComponent:0];
    YLAreaCodeBean * bean = self.areaCodeArray[selectedRow];
    NSString *selectedmerchant = [NSString stringWithFormat:@"%@ %@",bean.en,bean.code];
    self.areaCodeLb.text = selectedmerchant;
    self.areaCode = bean.code;
    [self.areaCodePicker removeFromSuperview];
    [self.toolbar removeFromSuperview];
}

- (void)etcClick:(UIButton*)btn{
    if(btn.tag == 111){
        [_needEtcBtn setImage:[UIImage imageNamed:@"ic_hook_sel"] forState:UIControlStateNormal];
        [_noEtcBtn setImage:[UIImage imageNamed:@"ic_hook_nor"] forState:UIControlStateNormal];
        _isETC = YES;
    }else{
        [_needEtcBtn setImage:[UIImage imageNamed:@"ic_hook_nor"] forState:UIControlStateNormal];
        [_noEtcBtn setImage:[UIImage imageNamed:@"ic_hook_sel"] forState:UIControlStateNormal];
        _isETC = NO;
    }
    [self calculateTotalPrice];
}


- (void)tireClick:(UIButton*)btn{
    if(btn.tag == 333){
        [_tireUserBtn setImage:[UIImage imageNamed:@"ic_hook_sel"] forState:UIControlStateNormal];
        [_tireNoUseBtn setImage:[UIImage imageNamed:@"ic_hook_nor"] forState:UIControlStateNormal];
        self.winterTire = @"1";
    }else{
        [_tireUserBtn setImage:[UIImage imageNamed:@"ic_hook_nor"] forState:UIControlStateNormal];
        [_tireNoUseBtn setImage:[UIImage imageNamed:@"ic_hook_sel"] forState:UIControlStateNormal];
        self.winterTire = @"0";
    }
    [self calculateTotalPrice];
}

- (void)insuranceClick:(UIButton*)btn{
    if(btn.tag == 555){
        [_insurance1Btn setImage:[UIImage imageNamed:@"ic_hook_sel"] forState:UIControlStateNormal];
        [_insurance2Btn setImage:[UIImage imageNamed:@"ic_hook_nor"] forState:UIControlStateNormal];
        [_insurance3Btn setImage:[UIImage imageNamed:@"ic_hook_nor"] forState:UIControlStateNormal];
        self.insuranceService = @"0";
    }else if(btn.tag == 666){
        [_insurance1Btn setImage:[UIImage imageNamed:@"ic_hook_nor"] forState:UIControlStateNormal];
        [_insurance2Btn setImage:[UIImage imageNamed:@"ic_hook_sel"] forState:UIControlStateNormal];
        [_insurance3Btn setImage:[UIImage imageNamed:@"ic_hook_nor"] forState:UIControlStateNormal];
        self.insuranceService = @"1";
    }else{
        [_insurance1Btn setImage:[UIImage imageNamed:@"ic_hook_nor"] forState:UIControlStateNormal];
        [_insurance2Btn setImage:[UIImage imageNamed:@"ic_hook_nor"] forState:UIControlStateNormal];
        [_insurance3Btn setImage:[UIImage imageNamed:@"ic_hook_sel"] forState:UIControlStateNormal];
        self.insuranceService = @"2";
    }
    
    [self calculateTotalPrice];
}

- (void)licenseClick:(UIButton*)btn{
    if(btn.tag == 888){
        [_license1Btn setImage:[UIImage imageNamed:@"ic_hook_sel"] forState:UIControlStateNormal];
        [_license2Btn setImage:[UIImage imageNamed:@"ic_hook_nor"] forState:UIControlStateNormal];
        [_license3Btn setImage:[UIImage imageNamed:@"ic_hook_nor"] forState:UIControlStateNormal];
        self.driverType = @"0";
    }else if(btn.tag == 999){
        [_license1Btn setImage:[UIImage imageNamed:@"ic_hook_nor"] forState:UIControlStateNormal];
        [_license2Btn setImage:[UIImage imageNamed:@"ic_hook_sel"] forState:UIControlStateNormal];
        [_license3Btn setImage:[UIImage imageNamed:@"ic_hook_nor"] forState:UIControlStateNormal];
        self.driverType = @"1";
    }else{
        [_license1Btn setImage:[UIImage imageNamed:@"ic_hook_nor"] forState:UIControlStateNormal];
        [_license2Btn setImage:[UIImage imageNamed:@"ic_hook_nor"] forState:UIControlStateNormal];
        [_license3Btn setImage:[UIImage imageNamed:@"ic_hook_sel"] forState:UIControlStateNormal];
        self.driverCountry = @"Japan";
        self.driverType = @"2";
        
    }
}


-(void)useAll{
    _pointTF.text = [NSString stringWithFormat:@"%d",self.point];
    [self calculateTotalPrice];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES]; // 关闭键盘
}


- (CGFloat)calculateLabelHeight:(UILabel *)label {
    CGSize maxSize = CGSizeMake(label.bounds.size.width, CGFLOAT_MAX);
    
    NSDictionary *attributes = @{NSFontAttributeName: label.font};
    
    CGRect boundingRect = [label.text boundingRectWithSize:maxSize
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:attributes
                                                   context:nil];
    
    CGFloat currentHeight = ceil(boundingRect.size.height);
    
    return currentHeight;
}


- (CGFloat)calculateLabelHeightIncrease:(UILabel *)label {
    CGFloat previousHeight = label.bounds.size.height;
    
    CGSize maxSize = CGSizeMake(label.bounds.size.width, CGFLOAT_MAX);
    
    NSDictionary *attributes = @{NSFontAttributeName: label.font};
    
    CGRect boundingRect = [label.text boundingRectWithSize:maxSize
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:attributes
                                                   context:nil];
    
    CGFloat currentHeight = ceil(boundingRect.size.height);
    CGFloat heightIncrease = (currentHeight > previousHeight) ? (currentHeight - previousHeight) : 0;
    
    return heightIncrease;
}

- (void)checkDateValide:(NSDate *)startDate :(NSDate *)endDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    //    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    //    dateFormatter.dateFormat = @"yyyy-MM-dd HH";
    NSString *startDateStr = [dateFormatter stringFromDate:startDate];
    NSString *endDateStr = [dateFormatter stringFromDate:endDate];
    
    PXWeakSelf
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"carID"] = _carBean.carId;
    dic[@"date"] = startDateStr;
    dic[@"endDate"] = endDateStr;
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/order/checkDateValide" parameters:dic complete:^(id ob) {
        NSInteger num = [weakSelf daysBetweenStartDate:weakSelf.startDate andEndDate:weakSelf.endDate];
        weakSelf.rentDays = num;
        weakSelf.daysLb.text = [NSString stringWithFormat:@"%ld%@", (long)num,MyString(@"day")];
//        [weakSelf calculateTotalPrice];
        [self getPriceByDate:startDate :endDate];
    } fail:^(id ob) {
        NSString *message = MyString(@"car_already_reserved");
        UIView *view = weakSelf.navigationController.view;
        [view makeToast:message];
        weakSelf.startDate = nil;
        weakSelf.startTimeLb.text = MyString(@"select_time");;
        weakSelf.endDate = nil;
        weakSelf.endTimeLb.text = MyString(@"select_time");
        weakSelf.daysLb.text = [NSString stringWithFormat:@"0%@",MyString(@"day")];
    }];
}

- (void)getPriceByDate:(NSDate *)startDate :(NSDate *)endDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    //    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    //    dateFormatter.dateFormat = @"yyyy-MM-dd HH";
    NSString *startDateStr = [dateFormatter stringFromDate:startDate];
    NSString *endDateStr = [dateFormatter stringFromDate:endDate];
    
    PXWeakSelf
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"carId"] = _carBean.carId;
    dic[@"pickCarDate"] = startDateStr;
    dic[@"returnCarDate"] = endDateStr;
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/order/getPriceByDateApi" parameters:dic complete:^(id ob) {
        weakSelf.priceDesc = ob[@"priceDesc"];
        weakSelf.carTotalPrice = ob[@"totalPrice"];
        weakSelf.unitPrice = ob[@"unitPrice"];
        weakSelf.carDayPriceLb.text = weakSelf.unitPrice;
        weakSelf.carTotalPriceLb.text = [NSString stringWithFormat:@" %@",weakSelf.carTotalPrice];
//        [weakSelf priceDescDeal:weakSelf.priceDesc];
//        NSInteger num = [weakSelf daysBetweenStartDate:weakSelf.startDate andEndDate:weakSelf.endDate];
//        weakSelf.rentDays = num;
//        weakSelf.daysLb.text = [NSString stringWithFormat:@"%ld%@", (long)num,MyString(@"day")];
        [weakSelf calculateTotalPrice];
    } fail:^(id ob) {
//        NSString *message = MyString(@"car_already_reserved");
//        UIView *view = weakSelf.navigationController.view;
//        [view makeToast:message];
//        weakSelf.startDate = nil;
//        weakSelf.startTimeLb.text = MyString(@"select_time");;
//        weakSelf.endDate = nil;
//        weakSelf.endTimeLb.text = MyString(@"select_time");
//        weakSelf.daysLb.text = [NSString stringWithFormat:@"0%@",MyString(@"day")];
    }];
}

- (void)getPromotionCodeByCode{
    PXWeakSelf
    NSString *code = _codeTF.text;
    NSCharacterSet *whitespaceSet = [NSCharacterSet whitespaceCharacterSet];
    code = [code stringByTrimmingCharactersInSet:whitespaceSet];
    if(!code){
        return;
    }
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"code"] = code;
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/order/getPromotionCodeByCode" parameters:dic complete:^(id ob) {
        weakSelf.rate = ob[@"rate"];
        [weakSelf calculateTotalPrice];
    } fail:^(id ob) {
        weakSelf.codeTF.text = @"";
        weakSelf.codeSwitch.on = false;
    }];
}

- (void)switchValueChanged:(UISwitch *)sender {
    if (_codeTF.text && sender.isOn) {
        [self getPromotionCodeByCode];
    }else if (_codeTF.text && !sender.isOn) {
        [self calculateTotalPrice];
    }
}

- (void)codeTextFieldDidChange:(UITextField *)textField {
    if (_codeSwitch.isOn) {
        _rate = @"";
        [_codeSwitch setOn:NO];
        [self calculateTotalPrice];
    }
}

- (void)showPopupWithContent{
    NSString *content = _priceDesc;
    if(!content){
        return;
    }
//    NSArray *dataEntries = [content componentsSeparatedByString:@";"];
//    
//    NSMutableString *displayContent = [NSMutableString stringWithString:@""];
//    for (NSString *entry in dataEntries) {
//        NSArray *components = [entry componentsSeparatedByString:@","];
//        if (components.count == 2) {
//            NSString *date = components[0];
//            NSString *price = components[1];
//            [displayContent appendFormat:@"%@  :  %@\n", date, price];
//        }
//    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:MyString(@"price_details") message:_priceDesc preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:MyString(@"confirm") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 点击确定按钮后的操作
    }];
    
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (BOOL)isBefore10AMOrAfter8PM:(NSDate *)selectDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitHour fromDate:selectDate];
    NSInteger hour = [components hour];
    
    if (hour < 10 || hour >= 20) {
        return YES;
    } else {
        return NO;
    }
}
@end


