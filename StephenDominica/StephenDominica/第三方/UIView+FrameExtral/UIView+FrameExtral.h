//
//  UIView+ViewExtral.h
//  WorkLogger
//
//  Created by yjj on 14-5-17.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef __UIView_FrameExtral__
    #define __UIView_FrameExtral__
#endif

@interface UIView (FramePropertyExtral)
@property (nonatomic,readwrite) CGFloat top;
@property (nonatomic,readwrite) CGFloat left;
@property (nonatomic,readwrite) CGFloat right;
@property (nonatomic,readwrite) CGFloat bottom;
@property (nonatomic,readwrite) CGFloat width;
@property (nonatomic,readwrite) CGFloat height;
@property (nonatomic,readwrite) CGPoint origin;
@property (nonatomic,readwrite) CGSize size;
@property (nonatomic,readwrite) CGFloat centerX;
@property (nonatomic,readwrite) CGFloat centerY;
@property (nonatomic,readonly) CGPoint boundsCenter;

///有时需要及时多个值,不宜一个一个设置,没有一次设置高效
- (void)setFrameWithBlock:(CGRect (^)(CGRect frame))frameBlock;
@end

@interface UIView (AutoresizingFlexible)
///根据每一项设置
- (void)autoresizingFlexibleWithLeftMargin:(BOOL)leftMargin width:(BOOL)width rightMargin:(BOOL)rightMargin topMargin:(BOOL)topMargin height:(BOOL)height bottomMargin:(BOOL)bottomMargin;
///设置全部autosize mask
- (void)autoresizingFlexibleAll;
- (void)autoresizingFlexibleNone;

- (void)autoresizingFlexibleLeftMarginAndTopMargin;
- (void)autoresizingFlexibleTopMarginAndRightMargin;
- (void)autoresizingFlexibleLeftMarginAndBottomMargin;
- (void)autoresizingFlexibleRightMarginAndBottomMargin;

- (void)autoresizingFlexibleAddLeftMargin;
- (void)autoresizingFlexibleAddWidth;
- (void)autoresizingFlexibleAddRightMargin;
- (void)autoresizingFlexibleAddTopMargin;
- (void)autoresizingFlexibleAddHeight;
- (void)autoresizingFlexibleAddBottomMargin;
@end

@interface UIView (CGRectHelper)

- (void)rectChangeWithDx:(CGFloat)dx;
- (void)rectChangeWithDy:(CGFloat)dy;
- (void)rectChangeWithDWidth:(CGFloat)dWidth;
- (void)rectChangeWithDHeight:(CGFloat)dHeight;
- (void)rectChangeWithDx:(CGFloat)dx dWidth:(CGFloat)dWidth;
- (void)rectChangeWithDy:(CGFloat)dy dHeight:(CGFloat)dHeight;

- (void)rectChangeWithDxAndDWidth:(CGFloat)dValue;
- (void)rectChangeWithDyAndDHeight:(CGFloat)dValue;

- (void)rectChangeWithX:(CGFloat)x;
- (void)rectChangeWithY:(CGFloat)y;
- (void)rectChangeWithWidth:(CGFloat)width;
- (void)rectChangeWithHeight:(CGFloat)height;
- (void)rectChangeWithX:(CGFloat)x width:(CGFloat)width;
- (void)rectChangeWithY:(CGFloat)y height:(CGFloat)height;

- (void)rectChangeWithPoint:(CGPoint)point;
- (void)rectChangeWithSize:(CGSize)size;
- (void)rectWithPoint:(CGPoint)point size:(CGSize)size;

- (void)rectChangeWithCenterPoint:(CGPoint)point;

- (void)rectChangeWithDx:(CGFloat)dx dy:(CGFloat)dy dWidth:(CGFloat)dWidth dHeight:(CGFloat)dHeight;

- (void)rectWithFitSize:(CGSize)fitSize maxSize:(CGSize)size;

- (void)rectChangeWithBottom:(CGFloat)bottom;
- (void)rectChangeWithRight:(CGFloat)right;

- (CGFloat)rectTop;
- (CGFloat)rectLeft;
- (CGFloat)rectBottom;
- (CGFloat)rectRight;

- (CGSize)rectSize;
- (CGPoint)rectOrigin;
- (CGFloat)rectX;
- (CGFloat)rectY;
- (CGFloat)rectWidth;
- (CGFloat)rectHeight;

+ (CGRect)fitFrameWithNavigationController:(UINavigationController *)naviVC;
@end

@interface UIViewController (UIViewControllerExtral)
- (void)fitViewFrame;
@end
