//
//  UIView+Nib.m
//  MobileProject
//
//  Created by LiuNiu-MacMini-YQ on 16/9/18.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "UIView+Nib.h"

@implementation UIView (Nib)


+ (instancetype)viewFormNib_{
    NSArray *viewArray = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                                       owner:self
                                                     options:nil];
    return viewArray.lastObject;
}

+ (UIImage *)snapshot:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size,YES,0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
