//
//  ToastManager.h
//  ToastDemo
//
//  Created by YiJianJun on 14-7-24.
//  Copyright (c) 2014年 YiJianJun. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    Toast_Position_Top,
    Toast_Position_Center,
    Toast_Position_Bottom,
} Toast_Position;

@class ToastSettings;
@interface ToastManager : NSObject{
    BOOL _toastIsHiding;
    BOOL _toastHidden;
}

///toast设置settings
@property (nonatomic,strong) ToastSettings *settings;
///显示toast的视图
@property (nonatomic,strong,readonly) UIView *toastView;
///显示toast的父视图,如果为nil将加到window上
@property (nonatomic,weak) UIView *showInView;
///显示的位置Toast_Position或者point
@property (nonatomic,assign) Toast_Position toastPosition;
@property (nonatomic,assign) CGPoint showCenterPoint;

+ (instancetype)toastManager;

// each makeToast method creates a view and displays it as toast
- (void)makeToast:(NSString *)message;
- (void)makeToast:(NSString *)message duration:(NSTimeInterval)interval position:(Toast_Position)position;
- (void)makeToast:(NSString *)message duration:(NSTimeInterval)interval position:(Toast_Position)position image:(UIImage *)image;
- (void)makeToast:(NSString *)message duration:(NSTimeInterval)interval position:(Toast_Position)position title:(NSString *)title;
- (void)makeToast:(NSString *)message duration:(NSTimeInterval)interval position:(Toast_Position)position title:(NSString *)title image:(UIImage *)image;

- (void)makeToast:(NSString *)message duration:(NSTimeInterval)interval centerPoint:(CGPoint)centerPoint;
- (void)makeToast:(NSString *)message duration:(NSTimeInterval)interval centerPoint:(CGPoint)centerPoint image:(UIImage *)image;
- (void)makeToast:(NSString *)message duration:(NSTimeInterval)interval centerPoint:(CGPoint)centerPoint title:(NSString *)title;
- (void)makeToast:(NSString *)message duration:(NSTimeInterval)interval centerPoint:(CGPoint)centerPoint title:(NSString *)title image:(UIImage *)image;

// displays toast with an activity spinner
- (void)makeToastActivity;
- (void)makeToastActivity:(Toast_Position)position;
- (void)hideToastActivity;

// the showToast methods display any view as toast
- (void)showToast:(UIView *)toast;
- (void)showToast:(UIView *)toast duration:(NSTimeInterval)interval position:(Toast_Position)point;
///注:point为显示视图的center位置
- (void)showToast:(UIView *)toast duration:(NSTimeInterval)interval centerPoint:(CGPoint)centerPoint;


- (void)hideToast;
- (void)hideToast:(UIView *)toast;
@end


/*
 *  CONFIGURE THESE VALUES TO ADJUST LOOK & FEEL,
 *  DISPLAY DURATION, ETC.
 */
@interface ToastSettings : NSObject

// general appearance
@property (nonatomic,assign) CGFloat toastMaxWidth;// 0.8-80% of parent view width
@property (nonatomic,assign) CGFloat toastMaxHeight;// 0.8-80% of parent view height
@property (nonatomic,assign) CGFloat toastHorizontalPadding ;// 10.0
@property (nonatomic,assign) CGFloat toastVerticalPadding;//10.0
@property (nonatomic,assign) CGFloat toastCornerRadius;//10.0
@property (nonatomic,assign) CGFloat toastOpacity;//0.8
@property (nonatomic,assign) CGFloat toastFontSize;//16.0
@property (nonatomic,assign) CGFloat toastMaxTitleLines;//0
@property (nonatomic,assign) CGFloat toastMaxMessageLines;//0
@property (nonatomic,assign) NSTimeInterval toastFadeDuration;//0.2

// shadow appearance
@property (nonatomic,assign) CGFloat toastShadowOpacity;//0.8
@property (nonatomic,assign) CGFloat toastShadowRadius;//6.0
@property (nonatomic,assign) CGSize  toastShadowOffset;//{ 4.0, 4.0 }
@property (nonatomic,assign) BOOL    toastDisplayShadow;//YES

// display duration and position
@property (nonatomic,assign) Toast_Position toastDefaultPosition;//center
@property (nonatomic,assign) NSTimeInterval toastDefaultDuration;//3.0 负数代表不隐藏

// image view size
@property (nonatomic,assign) CGFloat toastImageViewWidth;//80.0
@property (nonatomic,assign) CGFloat toastImageViewHeight;//80.0

// activity
@property (nonatomic,assign) CGFloat toastActivityWidth;//100.0
@property (nonatomic,assign) CGFloat toastActivityHeight;//100.0
@property (nonatomic,assign) Toast_Position toastActivityDefaultPosition;//@center

// interaction NO - has some errors
@property (nonatomic,assign) BOOL toastHidesOnTap;//YES-excludes activity views

+ (instancetype)defaultToastSettings;

@end