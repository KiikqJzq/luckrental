//
//  YLQuestionInfoVC.h
//  luckrental
//
//  Created by kiikqjzq on 2024/8/12.
//

#import "YLBaseVC.h"
#import <WebKit/WebKit.h>
#import "YLQuestionBean.h"
NS_ASSUME_NONNULL_BEGIN

@interface YLQuestionInfoVC : YLBaseVC<WKNavigationDelegate>
@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property(nonatomic,strong)NSString *qid;
@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)YLQuestionBean *bean;

@end

NS_ASSUME_NONNULL_END
