//
//  YLFeedbackVC.m
//  luckrental
//
//  Created by kiikqjzq on 2023/9/15.
//

#import "YLFeedbackVC.h"

@interface YLFeedbackVC ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextView *contentTV;
@property (weak, nonatomic) IBOutlet UIButton *summitBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *emailTitleLb;
@property (weak, nonatomic) IBOutlet UILabel *contentTitleLb;

@end

@implementation YLFeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = MyString(@"feedback");
    [_summitBtn setTitle:MyString(@"submit") forState:UIControlStateNormal];
    [_summitBtn addTarget:self action:@selector(summit) forControlEvents:UIControlEventTouchUpInside];
    _nameTitleLb.text =  MyString(@"your_name");
    _nameTF.placeholder = MyString(@"enter_name");
    _emailTitleLb.text =  MyString(@"your_email");
    _emailTF.placeholder = MyString(@"enter_email");
    _contentTitleLb.text =  MyString(@"feedback_content");
    
}

-(void)summit{
    PXWeakSelf
    NSString *name = _nameTF.text;
    NSString *email = _emailTF.text;
    NSString *content = _contentTV.text;
    
    if(!name || name.length==0){
        [self.view makeToast:MyString(@"enter_name")];
        return;
    }
    
    if(!email || email.length==0){
        [self.view makeToast:MyString(@"enter_email")];
        return;
    }
    
    if(!content || content.length==0){
        [self.view makeToast:MyString(@"enter_feedback")];
        return;
    }

    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"feedbackName"] = name;
    dic[@"feedbackEmail"] = email;
    dic[@"feedbackContent"] = content;
    
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodPost URLString:@"/api/feedback/save" parameters:dic complete:^(id ob) {
        [weakSelf showCompletionAlert];
    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)showCompletionAlert {
    PXWeakSelf
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:MyString(@"submission_complete")
                                                                             message:MyString(@"thank_you_for_feedback")
                                                                      preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:MyString(@"confirm")
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
                                                     }];

    [alertController addAction:okAction];

    [self presentViewController:alertController animated:YES completion:nil];
}


@end
