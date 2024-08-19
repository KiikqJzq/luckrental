//
//  UIView+Additions.h
//
//

//  Copyright (c)
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


static inline CGRect CGRectAddX(CGRect rect,CGFloat x)
{
    rect.origin.x=rect.origin.x+x;
    return rect;
}

static inline CGRect CGRectAddY(CGRect rect,CGFloat y)
{
    rect.origin.y=rect.origin.y+y;
    return rect;
}

static inline CGRect CGRectAddWidth(CGRect rect,CGFloat width)
{
    rect.size.width=rect.size.width+width;
    return rect;
}

static inline CGRect CGRectAddHeight(CGRect rect,CGFloat height)
{
    rect.size.height=rect.size.height+height;
    return rect;
}

static inline CGRect CGRectMakePlus(float x4,float x5,float y4,float y5,float width4,float width5,float height4,float height5)
{
    if ([UIScreen mainScreen].bounds.size.height>480) {
        return CGRectMake(x5, y5, width5, height5);
    }else{
        return CGRectMake(x4, y4, width4, height4);
    }
}

static inline CGRect CGRectMakePlusH(float x,float y,float width,float height4,float height5)
{
    return CGRectMakePlus(x, x, y, y, width, width, height4, height5);
}

static inline CGRect CGRectMakePlusW(float x,float y,float width4,float width5,float height)
{
    return CGRectMakePlus(x, x, y, y, width4, width5, height, height);
}

static inline CGRect CGRectMakePlusX(float x4,float x5,float y,float width,float height)
{
    return CGRectMakePlus(x4, x5, y, y, width, width, height, height);
}

static inline CGRect CGRectMakePlusY(float x,float y4,float y5,float width,float height)
{
    return CGRectMakePlus(x,x , y4, y5, width, width, height, height);
}

static inline CGRect CGRectMakePlusOrigin(float x4,float x5,float y4,float y5,float width,float height)
{
    return CGRectMakePlus(x4, x5, y4, y5, width, width, height, height);
}

static inline CGRect CGRectMakePlusSize(float x,float y,float width4,float width5,float height4,float height5)
{
    return CGRectMakePlus(x, x, y, y, width4, width5, height4, height5);
}

/**
 获取一个CGRect中指定大小的CGSize时候Center时所处的位置
 
 @param rect 要计算的原始大小
 @param size 要占位的大小
 */
static inline CGRect CGRectCenter(CGRect rect,CGSize size)
{
    return CGRectMake((rect.size.width-size.width)/2, (rect.size.height-size.height)/2, size.width, size.height);
}


@interface UIView (Geometry)
/**
 * view.top
 */
@property (nonatomic, assign) CGFloat top;
/**
 * view.bottom
 */
@property (nonatomic, assign) CGFloat bottom;
/**
 * view.left
 */
@property (nonatomic, assign) CGFloat left;
/**
 * view.right
 */
@property (nonatomic, assign) CGFloat right;
/**
 * view.center.x
 */
@property (nonatomic, assign) CGFloat centerX;
/**
 * view.center.y
 */
@property (nonatomic, assign) CGFloat centerY;


-(CGFloat)height;
-(void)setHeight:(CGFloat)height;
-(void)setHeight:(CGFloat)height Animated:(BOOL)animate;
-(void)addHeight:(CGFloat)height;


-(CGFloat)width;
-(void)setWidth:(CGFloat)width;
-(void)setWidth:(CGFloat)width Animated:(BOOL)animate;
-(void)addWidth:(CGFloat)width;

-(CGFloat)originX;
-(void)setOriginX:(CGFloat)x ;
-(void)setOriginX:(CGFloat)x Animated:(BOOL)animate;
-(void)addOriginX:(CGFloat)x;

-(CGFloat)originY;
-(void)setOriginY:(CGFloat)y;
-(void)setOriginY:(CGFloat)y Animated:(BOOL)animate;
-(void)addOriginY:(CGFloat)y;

-(CGSize)size;
-(void)setSize:(CGSize)size;
-(void)setSize:(CGSize)size Animated:(BOOL)animate;

-(CGPoint)origin;
-(void)setOrigin:(CGPoint)point;
-(void)setOrigin:(CGPoint)point Animated:(BOOL)animate;


-(CGRect)rectForAddViewTop:(CGFloat)height;//返回在该view上面添加一个视图时的frame
-(CGRect)rectForAddViewTop:(CGFloat)height Offset:(CGFloat)offset;//返回在该view上面添加一个视图时的frame

-(CGRect)rectForAddViewBottom:(CGFloat)height;//返回在该view下面添加一个视图的时候的frame
-(CGRect)rectForAddViewBottom:(CGFloat)height Offset:(CGFloat)offset;//返回在该view下面添加一个视图的时候的frame
-(CGRect)rectForAddViewLeft:(CGFloat)width;//返回在该view左边添加一个视图的时候的frame
-(CGRect)rectForAddViewLeft:(CGFloat)width Offset:(CGFloat)offset;//返回在该view左边添加一个视图的时候的frame
-(CGRect)rectForAddViewRight:(CGFloat)width;//返回在该view右边添加一个视图的时候的frame
-(CGRect)rectForAddViewRight:(CGFloat)width Offset:(CGFloat)offset;//返回在该view右边添加一个视图的时候的frame

/**
 元素的右上角的点
 */
-(CGPoint)originTopRight;
/**
 元素的左下角的点
 */
-(CGPoint)originBottomLeft;
/**
 元素的右下角的点
 */
-(CGPoint)originBottomRight;

-(CGRect)rectForCenterofSize:(CGSize)size;//居中一个size
/*
 返回该类中所有指定类型的subview
 */
-(NSArray*)subviewsWithClass:(Class )cls;

/**
 取消子视图中UIAsyncImageView与UIAsyncImageButton的图片下载请求
 此方法不会遍历子视图的视图，只会进行一次遍历
 */
-(void)cancelSubviewImageDownload;

/**
 取消所有子视图的异步图片下载
 */
+(void)cancelSubviewImageDownloadinView:(UIView*)view;

/**
 同viewWithTag:(int)tag
 
 此函数返回id类型，以不用强制转换类型
 */
-(id)viewWithTag2:(int)tag;


@end



@interface UIView (ViewHiarachy)

/**
 * 获取当前view最近的uiviewcontroller。
 */
@property (nonatomic, readonly) UIViewController *viewController;
/**
 * 移除所有子视图。
 */
- (void)removeAllSubviews;

@end


@interface UIView (Gesture)

/**
 * 在当前视图上添加点击事件。
 */

// TODO DINGLi Deprecated
- (void)addTapAction:(SEL)tapAction target:(id)target;

@end

@interface UIView (firstResponder)

- (UIView *)findViewThatIsFirstResponder;
- (NSArray *)descendantViews;

@end

@interface UIView (autoLayout)

- (void)testAmbiguity;

@end

@interface UIView (DDFramework)
- (void)cutCorners;
- (void)cutCornersWithRadius:(CGFloat)radius;
@end
