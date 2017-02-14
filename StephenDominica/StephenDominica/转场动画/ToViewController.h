//
//  ToViewController.h
//  StephenDominica
//
//  Created by Mac on 16/5/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZLPresentVCDelegate <NSObject>

- (void)presentVCDissmiss;
- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPresent;
@end

@interface ToViewController : UIViewController

@property (nonatomic, assign) id<ZLPresentVCDelegate> delegate;

@end
