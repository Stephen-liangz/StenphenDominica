//
//  RectangleLayer.m
//  StephenDominica
//
//  Created by Mac on 16/6/22.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "RectangleLayer.h"

@interface RectangleLayer ()

@property (strong, nonatomic) UIBezierPath *rectangleFullPath;

@end

//线条宽度
static const CGFloat KlineWidth = 5.;

@implementation RectangleLayer

- (instancetype)init{
    if (self == [super init]) {
        self.fillColor = [UIColor clearColor].CGColor;
        self.lineWidth = KlineWidth;
        self.path = self.rectangleFullPath.CGPath;
    }
    return self;
}

- (UIBezierPath *)rectangleFullPath
{
    if (!_rectangleFullPath) {
        _rectangleFullPath = [[UIBezierPath alloc]init];
        [_rectangleFullPath moveToPoint:CGPointMake(0., 100.)];
        [_rectangleFullPath addLineToPoint:CGPointMake(0.0, -KlineWidth)];
        [_rectangleFullPath addLineToPoint:CGPointMake(100., -KlineWidth)];
        [_rectangleFullPath addLineToPoint:CGPointMake(100., 100.)];
        [_rectangleFullPath addLineToPoint:CGPointMake(0., 100.)];
        [_rectangleFullPath closePath];
    }
    return _rectangleFullPath;
}

- (void)strokeChangeWithColor:(UIColor *)color
{
    self.strokeColor = color.CGColor;
    CABasicAnimation *strokeAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeAnimation.fromValue = @0.0;
    strokeAnimation.toValue = @1.;
    strokeAnimation.duration = 0.4;
    [self addAnimation:strokeAnimation forKey:nil];
}


@end
