//
//  BezierPathViewController.m
//  StephenDominica
//
//  Created by Mac on 16/6/1.
//  Copyright © 2016年 Mac. All rights reserved.
//

/** 
 使用贝塞尔曲线、CADisplayLink、CAShapeLayer、pan手势
 **/

#import "BezierPathViewController.h"

@interface BezierPathViewController()
{
    CGFloat MIN_HEIGHT;
    
    
}

@property (nonatomic, strong)CAShapeLayer *shapeLayer;///< 形变图形

@property (nonatomic, strong)UIView *curveView;///< 拖动点
@property (nonatomic, assign)CGFloat curveX;///< 拖动点X
@property (nonatomic, assign)CGFloat curveY;///< 拖动点Y

@property (nonatomic, assign)CGFloat vHeight;///< 相对变化的高度

@property (nonatomic, strong)CADisplayLink *displayLink;///< 频率刷新
@end

@implementation BezierPathViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"果冻贝塞尔曲线下拉";
    
    
    //初始形变layer
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.fillColor = RGB(50, 50, 50).CGColor;
    [self.view.layer  addSublayer:_shapeLayer];
    
    //初始拖动点
    MIN_HEIGHT = 100.;
    
    _curveX = MainScreenWidth/2;
    _curveY = MIN_HEIGHT;
    _curveView = [[UIView alloc]initWithFrame:Rect(_curveX, _curveY, 3, 3)];
    _curveView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_curveView];
    
    _vHeight = 100;
    
    //添加pan手势
    self.view.userInteractionEnabled = YES;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureAction:)];
    [self.view addGestureRecognizer:pan];
    
    //循环
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(calculatePath)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    _displayLink.paused = YES;
    
    [self updateShapeLayerPath];
    
    
    //kvo test
    [self KVOTest];
}

#pragma mark - 手势action
- (void)panGestureAction:(UIPanGestureRecognizer *)pan
{
    if (pan.state == UIGestureRecognizerStateChanged) {
        
        CGPoint panPoint = [pan translationInView:self.view];
        
        _vHeight = panPoint.y * 0.7 + MIN_HEIGHT;
        _curveX = MainScreenWidth/2 + panPoint.x;
        _curveY = _vHeight > MIN_HEIGHT ? _vHeight : MIN_HEIGHT;
        
        [_curveView setFrame:Rect(_curveX, _curveY, 3, 3)];
        
        [self updateShapeLayerPath];
    }
    else if (pan.state == UIGestureRecognizerStateEnded)
    {
        _displayLink.paused = NO;

//        _curveX = MainScreenWidth/2;
//        _curveY = MIN_HEIGHT;
        
        
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            [_curveView setFrame:Rect(MainScreenWidth/2, MIN_HEIGHT, 3, 3)];
            
        } completion:^(BOOL finished) {
            _displayLink.paused = YES;
        }];
    }
}

#pragma mark - 计算贝塞尔曲线 更新曲线
-(void)updateShapeLayerPath
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(self.view.frame.size.width, 0)];
    [path addLineToPoint:CGPointMake(self.view.frame.size.width, MIN_HEIGHT)];
    [path addQuadCurveToPoint:CGPointMake(0, MIN_HEIGHT) controlPoint:CGPointMake(_curveX, _curveY)];
    [path closePath];
    
    _shapeLayer.path = path.CGPath;
    
}
#pragma mark - 计算贝塞尔曲线 初始
- (void)calculatePath
{
    _curveX=_curveView.center.x;
    _curveY=_curveView.center.y;
    [self updateShapeLayerPath];
    
}

#pragma mark - KVO
- (void)KVOTest
{
    UIButton *KVOButton;
    KVOButton = ({
        UIButton *btn = [[UIButton alloc]initWithFrame:Rect(100, 200, 150, 60)];
        [btn setTitle:@"1" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(ChangeValue:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
    [self.view addSubview:KVOButton];
    
    UILabel *KVOLabel;
    KVOLabel = ({
        UILabel *lab = [[UILabel alloc]initWithFrame:Rect(168, 200, 150, 60)];
        lab.font = [UIFont systemFontOfSize:15];
        lab.textColor = [UIColor blueColor];
        lab.tag = 12;
        lab;
    });
    [self.view addSubview:KVOLabel];
    
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
//    UILabel *lab = [self.view viewWithTag:12];
//    lab.font = [UIFont systemFontOfSize:[lab.text floatValue]];
}

- (void)ChangeValue:(UIButton *)btn
{
    NSString *str = btn.titleLabel.text;
    
    [btn setTitle:[NSString stringWithFormat:@"%ld",[str integerValue]+1] forState:UIControlStateNormal];
}

@end
