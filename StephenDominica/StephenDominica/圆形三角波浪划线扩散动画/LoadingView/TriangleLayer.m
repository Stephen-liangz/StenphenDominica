//
//  TriangleLayer.m
//  StephenDominica
//
//  Created by Mac on 16/6/22.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "TriangleLayer.h"

@interface TriangleLayer ()

@property (strong, nonatomic) UIBezierPath *smallTrianglePath;
@property (strong, nonatomic) UIBezierPath *leftTrianglePath;
@property (strong, nonatomic) UIBezierPath *rightTrianglePath;
@property (strong, nonatomic) UIBezierPath *topTrianglePath;

@end;

static const CGFloat paddingSpace = 30.;

@implementation TriangleLayer

- (instancetype)init{
    if (self == [super init]) {
        self.fillColor = [UIColor purpleColor].CGColor;
        self.strokeColor = [UIColor purpleColor].CGColor;
//        self.fillColor = [UIColor greenColor].CGColor;
//        self.strokeColor = [UIColor cyanColor].CGColor;
        self.lineWidth = 3.;
        self.lineCap = kCALineCapRound;
        self.lineJoin = kCALineCapRound;
        self.path = self.smallTrianglePath.CGPath;
    }
    return self;
}

- (UIBezierPath *)smallTrianglePath
{
    if (!_smallTrianglePath) {
        _smallTrianglePath = [[UIBezierPath alloc]init];
        [_smallTrianglePath moveToPoint:CGPointMake(5. + paddingSpace, 95.)];
        [_smallTrianglePath addLineToPoint:CGPointMake(50., paddingSpace )];
        [_smallTrianglePath addLineToPoint:CGPointMake(95 - paddingSpace, 95.)];
        [_smallTrianglePath closePath];
    }
    return _smallTrianglePath;
}

- (UIBezierPath *)leftTrianglePath
{
    if (!_leftTrianglePath) {
        _leftTrianglePath = [[UIBezierPath alloc]init];
        [_leftTrianglePath moveToPoint:CGPointMake(5., 95.)];
        [_leftTrianglePath addLineToPoint:CGPointMake(50.,  12.5 + paddingSpace )];
        [_leftTrianglePath addLineToPoint:CGPointMake(95 - paddingSpace, 95.)];
        [_leftTrianglePath closePath];
    }
    return _leftTrianglePath;
}

- (UIBezierPath *)rightTrianglePath
{
    if (!_rightTrianglePath) {
        _rightTrianglePath = [[UIBezierPath alloc]init];
        [_rightTrianglePath moveToPoint:CGPointMake(5., 95.)];
        [_rightTrianglePath addLineToPoint:CGPointMake(50., 12.5 + paddingSpace )];
        [_rightTrianglePath addLineToPoint:CGPointMake(95., 95.)];
        [_rightTrianglePath closePath];
    }
    return _rightTrianglePath;
}

- (UIBezierPath *)topTrianglePath
{
    if (!_topTrianglePath) {
        _topTrianglePath = [[UIBezierPath alloc]init];
        [_topTrianglePath moveToPoint:CGPointMake(5., 95.)];
        [_topTrianglePath addLineToPoint:CGPointMake(50., 12.5 )];
        [_topTrianglePath addLineToPoint:CGPointMake(95., 95.)];
        [_topTrianglePath closePath];
    }
    return _topTrianglePath;
}

- (void)triangleAnimate
{
//    left
    CABasicAnimation *triangleAnimationLeft = [CABasicAnimation animationWithKeyPath:@"path"];
    triangleAnimationLeft.fromValue = (__bridge id _Nullable)(self.smallTrianglePath.CGPath);
    triangleAnimationLeft.toValue = (__bridge id _Nullable)(self.leftTrianglePath.CGPath);
    triangleAnimationLeft.beginTime = 0.0;
    triangleAnimationLeft.duration = 0.3;
//    right
    CABasicAnimation *triangleAnimationRight = [CABasicAnimation animationWithKeyPath:@"path"];
    triangleAnimationRight.fromValue = (__bridge id _Nullable)(self.leftTrianglePath.CGPath);
    triangleAnimationRight.toValue = (__bridge id _Nullable)(self.rightTrianglePath.CGPath);
    triangleAnimationRight.beginTime = triangleAnimationLeft.duration;
    triangleAnimationRight.duration = 0.3;
//    top
    CABasicAnimation *triangleAnimationTop = [CABasicAnimation animationWithKeyPath:@"path"];
    triangleAnimationTop.fromValue = (__bridge id _Nullable)(self.rightTrianglePath.CGPath);
    triangleAnimationTop.toValue = (__bridge id _Nullable)(self.topTrianglePath.CGPath);
    triangleAnimationTop.beginTime = triangleAnimationRight.duration + triangleAnimationRight.beginTime;
    triangleAnimationTop.duration = 0.3;
//    group
    CAAnimationGroup *group = [[CAAnimationGroup alloc]init];
    group.animations = @[triangleAnimationLeft,
                         triangleAnimationRight,
                         triangleAnimationTop];
    group.duration = 0.3 * 3;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    
    [self addAnimation:group forKey:nil];
    
    
}
@end
