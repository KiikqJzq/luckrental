//
//  YLprotocolV.m
//  luckrental
//
//  Created by kiikqjzq on 2023/10/6.
//

#import "YLprotocolV.h"
#import "UIView+Additions.h"


@interface YLprotocolV()
@property (weak, nonatomic) IBOutlet UIView *bgV;
@property (weak, nonatomic) IBOutlet UIView *contentV;
@property (weak, nonatomic) IBOutlet UILabel *agreeLb;
@property (weak, nonatomic) IBOutlet UILabel *refuseLb;
@end
@implementation YLprotocolV



- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (void)show{
    
    self.bgV.userInteractionEnabled = YES;
    [self.bgV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)]];
    
    
    self.agreeLb.userInteractionEnabled = YES;
    [self.agreeLb addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(agree)]];
    
    self.refuseLb.userInteractionEnabled = YES;
    [self.refuseLb addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(refuse)]];
    
    [self.superVc.view addSubview:self];

    [UIView animateWithDuration:0.5 animations:^{
        self.bgV.alpha = 0.5;
        self.contentV.top = 100;
    }];
}

- (void)agree{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"1" forKey:@"isAgree"];
    [defaults synchronize];
    [self close];
}

- (void)refuse{
    [self close];
}


- (void)close{
    [UIView animateWithDuration:0.3 animations:^{
        self.bgV.alpha = 0.0;
        self.contentV.top = self.height;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
