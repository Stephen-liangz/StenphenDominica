//
//  UIView+ViewExtral.h
//  WorkLogger
//
//  Created by yjj on 14-5-17.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef __UIView_ProgressHUD__
    #define __UIView_ProgressHUD__
#endif

#ifndef UIViewHUDHoldOnMessage
    #define UIViewHUDHoldOnMessage @"请稍后.."
#endif

#ifndef UIViewHUDDismissDuration
    #define UIViewHUDDismissDuration 0.5
#endif

@interface UIView (ProgressHUD)

///需要dismiss
- (void)showHUDHoldOn;
- (void)showHUD:(NSString *)message;

///dismiss
- (void)dismissHUD;
- (void)dismissHUDWithError:(NSString *)error;
- (void)dismissHUDWithSuccess:(NSString *)success;
- (void)dismissHUDWithErrorDefult;
- (void)dismissHUDWithSuccessDefult;

///自动dismiss
- (void)showDurationHUD:(NSString *)message;
- (void)showHUD:(NSString *)message duration:(NSTimeInterval)duration;
- (void)showDurationHUDWithError:(NSString *)error;
- (void)showHUDWithError:(NSString *)error duration:(NSTimeInterval)duration;
- (void)showDurationHUDWithSuccess:(NSString *)success;
- (void)showHUDWithSuccess:(NSString *)success duration:(NSTimeInterval)duration;

@end
