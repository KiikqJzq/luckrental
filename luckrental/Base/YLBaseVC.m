//
//  YLBaseVC.m
//  luckrental
//
//  Created by kiikqjzq on 2023/9/14.
//

#import "YLBaseVC.h"

@interface YLBaseVC ()<UIGestureRecognizerDelegate>
@property (nonatomic, assign)bool autoRefresh;
@end

@implementation YLBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self getData];
}

- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initUI{

}

- (void)getData{

}

- (void)viewWillAppear:(BOOL)animated{
    if(!self.autoRefresh){
        self.autoRefresh = YES;
        return;
    }
    [self getData];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end
