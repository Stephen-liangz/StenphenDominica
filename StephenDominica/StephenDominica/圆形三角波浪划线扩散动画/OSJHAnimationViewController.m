//
//  OSJHAnimationViewController.m
//  StephenDominica
//
//  Created by Mac on 16/6/22.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "OSJHAnimationViewController.h"
#import "OSJHLoadingView.h"

@interface OSJHAnimationViewController ()<OSJHLoadingViewDelegate>

@property (strong, nonatomic) OSJHLoadingView *loadingView;
@end

@implementation OSJHAnimationViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.title = @"一个动画";
    
    [self initLoadingView];
}


- (void)initLoadingView
{
    CGFloat sizeValue = 100.;
    _loadingView = [[OSJHLoadingView alloc]initWithFrame:Rect(MainScreenWidth/2 - sizeValue/2, MainScreenHeight/2 - sizeValue/2, sizeValue, sizeValue)];
//    _loadingView.backgroundColor = [UIColor cyanColor];
    _loadingView.delegate = self;
    [self.view addSubview: _loadingView];
}

#pragma mark - 动画代理方法
- (void)completeAnimation
{
    
    [UIView animateWithDuration:0.3 animations:^{
        _loadingView.backgroundColor = [UIColor clearColor];
        self.view.backgroundColor = [UIColor greenColor];
    }completion:^(BOOL finished) {
        [_loadingView removeFromSuperview];
    }];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.frame];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:50.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"Loading 100%";
    label.transform = CGAffineTransformScale(label.transform, 0.25, 0.25);
    [self.view addSubview:label];
    
    [UIView animateWithDuration:0.5 delay:0. usingSpringWithDamping:0.1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        label.transform = CGAffineTransformScale(label.transform, 3., 3.);
    } completion:^(BOOL finished) {
//        [self addTouchButton];
        [NSTimer scheduledTimerWithTimeInterval:1. target:self selector:@selector(btnClick) userInfo:nil repeats:NO];
//        [self btnClick];
    }];
    
}

- (void)addTouchButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnClick {
    self.view.backgroundColor = [UIColor whiteColor];
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    self.loadingView = nil;
    [self initLoadingView];
}


@end
