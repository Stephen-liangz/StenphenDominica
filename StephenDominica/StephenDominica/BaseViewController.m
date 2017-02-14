//
//  BaseViewController.m
//  lucheren
//
//  Created by jzkj on 16/1/8.
//  Copyright © 2016年 jzkj. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController()

@end

@implementation BaseViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeLeft|UIRectEdgeBottom|UIRectEdgeRight;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];

    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)setNavigatBackButton
{
    [self setNavigatBarButtonItem:@"通用返回" action:@selector(leftNavigatButtonClicked) isLeft:YES];
}

- (void)setNavigatBarButtonItem:(NSString*)imageName action:(SEL)action isLeft:(BOOL)left
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:Rect(0, 0, 32, 32)];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView:button];
    if (left) {
        self.navigationItem.leftBarButtonItem = item;
    }
    else
        self.navigationItem.rightBarButtonItem = item;
}

- (void)setView:(UIView*)view borderWidth:(CGFloat)width borderColor:(UIColor*)color;
{
    view.layer.borderWidth = width;
    view.layer.borderColor = [color CGColor];
}

- (void)setView:(UIView *)view CornerRadius:(CGFloat)Radius
{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = Radius;
}

- (void)cleanTableViewLine:(UITableView*)tableView
{
    UIView* view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    
    [tableView setTableFooterView:view];
}

- (void)leftNavigatButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightNavigatButtonClicked
{
    
}

- (void)basePushViewController:(UIViewController *)controller animated:(BOOL)animated
{
    [self.view endEditing:YES];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:animated];
}

- (void)alert:(NSString*)title message:(NSString*)message canceButton:(NSString*)cancel ohter:(NSString*)ohter tag:(NSInteger)tag
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancel otherButtonTitles:ohter, nil];
    alert.tag = tag;
    [alert show];
}
#pragma mark - 滑动返回
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
}
#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([self isRootViewController]) {
        return NO;
    } else {
        if (_noSilde) {
            return NO;
        }
        return YES;
    }
}
#pragma mark - Private Method

- (BOOL)isRootViewController
{
    return (self == self.navigationController.viewControllers.firstObject);
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}


@end
