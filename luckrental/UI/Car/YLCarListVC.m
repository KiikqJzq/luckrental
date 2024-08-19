//
//  YLCarListVC.m
//  luckrental
//
//  Created by kiikqjzq on 2023/9/18.
//

#import "YLCarListVC.h"
#import "YLCarBean.h"
#import "YLCarListCell.h"
#import "YLCarInfoVC.h"
@interface YLCarListVC ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *carTabV;
@property(nonatomic,strong)NSMutableArray *carArray;
@property (weak, nonatomic) IBOutlet UILabel *searchLb;
@property (weak, nonatomic) IBOutlet UITextField *searchTF;
@property (weak, nonatomic) IBOutlet UIView *filter1V;
@property (weak, nonatomic) IBOutlet UILabel *filter1Lb;
@property (weak, nonatomic) IBOutlet UIView *filter2V;
@property (weak, nonatomic) IBOutlet UILabel *filter2Lb;
@property (weak, nonatomic) IBOutlet UIView *filter3V;
@property (weak, nonatomic) IBOutlet UILabel *filter3Lb;
@property (strong, nonatomic) UIPickerView *filterPicker;
@property (strong, nonatomic) UIToolbar *toolbar;
@property (strong, nonatomic) NSMutableArray *brandArray;
@property (strong, nonatomic) NSMutableArray *categoryArray;
@property (strong, nonatomic) NSArray *seatsArray;
@property (strong, nonatomic) NSString *brand;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *seats;
@end

@implementation YLCarListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = MyString(@"popular_vehicles");
    self.searchLb.text = MyString(@"search");
    self.searchTF.placeholder = MyString(@"enter");
    self.filter1Lb.text = MyString(@"search");
    self.filter2Lb.text = MyString(@"search");
    self.filter3Lb.text = MyString(@"search");
    
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicker:)];
    self.filter1V.userInteractionEnabled = YES;
    self.filter1V.tag = 111;
    [self.filter1V addGestureRecognizer:tapGesture1];
    
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicker:)];
    self.filter2V.userInteractionEnabled = YES;
    self.filter2V.tag = 222;
    [self.filter2V addGestureRecognizer:tapGesture2];
    
    UITapGestureRecognizer *tapGesture3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicker:)];
    self.filter3V.userInteractionEnabled = YES;
    self.filter3V.tag = 333;
    [self.filter3V addGestureRecognizer:tapGesture3];
    
    UITapGestureRecognizer *tapGesture4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getData)];
    self.searchLb.userInteractionEnabled = YES;
    [self.searchLb addGestureRecognizer:tapGesture4];
    self.seatsArray = @[MyString(@"all"),@"2",@"4",@"5",@"6",@"7"];
    
    self.filter1Lb.text = MyString(@"brand");
    self.filter2Lb.text = MyString(@"model");
    self.filter3Lb.text = MyString(@"seats");
}

- (void)initUI{
    [_carTabV registerNib:[UINib nibWithNibName:@"YLCarListCell" bundle:nil] forCellReuseIdentifier:@"YLCarListCell"];
    _carTabV.delegate = self;
    _carTabV.dataSource = self;
    _carTabV.separatorStyle = UITableViewCellSeparatorStyleNone;
    _carTabV.showsVerticalScrollIndicator = NO;
    _carTabV.tag = 111;
}

- (void)getData{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"brand"] = self.brand;
    dic[@"category"] = self.category;
    dic[@"seats"] = self.seats;
    dic[@"carTitle"] = self.searchTF.text;
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/car/getCarByFilter" parameters:dic complete:^(id ob) {
        self.carArray = [YLCarBean mj_objectArrayWithKeyValuesArray:ob];
        [self.carTabV reloadData];
    }];

    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/car/getCarCategoryList" parameters:nil complete:^(id ob) {
        self.categoryArray = [NSString mj_objectArrayWithKeyValuesArray:ob];
        [self.categoryArray insertObject:MyString(@"all") atIndex:0];
    }];
    
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:@"/api/car/getCarBrandList" parameters:nil complete:^(id ob) {
        self.brandArray = [NSString mj_objectArrayWithKeyValuesArray:ob];
        [self.brandArray insertObject:MyString(@"all") atIndex:0];
    }];
}


#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.carArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 125;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"YLCarListCell";
    YLCarBean *bean = _carArray[indexPath.row];
    YLCarListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer forIndexPath:indexPath];
    [cell initWithDate:bean];
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YLCarBean *bean = _carArray[indexPath.row];
    YLCarInfoVC *vc = [YLCarInfoVC new];
    vc.carId = bean.carId;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}


-(void)showPicker:(UITapGestureRecognizer *)tap{
    // 创建PickerView
    self.filterPicker = [UIPickerView new];
    if(tap.view.tag == 111){
        self.filterPicker.tag = 1111;
    }else if(tap.view.tag == 222){
        self.filterPicker.tag = 2222;
    }else{
        self.filterPicker.tag = 3333;
    }

    self.filterPicker.backgroundColor = UIColor.whiteColor;
    self.filterPicker.delegate = self;
    self.filterPicker.dataSource = self;
    // 创建Toolbar
    _toolbar = [UIToolbar new];
    _toolbar.backgroundColor = UIColor.whiteColor;
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:MyString(@"cancel") style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonTapped:)];
    if(tap.view.tag == 111){
        cancelButton.tag = 1111;
    }else if(tap.view.tag == 222){
        cancelButton.tag = 2222;
    }else{
        cancelButton.tag = 3333;
    }

    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:MyString(@"confirm") style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonTapped:)];
    if(tap.view.tag == 111){
        doneButton.tag = 1111;
    }else if(tap.view.tag == 222){
        doneButton.tag = 2222;
    }else{
        doneButton.tag = 3333;
    }
    _toolbar.items = @[cancelButton, flexibleSpace, doneButton];
    
    // 将PickerView和Toolbar添加到视图中
    [self.view addSubview:self.filterPicker];
    [self.view addSubview:_toolbar];
    [self.filterPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(@200);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    [_toolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(@44);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.filterPicker.mas_top);
    }];
    
}

#pragma mark - UIPickerViewDelegate and UIPickerViewDataSource methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1; // 选择1列
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(pickerView.tag == 1111){
        return _brandArray.count;
    }else if(pickerView.tag == 2222){
        return _categoryArray.count;
    }else{
        return _seatsArray.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(pickerView.tag == 1111){
        return self.brandArray[row];
    }else if(pickerView.tag == 2222){
        return self.categoryArray[row];
    }else{
        return self.seatsArray[row];
    }
}

#pragma mark - Button actions

- (void)cancelButtonTapped:(UIView *)view {
    [self.filterPicker removeFromSuperview];
    [self.toolbar removeFromSuperview];
}

- (void)doneButtonTapped:(UIView *)view {
    NSInteger selectedRow = [self.filterPicker selectedRowInComponent:0];
    // 处理完成按钮点击事件
    if(view.tag == 1111){
        NSString *selectedmerchant = self.brandArray[selectedRow];
        self.filter1Lb.text = selectedmerchant;
        if([selectedmerchant isEqualToString:MyString(@"all")]){
            self.brand = @"";
        }else{
            self.brand = selectedmerchant;
        }
    }else if(view.tag == 2222){
        NSString *selectedmerchant = self.categoryArray[selectedRow];
        self.filter2Lb.text = selectedmerchant;
        if([selectedmerchant isEqualToString:MyString(@"all")]){
            self.category = @"";
        }else{
            self.category = selectedmerchant;
        }
    }else{
        NSString *selectedmerchant = self.seatsArray[selectedRow];
        self.filter3Lb.text = selectedmerchant;
        if([selectedmerchant isEqualToString:MyString(@"all")]){
            self.seats = @"";
        }else{
            self.seats = selectedmerchant;
        }
    }
    [self.filterPicker removeFromSuperview];
    [self.toolbar removeFromSuperview];
    [self getData];
}

@end
