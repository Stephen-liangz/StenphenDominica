//
//  LXHomePageViewController.m
//  StephenDominica
//
//  Created by Mac on 16/5/27.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "LXHomePageViewController.h"

@interface LXHomePageViewController ()<UIGestureRecognizerDelegate>
{
    int heightV;
    BOOL isShowBottomView;
    //点击隐藏 显示按钮
    UIButton *showHideBtn;
    //btn
    UIButton *btn1;
    UIButton *btn2;
    UIButton *btn3;
    
    //初始位置
    CGPoint startLocation;///<
    
    //粒子动画
    CAEmitterLayer * _fireEmitter;///< 发射器对象

}

@property (nonatomic, strong)UIScrollView *scrollView; ///< 滚动View
@property (nonatomic, strong)UIView *bottomView;///< 底部View
//icon imageView
@property (nonatomic, strong)UIView *starView;///< 星星View
//icon imageView
@property (nonatomic, strong)UIImageView *iconImageView;///< IconView

@end

@implementation LXHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"首页呀";
    self.view.backgroundColor = [UIColor whiteColor];
    
    heightV = 5;
    
    [self initUI];
    
}

- (void)initUI
{
//    _scrollView = [[UIScrollView alloc]initWithFrame:Rect(0, MainScreenHeight/3, MainScreenWidth, MainScreenHeight/3*2)];
//    _scrollView.backgroundColor = RGB(6, 129, 239);
//    _scrollView.delegate = self;
////    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.top.mas_equalTo(MainScreenHeight/3);
////        make.width.mas_equalTo(MainScreenWidth);
////        make.height.mas_equalTo(MainScreenHeight/3*2);
////    }];
//    [_scrollView setContentSize:CGSizeMake(MainScreenWidth, _scrollView.height + 5)];
//    [self.view addSubview:_scrollView];
    

    /**
     底部视图
     **/
    _bottomView = [[UIView alloc]init];
    _bottomView.backgroundColor = RGB(6, 129, 239);
    [self.view addSubview:_bottomView];
    
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(MainScreenHeight/heightV*(heightV - 1));
        make.width.mas_equalTo(MainScreenWidth);
        make.height.mas_equalTo(MainScreenHeight/heightV);
    }];
    
    showHideBtn = [[UIButton alloc]init];
    [showHideBtn setTitle:@"上拉、下拉啦" forState:UIControlStateNormal];
    showHideBtn.backgroundColor = RGB(222, 222, 222);
    [showHideBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [showHideBtn addTarget:self action:@selector(showHideAction) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:showHideBtn];
    
    [showHideBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_bottomView.centerX);
        make.size.mas_equalTo(CGSizeMake(100, 50));
        make.top.mas_equalTo(_bottomView.top - 8);
    }];
    
    _iconImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"will.jpg"]];
    [self.view addSubview:_iconImageView];
    _iconImageView.sd_layout
    .heightIs(80)
    .widthIs(80)
    .bottomSpaceToView(_bottomView,25)
    .centerXIs(self.view.centerX);
    
    _iconImageView.transform = CGAffineTransformMakeScale(2.5, 2.5);
    
    //初始化变化按钮
    [self initBtns];
    //初始化隐藏 显示控制属性
    isShowBottomView = YES;
    
    //初始化手势
    UISwipeGestureRecognizer *upRecognizer;
    upRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    upRecognizer.delegate = self;
    [upRecognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [[self view] addGestureRecognizer:upRecognizer];
    
    UISwipeGestureRecognizer *downRecognizer;
    downRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    downRecognizer.delegate = self;
    [downRecognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [[self view] addGestureRecognizer:downRecognizer];
//
    //粒子动画
//    [self downView];
    
    /**
     流星动画
     **/
    [self initStarView];
}
#pragma mark - 流星View
- (void)initStarView
{
    _starView = [[UIView alloc]initWithFrame:Rect(0, 12, MainScreenWidth, 150)];
    _starView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_starView];
    
    NSValue *value1=[NSValue valueWithCGPoint:CGPointMake(MainScreenWidth/4, 5)];
    NSValue *value2=[NSValue valueWithCGPoint:CGPointMake(MainScreenWidth/4 - 10*1, 25)];
    NSValue *value3=[NSValue valueWithCGPoint:CGPointMake(MainScreenWidth/4  - 10*2, 55)];
    NSValue *value4=[NSValue valueWithCGPoint:CGPointMake(MainScreenWidth/4 - 10*3, 90)];
    NSValue *value5=[NSValue valueWithCGPoint:CGPointMake(MainScreenWidth/4 - 10*4, 130) ];
    NSArray *positionArray1 = @[value1,value2,value3,value4,value5];
    
    UIView *meteorView1 = [[UIView alloc]initWithFrame:Rect(0, 0, 3, 3)];
    meteorView1.backgroundColor = RGB(6, 129, 239);
    [_starView addSubview:meteorView1];

    [self createMeteorOnView:meteorView1 WithPosition:positionArray1];
    
    NSValue *value11 = [NSValue valueWithCGPoint:CGPointMake(MainScreenWidth/2, 10 )];
    NSValue *value22 = [NSValue valueWithCGPoint:CGPointMake(MainScreenWidth/2 - 11*1, 30)];
    NSValue *value33 =[NSValue valueWithCGPoint:CGPointMake(MainScreenWidth/2  - 12*2, 60)];
    NSValue *value44 = [NSValue valueWithCGPoint:CGPointMake(MainScreenWidth/2 - 12*3, 90)];
    NSValue *value55 = [NSValue valueWithCGPoint:CGPointMake(MainScreenWidth/2 - 12*4, 135) ];
    NSArray *positionArray2 = @[value11,value22,value33,value44,value55];
    
    UIView *meteorView2 = [[UIView alloc]initWithFrame:Rect(0, 0, 3, 3)];
    meteorView2.backgroundColor = RGB(6, 129, 239);
    [_starView addSubview:meteorView2];
    
    [self createMeteorOnView:meteorView2 WithPosition:positionArray2];


}
#pragma mark - 流星动画
- (void)createMeteorOnView:(UIView *)onView WithPosition:(NSArray *)positionArray
{
    //1.创建核心动画
    CAKeyframeAnimation *keyAnima=[CAKeyframeAnimation animation];
    //平移
    keyAnima.keyPath = @"position";
    //1.1告诉系统要执行什么动画
    keyAnima.values = positionArray;
    //1.2设置动画执行完毕后，不删除动画
    keyAnima.removedOnCompletion = NO;
    keyAnima.repeatCount = 9999999;
    //1.3设置保存动画的最新状态
    keyAnima.fillMode = kCAFillModeForwards;
    //1.4设置动画执行的时间
    keyAnima.duration = 2.0;
    //1.5设置动画的节奏
    keyAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    //设置代理，开始—结束
//    keyAnima.delegate = self;
    //2.添加核心动画
    [onView.layer addAnimation:keyAnima forKey:nil];
}

#pragma mark - 滑动手势 响应方法
- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionDown) {
        
        NSLog(@"down滑");
        //执行程序
        [self hideBottomView];
        [self setUpAfterShowOrHide];
        
        
    }
    if(recognizer.direction==UISwipeGestureRecognizerDirectionUp) {
        
        NSLog(@"up滑");
        //执行程序
        [self showBottomView];
        [self setUpAfterShowOrHide];
    }
//    CGPoint point= [recognizer locationInView:self.view];
//    NSLog(@"x:%f y:%f",point.x,point.y);
}




#pragma mark - 滑动手势 delegate



#pragma mark - 初始化背景上的按钮
- (void)initBtns
{
    btn1 = [[UIButton alloc]init];
    [btn1 setTitle:@"btn1" forState:UIControlStateNormal];
    btn1.backgroundColor = RGB(111, 222, 222);
    [btn1 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(showHideAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.left.mas_equalTo (45);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    btn1.transform = CGAffineTransformMakeScale(1, 1);
    
    btn2 = [[UIButton alloc]init];
    [btn2 setTitle:@"btn2" forState:UIControlStateNormal];
    btn2.backgroundColor = RGB(222, 222, 222);
    [btn2 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(showHideAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(55);
        make.left.mas_equalTo (130);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    btn2.transform = CGAffineTransformMakeScale(1, 1);
    
}
#pragma mark - 显示 隐藏按钮action
- (void)showHideAction
{
    if (isShowBottomView) {
        [self showBottomView];
    }else{
        [self hideBottomView];
    }
    
    [self setUpAfterShowOrHide];
}
#pragma mark - 在显示和隐藏后 相关的操作
- (void)setUpAfterShowOrHide
{
    isShowBottomView = !isShowBottomView;
}

#pragma mark - 显示view动画
- (void)showBottomView
{
    //底层 和底部 view的变化
    [UIView animateWithDuration:0.5 animations:^{
        
        [_bottomView setFrame:Rect(0, MainScreenHeight/heightV, MainScreenWidth, MainScreenHeight/heightV*(heightV - 1))];
        
        _iconImageView.transform = CGAffineTransformMakeScale(1, 1);
        [_iconImageView setBottom:_bottomView.top - 25];
  
    }];
    //变化按钮大小
    [UIView animateWithDuration:0.5 animations:^{
        btn1.transform = CGAffineTransformMakeScale(0, 0);
        btn2.transform = CGAffineTransformMakeScale(0, 0);
    }completion:^(BOOL finished) {
        _starView.hidden = YES;
    }];
    
    //旋转按钮朝向
    [UIView animateWithDuration:0.5 animations:^{
        showHideBtn.transform = CGAffineTransformMakeRotation(M_PI);
    }];
}
#pragma mark - 隐藏view动画
- (void)hideBottomView
{
    [UIView animateWithDuration:0.5 animations:^{
        
        [_bottomView setFrame:Rect(0, MainScreenHeight/heightV*(heightV - 1), MainScreenWidth, MainScreenHeight/heightV*(heightV - 1))];
        
        _iconImageView.transform = CGAffineTransformMakeScale(2.5, 2.5);
        [_iconImageView setBottom:_bottomView.top - 45];
        
    }];
    [UIView animateWithDuration:0.5 animations:^{
        btn1.transform = CGAffineTransformMakeScale(1, 1);
        btn2.transform = CGAffineTransformMakeScale(1, 1);
    }completion:^(BOOL finished) {
        _starView.hidden = NO;
    }];
    //旋转按钮朝向
    [UIView animateWithDuration:0.5 animations:^{
        showHideBtn.transform = CGAffineTransformMakeRotation(0);
    }];
}

#pragma mark - 触控事件
- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    // Calculate and store offset, and pop view into front if needed
    CGPoint pt = [[touches anyObject] locationInView:self.view];
    startLocation = pt;
    //    NSLog(@"x:%f y:%f",startLocation.x,startLocation.y);
}

- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
    // Calculate offset
    CGPoint pt = [[touches anyObject] locationInView:self.view];
    float dx = pt.x - startLocation.x;
    float dy = pt.y - startLocation.y;
    NSLog(@"x:%f y:%f",dx,dy);
    
    [self afterToucheMoveAnmition:dy];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"不摸了");
}
#pragma mark -触摸滑动之后
- (void)afterToucheMoveAnmition:(CGFloat)offsetValue
{
//    //向上滑动
//    if (offsetValue < 0) {
//        CGFloat off = fabs(offsetValue);
//        
//    }
//    //向下滑动
//    else if (offsetValue > 0){
//        CGFloat off = fabs(offsetValue);
//        
//    }
    //控制滑动的灵敏度
    CGFloat panControlValue = 0.3;
    //_bottomView 的top值
    CGFloat bottomViewTopValue = _bottomView.top;
    CGFloat botoomViewTopValueAddSilderValue = bottomViewTopValue + panControlValue*offsetValue;
    
    if (botoomViewTopValueAddSilderValue < MainScreenHeight/heightV) {
        botoomViewTopValueAddSilderValue = MainScreenHeight/heightV;
    }else if (botoomViewTopValueAddSilderValue > MainScreenHeight/heightV*(heightV - 1)) {
         botoomViewTopValueAddSilderValue = MainScreenHeight/heightV*(heightV - 1);
    }else{
         botoomViewTopValueAddSilderValue = botoomViewTopValueAddSilderValue;
    }
//    NSLog(@"bottomViewTopValue:%f  botoomViewTopValueAddSilderValue:%f  MainScreenHeight/heightV:%f",bottomViewTopValue,botoomViewTopValueAddSilderValue,MainScreenHeight/heightV);
    
    //移动bottomView
    [_bottomView setFrame:Rect(0, botoomViewTopValueAddSilderValue , MainScreenWidth, MainScreenHeight/heightV*(heightV - 1))];
    //移动iconView
    [_iconImageView setBottom:_bottomView.top - 25];
    //缩放iconView
    // 缩放比例 缩放按钮
    CGFloat pantographValue = fabs(offsetValue)/MainScreenHeight/heightV*(heightV - 2)/panControlValue*2.5;
    NSLog(@"offsetValue:%f value:%f",offsetValue,panControlValue);
//    btn1.transform = CGAffineTransformMakeScale(pantographValue, pantographValue);
//    btn2.transform = CGAffineTransformMakeScale(pantographValue, pantographValue);
}

#pragma makr - 粒子动画
- (void)downView
{
    _fireEmitter=[[CAEmitterLayer alloc]init];
    _fireEmitter.emitterPosition=CGPointMake(self.view.frame.size.width/2,MainScreenHeight/heightV * 2);
    _fireEmitter.emitterSize=CGSizeMake(self.view.frame.size.width-100, 12);
    _fireEmitter.renderMode = kCAEmitterLayerAdditive;
    //发射单元
    //火焰
    CAEmitterCell * fire = [CAEmitterCell emitterCell];
    fire.birthRate=800;
    fire.lifetime=0.5;
    fire.lifetimeRange=1.5;
    fire.color=[[UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1]CGColor];
    fire.contents=(id)[[UIImage imageNamed:@"选中"]CGImage];
    [fire setName:@"fire"];
    
    fire.velocity=160;
    fire.velocityRange=80;
    fire.emissionLongitude=M_PI+M_PI_2;
    fire.emissionRange=M_PI_2;
    
    
    fire.scaleSpeed=0.3;
    fire.spin=0.2;
    
    //烟雾
    CAEmitterCell * smoke = [CAEmitterCell emitterCell];
    smoke.birthRate=400;
    smoke.lifetime=0.6;
    smoke.lifetimeRange=1.5;
    smoke.color=[[UIColor colorWithRed:1 green:1 blue:1 alpha:0.05]CGColor];
    smoke.contents=(id)[[UIImage imageNamed:@"选中"]CGImage];
    [fire setName:@"smoke"];
    
    smoke.velocity=250;
    smoke.velocityRange=100;
    smoke.emissionLongitude=M_PI+M_PI_2;
    smoke.emissionRange=M_PI_2;
    
    _fireEmitter.emitterCells=[NSArray arrayWithObjects:smoke,fire,nil];
    [self.view.layer addSublayer:_fireEmitter];
    
}

//#pragma mark - scrollView delegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    NSLog(@"滚动了");
//    [_scrollView setFrame:Rect(0, MainScreenHeight/3, MainScreenWidth, MainScreenHeight/3*2)];
//}
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    NSLog(@"拉动了");
//}
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
