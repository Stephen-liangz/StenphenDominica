//
//  BaseViewController.h
//  lucheren
//
//  Created by jzkj on 16/1/8.
//  Copyright © 2016年 jzkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Constant.h"
#import "UIViewExt.h"
#import "UIView+ToastShowExtral.h"
#import "Masonry.h"
#import "UIView+SDAutoLayout.h"
#import "UIView+ProgressHUD.h"
#import "UIView+FrameExtral.h"
#import "UIImageView+WithUrl.h"

@interface BaseViewController : UIViewController<UIAlertViewDelegate,UIGestureRecognizerDelegate>

@property (assign, nonatomic)BOOL noSilde;

- (void)setNavigatBackButton;

- (void)setNavigatBarButtonItem:(NSString*)imageName action:(SEL)action isLeft:(BOOL)left;

- (void)leftNavigatButtonClicked;

- (void)rightNavigatButtonClicked;

- (void)setView:(UIView*)view borderWidth:(CGFloat)width borderColor:(UIColor*)color;

- (void)setView:(UIView*)view CornerRadius:(CGFloat)Radius;

- (void)cleanTableViewLine:(UITableView*)tableView;

- (void)basePushViewController:(UIViewController*)controller animated:(BOOL)animated;

- (void)alert:(NSString*)title message:(NSString*)message canceButton:(NSString*)cancel ohter:(NSString*)ohter tag:(NSInteger)tag;


@end
