//
//  OSJHLoadingView.m
//  StephenDominica
//
//  Created by Mac on 16/6/22.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "OSJHLoadingView.h"
#import "CircleLayer.h"
#import "TriangleLayer.h"
#import "RectangleLayer.h"
#import "WaveLayer.h"

@interface OSJHLoadingView ()

@property (strong, nonatomic) CircleLayer *circleLayer;
@property (strong, nonatomic) TriangleLayer *triangleLayer;
@property (strong, nonatomic) RectangleLayer *rectangleLayer1;
@property (strong, nonatomic) RectangleLayer *rectangleLayer2;
@property (strong, nonatomic) WaveLayer *waveLayer;

@end

@implementation OSJHLoadingView

- (instancetype) initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addCircleLayer];
    }
    return self;
}

- (CircleLayer *)circleLayer {
    if (!_circleLayer) {
        _circleLayer = [[CircleLayer alloc] init];
    }
    return _circleLayer;
}

- (TriangleLayer *)triangleLayer
{
    if (!_triangleLayer) {
        _triangleLayer = [[TriangleLayer alloc]init];
    }
    return _triangleLayer;
}

- (RectangleLayer *)rectangleLayer1 {
    if (!_rectangleLayer1) {
        _rectangleLayer1 = [[RectangleLayer alloc] init];
    }
    return _rectangleLayer1;
}

- (RectangleLayer *)rectangleLayer2 {
    if (!_rectangleLayer2) {
        _rectangleLayer2 = [[RectangleLayer alloc] init];
    }
    return _rectangleLayer2;
}

- (WaveLayer *)waveLayer {
    if (!_waveLayer) {
        _waveLayer = [[WaveLayer alloc] init];
    }
    return _waveLayer;
}
#pragma mark - 添加圆形,放大圆动画 --> 圆变形
- (void)addCircleLayer {
    [self.layer addSublayer:self.circleLayer];
    
    [_circleLayer expand];
    
    [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(wobbleCircleLayer) userInfo:nil repeats:NO];
}

#pragma mark - 圆变形,圆变形 --> 添加三角形
- (void)wobbleCircleLayer
{
    [_circleLayer wobbleAnimation];
    [self.layer addSublayer:self.triangleLayer];
    [NSTimer scheduledTimerWithTimeInterval:0.9 target:self selector:@selector(triangleAnimation) userInfo:nil repeats:NO];
}
#pragma mark - 三角形变形, 三角形变形 --> Z轴旋转
- (void)triangleAnimation
{
    [_triangleLayer triangleAnimate];
    [NSTimer scheduledTimerWithTimeInterval:0.9 target:self selector:@selector(transformAnima) userInfo:nil repeats:NO];
    
}

- (void)transformAnima
{
    [self transformRotationZ];
    [_circleLayer contract];
    [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(drawRectangleAnimation1) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(drawRectangleAnimation2) userInfo:nil repeats:NO];
}

#pragma mark - ,Z轴旋转 --> 圆形变小,显示大三角
- (void)transformRotationZ
{
    self.layer.anchorPoint = CGPointMake(0.5, 0.66);
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = @( M_PI * 2);
    rotationAnimation.duration = 0.45;
    rotationAnimation.removedOnCompletion = NO;
    [self.layer addAnimation:rotationAnimation forKey:nil];
}

- (void)drawRectangleAnimation1 {
    [self.layer addSublayer:self.rectangleLayer1];
    [_rectangleLayer1 strokeChangeWithColor:[UIColor purpleColor]];
    
}

- (void)drawRectangleAnimation2 {
    [self.layer addSublayer:self.rectangleLayer2];
    [_rectangleLayer2 strokeChangeWithColor:[UIColor orangeColor]];
    [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(drawWaveAnimation) userInfo:nil repeats:NO];
}

- (void)drawWaveAnimation {
    [self.layer addSublayer:self.waveLayer];
    [_waveLayer waveAnimate];
    [NSTimer scheduledTimerWithTimeInterval:0.9 target:self selector:@selector(expandView) userInfo:nil repeats:NO];
}

- (void)expandView
{
    self.backgroundColor = [UIColor orangeColor];
    self.layer.sublayers = nil;
    [UIView animateKeyframesWithDuration:0.3 delay:0. options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame = [UIApplication sharedApplication].keyWindow.frame;
    } completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(completeAnimation)]) {
            [self.delegate completeAnimation];
        }
    }];
}


@end
