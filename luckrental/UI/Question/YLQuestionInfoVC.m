//
//  YLQuestionInfoVC.m
//  luckrental
//
//  Created by kiikqjzq on 2024/8/12.
//

#import "YLQuestionInfoVC.h"

@interface YLQuestionInfoVC ()

@end

@implementation YLQuestionInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleStr;

    self.webView.navigationDelegate = self;
}


- (void)getData{
    PXWeakSelf
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"id"] = self.qid;
    NSString *url = [NSString stringWithFormat:@"/api/question/getQuestionByID"];
    [YLHTTPUtility requestWithHTTPMethod:HTTPMethodGet URLString:url parameters:dic complete:^(id ob) {
        weakSelf.bean = [YLQuestionBean mj_objectWithKeyValues:ob];
        [weakSelf.webView loadHTMLString:weakSelf.bean.content baseURL:nil];
//        weakSelf.webView loadHTMLString:weakSelf.bean.con baseURL:nil];
    }];

}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    // Implement if needed
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    // Implement if needed
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    // Implement if needed
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:NO];

}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

@end
