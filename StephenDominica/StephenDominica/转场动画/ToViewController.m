//
//  ToViewController.m
//  StephenDominica
//
//  Created by Mac on 16/5/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "ToViewController.h"
#import "Masonry.h"
#import "PresentVCTransition.h"

@interface ToViewController ()<UIViewControllerTransitioningDelegate>


@end

@implementation ToViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    UITextView *textView = [UITextView new];
    textView.text = @"wazrx";
    textView.font = [UIFont systemFontOfSize:16];
    textView.editable = NO;
    [self.view addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(200);
    }];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点我或向下滑动dismiss" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(textView.mas_bottom).offset(20);
    }];
}

- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
//    return [XWCircleSpreadTransition transitionWithTransitionType:XWCircleSpreadTransitionTypePresent];
//}
//
//- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
//    return [XWCircleSpreadTransition transitionWithTransitionType:XWCircleSpreadTransitionTypeDismiss];
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
