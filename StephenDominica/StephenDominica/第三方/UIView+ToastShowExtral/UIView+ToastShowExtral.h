//
//  UIView+ViewExtral.h
//  WorkLogger
//
//  Created by yjj on 14-5-17.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef __UIView_ToastShowExtral__
    #define __UIView_ToastShowExtral__
#endif

#ifndef ViewToastDefaultDuration
    #define ViewToastDefaultDuration 1.5//per sencond
#endif

@interface UIView (ToastShowExtral)

- (void)showMessage:(NSString *)message centerPostion:(CGPoint)centerPostion;
- (void)showMessage:(NSString *)message;
- (void)showBottomMessage:(NSString *)message;
- (void)showTopMessage:(NSString *)message;

+ (void)showMessage:(NSString *)message;
+ (void)showMessage:(NSString *)message centerPostion:(CGPoint)centerPostion;

///position - Toast_Position
+ (void)showMessage:(NSString *)message position:(int)position showView:(UIView *)showView;
+ (void)showMessage:(NSString *)message centerPostion:(CGPoint)centerPostion showView:(UIView *)showView;

@end

