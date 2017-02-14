//
//  FromViewController.m
//  StephenDominica
//
//  Created by Mac on 16/5/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "FromViewController.h"
#import "Masonry.h"
#import "ToViewController.h"
#import "PresentVCTransition.h"
//#import "XWInteractiveTransition.h"

@interface FromViewController ()<ZLPresentVCDelegate>
@property (nonatomic, strong) PresentVCTransition *interactivePush;
@end

@implementation FromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"首页呀";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"will.jpg"]];
    imageView.layer.cornerRadius = 10;
    imageView.layer.masksToBounds = YES;
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(70);
        make.size.mas_equalTo(CGSizeMake(250, 250));
    }];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点我present" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(imageView.mas_bottom).offset(30);
    }];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    

//    _interactivePush = [PresentVCTransition interactiveTransitionWithTransitionType:XWInteractiveTransitionTypePresent GestureDirection:XWInteractiveTransitionGestureDirectionUp];
//    typeof(self)weakSelf = self;
//    _interactivePush.presentConifg = ^(){
//        [weakSelf present];
//    };
//    [_interactivePush addPanGestureForViewController:self.navigationController];
}

- (void)present{
    ToViewController *presentedVC = [ToViewController new];
    presentedVC.delegate = self;
    [self presentViewController:presentedVC animated:YES completion:nil];
}

- (void)presentVCDissmiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPresent{
    return _interactivePush;
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
