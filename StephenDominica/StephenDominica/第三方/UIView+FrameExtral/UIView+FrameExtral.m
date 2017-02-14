//
//  UIView+ViewExtral.m
//  WorkLogger
//
//  Created by yjj on 14-5-17.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "UIView+FrameExtral.h"
#import "CGRectHelper.h"

@implementation UIView (FramePropertyExtral)
- (CGFloat)top{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)aTop{
    [self rectChangeWithY:aTop];
}

- (CGFloat)left{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)aLeft{
    [self rectChangeWithX:aLeft];
}

- (CGFloat)right{
    return [self rectRight];
}

- (void)setRight:(CGFloat)aRight{
    [self rectChangeWithRight:aRight];
}

- (CGFloat)bottom{
    return [self rectBottom];
}

- (void)setBottom:(CGFloat)aBottom{
    [self rectChangeWithBottom:aBottom];
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)aWidth{
    [self rectChangeWithWidth:aWidth];
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)aHeight{
    [self rectChangeWithHeight:aHeight];
}

- (CGPoint)origin{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin{
    [self rectChangeWithPoint:origin];
}

- (CGSize)size{
    return self.frame.size;
}

- (void)setSize:(CGSize)size{
    [self rectChangeWithSize:size];
}

- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX{
    self.center = CGPointMake(centerX, self.centerY);
}

- (CGFloat)centerY{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY{
    self.center = CGPointMake(self.centerX, centerY);
}

- (CGPoint)boundsCenter{
    return CGPointMake(self.width * .5f, self.height * .5f);
}

- (void)setFrameWithBlock:(CGRect (^)(CGRect frame))frameBlock{
    if(frameBlock){
        CGRect aFrame = frameBlock(self.frame);
        self.frame = aFrame;
    }
}
@end

@implementation UIView (AutoresizingFlexible)

- (void)autoresizingFlexibleWithLeftMargin:(BOOL)leftMargin width:(BOOL)width rightMargin:(BOOL)rightMargin topMargin:(BOOL)topMargin height:(BOOL)height bottomMargin:(BOOL)bottomMargin{
    UIViewAutoresizing mask = UIViewAutoresizingNone;
    if(leftMargin){
        mask |= UIViewAutoresizingFlexibleLeftMargin;
    }
    if(width){
        mask |= UIViewAutoresizingFlexibleWidth;
    }
    if(rightMargin){
        mask |= UIViewAutoresizingFlexibleRightMargin;
    }
    if(topMargin){
        mask |= UIViewAutoresizingFlexibleTopMargin;
    }
    if(height){
        mask |= UIViewAutoresizingFlexibleHeight;
    }
    if(bottomMargin){
        mask |= UIViewAutoresizingFlexibleBottomMargin;
    }
    [self setAutoresizingMask:mask];
}

- (void)autoresizingFlexibleAll{
    [self setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | \
     UIViewAutoresizingFlexibleWidth        |\
     UIViewAutoresizingFlexibleRightMargin  |\
     UIViewAutoresizingFlexibleTopMargin    |\
     UIViewAutoresizingFlexibleHeight       |\
     UIViewAutoresizingFlexibleBottomMargin];
}

- (void)autoresizingFlexibleNone{
    [self setAutoresizingMask:UIViewAutoresizingNone];
}

- (void)autoresizingFlexibleLeftMarginAndTopMargin{
    [self autoresizingFlexibleWithLeftMargin:YES width:NO rightMargin:NO topMargin:YES height:NO bottomMargin:NO];
}

- (void)autoresizingFlexibleTopMarginAndRightMargin{
    [self autoresizingFlexibleWithLeftMargin:NO width:NO rightMargin:YES topMargin:YES height:NO bottomMargin:NO];
}

- (void)autoresizingFlexibleLeftMarginAndBottomMargin{
    [self autoresizingFlexibleWithLeftMargin:YES width:NO rightMargin:NO topMargin:NO height:NO bottomMargin:YES];
}

- (void)autoresizingFlexibleRightMarginAndBottomMargin{
    [self autoresizingFlexibleWithLeftMargin:NO width:NO rightMargin:YES topMargin:NO height:NO bottomMargin:YES];
}


- (void)autoresizingFlexibleAddLeftMargin{
    [self setAutoresizingMask:(self.autoresizingMask | UIViewAutoresizingFlexibleLeftMargin)];
}

- (void)autoresizingFlexibleAddWidth{
    [self setAutoresizingMask:(self.autoresizingMask | UIViewAutoresizingFlexibleWidth)];
}

- (void)autoresizingFlexibleAddRightMargin{
    [self setAutoresizingMask:(self.autoresizingMask | UIViewAutoresizingFlexibleRightMargin)];
}

- (void)autoresizingFlexibleAddTopMargin{
    [self setAutoresizingMask:(self.autoresizingMask | UIViewAutoresizingFlexibleTopMargin)];
}

- (void)autoresizingFlexibleAddHeight{
    [self setAutoresizingMask:(self.autoresizingMask | UIViewAutoresizingFlexibleHeight)];
}

- (void)autoresizingFlexibleAddBottomMargin{
    [self setAutoresizingMask:(self.autoresizingMask | UIViewAutoresizingFlexibleBottomMargin)];
}

@end

@implementation UIView (CGRectHelper)
- (void)rectChangeWithDx:(CGFloat)dx{
    [self setFrame:[CGRectHelper rectChange:self.frame withDx:dx]];
}

- (void)rectChangeWithDy:(CGFloat)dy{
    [self setFrame:[CGRectHelper rectChange:self.frame withDy:dy]];
}

- (void)rectChangeWithDWidth:(CGFloat)dWidth{
    [self setFrame:[CGRectHelper rectChange:self.frame withDWidth:dWidth]];
}

- (void)rectChangeWithDHeight:(CGFloat)dHeight{
    [self setFrame:[CGRectHelper rectChange:self.frame withDHeight:dHeight]];
}

- (void)rectChangeWithDx:(CGFloat)dx dWidth:(CGFloat)dWidth{
    [self setFrame:[CGRectHelper rectChange:self.frame withDx:dx dWidth:dWidth]];
}

- (void)rectChangeWithDy:(CGFloat)dy dHeight:(CGFloat)dHeight{
    [self setFrame:[CGRectHelper rectChange:self.frame withDy:dy dHeight:dHeight]];
}

- (void)rectChangeWithDxAndDWidth:(CGFloat)dValue{
    [self setFrame:[CGRectHelper rectChange:self.frame withDxAndDWidth:dValue]];
}

- (void)rectChangeWithDyAndDHeight:(CGFloat)dValue{
    [self setFrame:[CGRectHelper rectChange:self.frame withDyAndDHeight:dValue]];
}
- (void)rectChangeWithX:(CGFloat)x{
    [self setFrame:[CGRectHelper rectChange:self.frame withX:x]];
}

- (void)rectChangeWithY:(CGFloat)y{
    [self setFrame:[CGRectHelper rectChange:self.frame withY:y]];
}

- (void)rectChangeWithWidth:(CGFloat)width{
    [self setFrame:[CGRectHelper rectChange:self.frame withWidth:width]];
}

- (void)rectChangeWithHeight:(CGFloat)height{
    [self setFrame:[CGRectHelper rectChange:self.frame withHeight:height]];
}

- (void)rectChangeWithX:(CGFloat)x width:(CGFloat)width{
    [self setFrame:[CGRectHelper rectChange:self.frame withX:x width:width]];
}

- (void)rectChangeWithY:(CGFloat)y height:(CGFloat)height{
    [self setFrame:[CGRectHelper rectChange:self.frame withY:y height:height]];
}

- (void)rectChangeWithPoint:(CGPoint)point{
    [self setFrame:[CGRectHelper rectChange:self.frame withPoint:point]];
}

- (void)rectChangeWithSize:(CGSize)size{
    [self setFrame:[CGRectHelper rectChange:self.frame withSize:size]];
}

- (void)rectWithPoint:(CGPoint)point size:(CGSize)size{
    [self setFrame:[CGRectHelper rectWithPoint:point size:size]];
}

- (void)rectChangeWithCenterPoint:(CGPoint)point{
    [self setFrame:[CGRectHelper rectChange:self.frame withCenterPoint:point]];
}

- (void)rectChangeWithDx:(CGFloat)dx dy:(CGFloat)dy dWidth:(CGFloat)dWidth dHeight:(CGFloat)dHeight{
    [self setFrame:[CGRectHelper rectChange:self.frame withDx:dx dy:dy dWidth:dWidth dHeight:dHeight]];
}

- (void)rectWithFitSize:(CGSize)fitSize maxSize:(CGSize)size{
    [self setFrame:[CGRectHelper rectWithFitSize:fitSize maxSize:size]];
}

- (void)rectChangeWithBottom:(CGFloat)bottom{
    [self setFrame:[CGRectHelper rectChange:self.frame withBottom:bottom]];
}

- (void)rectChangeWithRight:(CGFloat)right{
    [self setFrame:[CGRectHelper rectChange:self.frame withRight:right]];
}

- (CGFloat)rectTop{
    return self.frame.origin.y;
}

- (CGFloat)rectLeft{
    return self.frame.origin.x;
}

- (CGFloat)rectBottom{
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)rectRight{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGSize)rectSize{
    return self.frame.size;
}

- (CGPoint)rectOrigin{
    return self.frame.origin;
}

- (CGFloat)rectX{
    return self.frame.origin.x;
}

- (CGFloat)rectY{
    return self.frame.origin.y;
}
- (CGFloat)rectWidth{
    return self.frame.size.width;
}

- (CGFloat)rectHeight{
    return self.frame.size.height;
}

+ (CGRect)fitFrameWithNavigationController:(UINavigationController *)naviVC{
    CGRect fitFrame = [[UIScreen mainScreen] bounds];
    
    __weak UIApplication *app = [UIApplication sharedApplication];
    CGFloat height;
    
    ///状态栏
    if(![app isStatusBarHidden]){
        height = [app statusBarFrame].size.height;
//        fitFrame.origin.y = height;
        fitFrame.size.height -= height;
    }
    
    ///导航栏
    if(naviVC){
        if(naviVC.navigationBar && ![naviVC.navigationBar isHidden] && ![naviVC.navigationBar isTranslucent]){
            CGFloat height = [naviVC.navigationBar frame].size.height;
//            fitFrame.origin.y += height;
            fitFrame.size.height -= height;
        }
    }
    
    ///没有算工具栏 toolBar
    return fitFrame;
}
@end

@implementation UIViewController (UIViewControllerExtral)
- (void)fitViewFrame{
    [self.view setFrame:[UIView fitFrameWithNavigationController:self.navigationController]];
}
@end
