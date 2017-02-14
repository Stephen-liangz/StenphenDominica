//
//  PaintCodeViewController.m
//  StephenDominica
//
//  Created by Mac on 16/5/27.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "PaintCodeViewController.h"

@interface PaintCodeViewController ()

@end

@implementation PaintCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Paint Code 画图";
    //    self.navigationController.view.layer.cornerRadius = 10;
    //    self.navigationController.view.layer.masksToBounds = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self huaW];
    
}
#pragma mark - 邻信转场
- (void)anni
{
    [self.navigationController pushViewController:[[NSClassFromString(@"FromViewController") alloc] init] animated:YES];
}

#pragma  mark - 使用Paint Code 画图
- (void)huaW
{
    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    layer.path = [self setBezierPath].CGPath;
    layer.bounds = CGPathGetBoundingBox(layer.path);
    
    self.view.backgroundColor = [UIColor blueColor];
    layer.position = CGPointMake(self.view.layer.bounds.size.width / 2, self.view.layer.bounds.size.height/ 2);
    layer.fillColor = [UIColor whiteColor].CGColor;
    [self.view.layer addSublayer:layer];
}

-(UIBezierPath *)setBezierPath
{
    //  这里面加入的就是刚刚PaintCode粘贴出来的代码
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Image Declarations
    UIImage* image1c950a7b02087bf4a94a1fd9f1d3572c11dfcf58 = [UIImage imageNamed: @"image1c950a7b02087bf4a94a1fd9f1d3572c11dfcf58.jpg"];
    
    //// Picture Drawing
    UIBezierPath* picturePath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 598, 535)];
    CGContextSaveGState(context);
    [picturePath addClip];
    [image1c950a7b02087bf4a94a1fd9f1d3572c11dfcf58 drawInRect: CGRectMake(0, 0, image1c950a7b02087bf4a94a1fd9f1d3572c11dfcf58.size.width, image1c950a7b02087bf4a94a1fd9f1d3572c11dfcf58.size.height)];
    CGContextRestoreGState(context);
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(77, 458)];
    [bezierPath addCurveToPoint: CGPointMake(63, 473) controlPoint1: CGPointMake(57, 483) controlPoint2: CGPointMake(63, 473)];
    [bezierPath addLineToPoint: CGPointMake(52, 483)];
    [bezierPath addLineToPoint: CGPointMake(41, 486)];
    [bezierPath addLineToPoint: CGPointMake(34, 486)];
    [bezierPath addLineToPoint: CGPointMake(27, 486)];
    [bezierPath addLineToPoint: CGPointMake(20, 483)];
    [bezierPath addLineToPoint: CGPointMake(15, 479)];
    [bezierPath addLineToPoint: CGPointMake(9, 473)];
    [bezierPath addLineToPoint: CGPointMake(5, 465)];
    [bezierPath addLineToPoint: CGPointMake(5, 458)];
    [bezierPath addLineToPoint: CGPointMake(5, 451)];
    [bezierPath addLineToPoint: CGPointMake(5, 441)];
    [bezierPath addLineToPoint: CGPointMake(5, 434)];
    [bezierPath addLineToPoint: CGPointMake(9, 425)];
    [bezierPath addLineToPoint: CGPointMake(15, 414)];
    [bezierPath addLineToPoint: CGPointMake(24, 400)];
    [bezierPath addLineToPoint: CGPointMake(34, 392)];
    [bezierPath addLineToPoint: CGPointMake(49, 377)];
    [bezierPath addLineToPoint: CGPointMake(66, 362)];
    [bezierPath addLineToPoint: CGPointMake(90, 347)];
    [bezierPath addLineToPoint: CGPointMake(115, 339)];
    [bezierPath addLineToPoint: CGPointMake(135, 336)];
    [bezierPath addLineToPoint: CGPointMake(155, 339)];
    [bezierPath addLineToPoint: CGPointMake(167, 344)];
    [bezierPath addLineToPoint: CGPointMake(177, 356)];
    [bezierPath addLineToPoint: CGPointMake(180, 365)];
    [bezierPath addLineToPoint: CGPointMake(180, 384)];
    [bezierPath addLineToPoint: CGPointMake(177, 400)];
    [bezierPath addLineToPoint: CGPointMake(167, 414)];
    [bezierPath addLineToPoint: CGPointMake(159, 434)];
    [bezierPath addLineToPoint: CGPointMake(152, 446)];
    [bezierPath addLineToPoint: CGPointMake(184, 407)];
    [bezierPath addLineToPoint: CGPointMake(201, 384)];
    [bezierPath addLineToPoint: CGPointMake(193, 374)];
    [bezierPath addLineToPoint: CGPointMake(190, 365)];
    [bezierPath addLineToPoint: CGPointMake(201, 347)];
    [bezierPath addLineToPoint: CGPointMake(201, 332)];
    [bezierPath addLineToPoint: CGPointMake(201, 325)];
    [bezierPath addLineToPoint: CGPointMake(205, 318)];
    [bezierPath addLineToPoint: CGPointMake(211, 318)];
    [bezierPath addLineToPoint: CGPointMake(215, 322)];
    [bezierPath addLineToPoint: CGPointMake(215, 325)];
    [bezierPath addLineToPoint: CGPointMake(215, 329)];
    [bezierPath addLineToPoint: CGPointMake(211, 336)];
    [bezierPath addLineToPoint: CGPointMake(211, 339)];
    [bezierPath addLineToPoint: CGPointMake(215, 344)];
    [bezierPath addLineToPoint: CGPointMake(223, 325)];
    [bezierPath addLineToPoint: CGPointMake(219, 318)];
    [bezierPath addLineToPoint: CGPointMake(223, 314)];
    [bezierPath addLineToPoint: CGPointMake(229, 314)];
    [bezierPath addLineToPoint: CGPointMake(232, 318)];
    [bezierPath addLineToPoint: CGPointMake(232, 322)];
    [bezierPath addLineToPoint: CGPointMake(229, 332)];
    [bezierPath addLineToPoint: CGPointMake(229, 336)];
    [bezierPath addLineToPoint: CGPointMake(229, 339)];
    [bezierPath addLineToPoint: CGPointMake(241, 325)];
    [bezierPath addLineToPoint: CGPointMake(241, 318)];
    [bezierPath addLineToPoint: CGPointMake(248, 314)];
    [bezierPath addLineToPoint: CGPointMake(251, 314)];
    [bezierPath addLineToPoint: CGPointMake(257, 322)];
    [bezierPath addLineToPoint: CGPointMake(254, 325)];
    [bezierPath addLineToPoint: CGPointMake(251, 329)];
    [bezierPath addLineToPoint: CGPointMake(248, 336)];
    [bezierPath addLineToPoint: CGPointMake(248, 347)];
    [bezierPath addLineToPoint: CGPointMake(254, 339)];
    [bezierPath addLineToPoint: CGPointMake(257, 336)];
    [bezierPath addLineToPoint: CGPointMake(262, 332)];
    [bezierPath addLineToPoint: CGPointMake(267, 332)];
    [bezierPath addLineToPoint: CGPointMake(271, 339)];
    [bezierPath addLineToPoint: CGPointMake(267, 344)];
    [bezierPath addLineToPoint: CGPointMake(262, 347)];
    [bezierPath addLineToPoint: CGPointMake(257, 356)];
    [bezierPath addLineToPoint: CGPointMake(257, 359)];
    [bezierPath addLineToPoint: CGPointMake(262, 352)];
    [bezierPath addLineToPoint: CGPointMake(271, 347)];
    [bezierPath addLineToPoint: CGPointMake(274, 352)];
    [bezierPath addCurveToPoint: CGPointMake(274, 352) controlPoint1: CGPointMake(274, 352) controlPoint2: CGPointMake(274, 348)];
    [bezierPath addCurveToPoint: CGPointMake(271, 359) controlPoint1: CGPointMake(274, 356) controlPoint2: CGPointMake(271, 359)];
    [bezierPath addCurveToPoint: CGPointMake(271, 365) controlPoint1: CGPointMake(271, 359) controlPoint2: CGPointMake(275, 361)];
    [bezierPath addCurveToPoint: CGPointMake(262, 374) controlPoint1: CGPointMake(267, 369) controlPoint2: CGPointMake(262, 374)];
    [bezierPath addLineToPoint: CGPointMake(262, 377)];
    [bezierPath addLineToPoint: CGPointMake(257, 384)];
    [bezierPath addLineToPoint: CGPointMake(254, 388)];
    [bezierPath addCurveToPoint: CGPointMake(254, 388) controlPoint1: CGPointMake(254, 388) controlPoint2: CGPointMake(257, 384)];
    [bezierPath addCurveToPoint: CGPointMake(251, 392) controlPoint1: CGPointMake(251, 392) controlPoint2: CGPointMake(254, 389)];
    [bezierPath addCurveToPoint: CGPointMake(248, 396) controlPoint1: CGPointMake(248, 395) controlPoint2: CGPointMake(248, 396)];
    [bezierPath addLineToPoint: CGPointMake(241, 396)];
    [bezierPath addLineToPoint: CGPointMake(232, 396)];
    [bezierPath addLineToPoint: CGPointMake(229, 396)];
    [bezierPath addCurveToPoint: CGPointMake(229, 400) controlPoint1: CGPointMake(229, 396) controlPoint2: CGPointMake(229, 397)];
    [bezierPath addCurveToPoint: CGPointMake(229, 407) controlPoint1: CGPointMake(229, 403) controlPoint2: CGPointMake(232, 407)];
    [bezierPath addCurveToPoint: CGPointMake(226, 407) controlPoint1: CGPointMake(226, 407) controlPoint2: CGPointMake(226, 407)];
    [bezierPath addLineToPoint: CGPointMake(219, 473)];
    [bezierPath addLineToPoint: CGPointMake(219, 479)];
    [bezierPath addLineToPoint: CGPointMake(262, 434)];
    [bezierPath addLineToPoint: CGPointMake(274, 414)];
    [bezierPath addLineToPoint: CGPointMake(285, 400)];
    [bezierPath addLineToPoint: CGPointMake(297, 377)];
    [bezierPath addLineToPoint: CGPointMake(285, 365)];
    [bezierPath addLineToPoint: CGPointMake(285, 352)];
    [bezierPath addLineToPoint: CGPointMake(297, 344)];
    [bezierPath addLineToPoint: CGPointMake(317, 344)];
    [bezierPath addLineToPoint: CGPointMake(328, 362)];
    [bezierPath addLineToPoint: CGPointMake(328, 377)];
    [bezierPath addLineToPoint: CGPointMake(317, 392)];
    [bezierPath addLineToPoint: CGPointMake(297, 414)];
    [bezierPath addLineToPoint: CGPointMake(274, 446)];
    [bezierPath addLineToPoint: CGPointMake(241, 473)];
    [bezierPath addLineToPoint: CGPointMake(223, 502)];
    [bezierPath addLineToPoint: CGPointMake(190, 529)];
    [bezierPath addLineToPoint: CGPointMake(167, 529)];
    [bezierPath addLineToPoint: CGPointMake(184, 434)];
    [bezierPath addLineToPoint: CGPointMake(90, 529)];
    [bezierPath addLineToPoint: CGPointMake(66, 529)];
    [bezierPath addLineToPoint: CGPointMake(135, 388)];
    [bezierPath addLineToPoint: CGPointMake(135, 374)];
    [bezierPath addLineToPoint: CGPointMake(135, 362)];
    [bezierPath addLineToPoint: CGPointMake(115, 359)];
    [bezierPath addLineToPoint: CGPointMake(90, 362)];
    [bezierPath addLineToPoint: CGPointMake(77, 374)];
    [bezierPath addLineToPoint: CGPointMake(63, 392)];
    [bezierPath addLineToPoint: CGPointMake(52, 407)];
    [bezierPath addLineToPoint: CGPointMake(41, 425)];
    CGContextSaveGState(context);
    [bezierPath addClip];
    
    [image1c950a7b02087bf4a94a1fd9f1d3572c11dfcf58 drawInRect: CGRectMake(5, -49, image1c950a7b02087bf4a94a1fd9f1d3572c11dfcf58.size.width, image1c950a7b02087bf4a94a1fd9f1d3572c11dfcf58.size.height)];
    CGContextRestoreGState(context);
    
    return bezierPath;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
