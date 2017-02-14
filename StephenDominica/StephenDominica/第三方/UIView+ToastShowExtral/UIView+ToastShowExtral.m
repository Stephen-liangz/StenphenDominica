//
//  UIView+ViewExtral.m
//  WorkLogger
//
//  Created by yjj on 14-5-17.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "UIView+ToastShowExtral.h"
#import "ToastManager.h"

@implementation UIView (ToastShowExtral)

- (void)showMessage:(NSString *)message centerPostion:(CGPoint)centerPostion{
    [UIView showMessage:message centerPostion:centerPostion showView:self];
}

+ (void)showMessage:(NSString *)message position:(int)position showView:(UIView *)showView{
    ToastManager *toast = [ToastManager toastManager];
    toast.settings.toastDefaultDuration = ViewToastDefaultDuration;
    toast.settings.toastDefaultPosition = position;
    UIView *showInView = showView;
    if(!showInView){
        showInView = [[[[UIApplication sharedApplication] delegate] window] rootViewController].view;
    }
    toast.showInView = showInView;
    [toast makeToast:message];
}

+ (void)showMessage:(NSString *)message centerPostion:(CGPoint)centerPostion showView:(UIView *)showView{
    ToastManager *toast = [ToastManager toastManager];
    toast.showInView = showView;
    [toast makeToast:message duration:ViewToastDefaultDuration centerPoint:centerPostion];
}

- (void)showMessage:(NSString *)message{
    [UIView showMessage:message position:Toast_Position_Center showView:self];
}

- (void)showBottomMessage:(NSString *)message{
    [UIView showMessage:message position:Toast_Position_Bottom showView:self];
}

- (void)showTopMessage:(NSString *)message{
    [UIView showMessage:message position:Toast_Position_Top showView:self];
}

+ (void)showMessage:(NSString *)message{
    [self showMessage:message position:Toast_Position_Center showView:nil];
}

+ (void)showMessage:(NSString *)message centerPostion:(CGPoint)centerPostion{
    [self showMessage:message centerPostion:centerPostion showView:nil];
}

@end

