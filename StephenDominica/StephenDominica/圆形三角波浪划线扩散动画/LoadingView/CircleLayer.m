//
//  CircleLayer.m
//  StephenDominica
//
//  Created by Mac on 16/6/22.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "CircleLayer.h"

@interface CircleLayer ()

@property (strong, nonatomic) UIBezierPath *circleSmallPath;
@property (strong, nonatomic) UIBezierPath *circleBigPath;
@property (strong, nonatomic) UIBezierPath *circleVerticalSquishPath;
@property (strong, nonatomic) UIBezierPath *circleHorizontalSquishPath;

@end

static const NSTimeInterval KAnimationDuration = 0.3; ///< 动画持续时间
static const NSTimeInterval KAnimationBeginTime = 0.; ///< 动画开始时间

@implementation CircleLayer

- (instancetype)init
{
    if (self == [super init]) {
        self.fillColor = [UIColor purpleColor].CGColor;
        self.path = self.circleSmallPath.CGPath;
    }
    return self;
}

- (UIBezierPath *)circleSmallPath {
    if (!_circleSmallPath) {
        _circleSmallPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50.0, 50.0, 0.0, 0.0)];
    }
    return _circleSmallPath;
}
- (UIBezierPath *)circleBigPath {
    if (!_circleBigPath) {
        _circleBigPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(2.5, 17.5, 95.0, 95.0)];
    }
    return _circleBigPath;
}

- (UIBezierPath *)circleVerticalSquishPath
{
    if (!_circleVerticalSquishPath) {
        _circleVerticalSquishPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(5., 20, 100., 90.)];
    }
    return _circleVerticalSquishPath;
}

- (UIBezierPath *)circleHorizontalSquishPath
{
    if (!_circleHorizontalSquishPath) {
        _circleHorizontalSquishPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(2.5, 20., 90., 95.)];
    }
    return _circleHorizontalSquishPath;
}

- (void)expand{
    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    expandAnimation.fromValue = (__bridge id _Nullable)(self.circleSmallPath.CGPath);
    expandAnimation.toValue = (__bridge id _Nullable)(self.circleBigPath.CGPath);
    expandAnimation.duration = KAnimationDuration;
    expandAnimation.fillMode = kCAFillModeForwards;
    expandAnimation.removedOnCompletion = NO;
    [self addAnimation:expandAnimation forKey:nil];
}

- (void)wobbleAnimation
{
//    1
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation1.fromValue = (__bridge id _Nullable)(self.circleBigPath.CGPath);
    animation1.toValue = (__bridge id _Nullable)(self.circleVerticalSquishPath.CGPath);
    animation1.beginTime = KAnimationBeginTime;
    animation1.duration = KAnimationBeginTime;
//    2
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation2.fromValue = (__bridge id _Nullable)(self.circleVerticalSquishPath.CGPath);
    animation2.toValue = (__bridge id _Nullable)(self.circleHorizontalSquishPath.CGPath);
    animation2.beginTime = animation1.duration + animation1.beginTime;
    animation2.duration = KAnimationBeginTime;
//    3
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation3.fromValue = (__bridge id _Nullable)(self.circleHorizontalSquishPath.CGPath);
    animation3.toValue = (__bridge id _Nullable)(self.circleVerticalSquishPath.CGPath);
    animation3.beginTime = animation2.duration + animation2.beginTime;
    animation3.duration = KAnimationBeginTime;
//    4
    CABasicAnimation *animation4 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation4.fromValue = (__bridge id _Nullable)(self.circleVerticalSquishPath.CGPath);
    animation4.toValue = (__bridge id _Nullable)(self.circleBigPath.CGPath);
    animation4.beginTime = animation3.duration + animation3.beginTime;
    animation4.duration = KAnimationBeginTime;

//    5 动画编组
    CAAnimationGroup *animationGroup = [[CAAnimationGroup alloc]init];
    animationGroup.animations = @[animation1, animation2, animation3, animation4];
    animationGroup.duration = 4 * KAnimationDuration;
    animationGroup.repeatCount = 2;
    [self addAnimation:animationGroup forKey:nil];
    
}
#pragma mark - 圆形变小
- (void)contract
{
    CABasicAnimation *contrastAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    contrastAnimation.fromValue = (__bridge id _Nullable)(self.circleBigPath.CGPath);
    contrastAnimation.toValue = (__bridge id _Nullable)(self.circleSmallPath.CGPath);
    contrastAnimation.duration = KAnimationDuration;
    contrastAnimation.fillMode = kCAFillModeForwards;
    contrastAnimation.removedOnCompletion = NO;
    [self addAnimation:contrastAnimation forKey:nil];
}

@end
