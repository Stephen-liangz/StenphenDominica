//
//  UIView+ViewExtral.m
//  WorkLogger
//
//  Created by yjj on 14-5-17.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "UIView+ProgressHUD.h"
#import "MMProgressHUD.h"

@implementation UIView (ProgressHUD)

- (void)showHUDHoldOn{
    [self showHUD:UIViewHUDHoldOnMessage];
}

- (void)showHUD:(NSString *)message{
    if([[MMProgressHUD sharedHUD] presentationStyle] != MMProgressHUDPresentationStyleFade){
        [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    }
    [MMProgressHUD showWithStatus:message];
}

- (void)dismissHUD{
    [MMProgressHUD dismiss];
}

- (void)dismissHUDWithError:(NSString *)error{
    [MMProgressHUD dismissWithError:error];
}

- (void)dismissHUDWithSuccess:(NSString *)success{
    [MMProgressHUD dismissWithSuccess:success];
}

- (void)dismissHUDWithErrorDefult {
    [MMProgressHUD dismissWithError:@"网络繁忙,请稍后再试!"];
}

- (void)dismissHUDWithSuccessDefult {
    [MMProgressHUD dismissWithSuccess:@"暂无更多数据!"];
}

///自动dismiss
- (void)showDurationHUD:(NSString *)message{
    [self showHUD:message duration:UIViewHUDDismissDuration];
}

- (void)showHUD:(NSString *)message duration:(NSTimeInterval)duration{
    [self showHUD:message];
    [MMProgressHUD dismissAfterDelay:UIViewHUDDismissDuration];
}

- (void)showDurationHUDWithError:(NSString *)error{
    [self showHUDWithError:error duration:UIViewHUDDismissDuration];
}

- (void)showHUDWithError:(NSString *)error duration:(NSTimeInterval)duration{
    [[[MMProgressHUD sharedHUD] hud] setCompletionState:MMProgressHUDCompletionStateError];
    [self showHUD:error];
    [MMProgressHUD dismissAfterDelay:duration];
}

- (void)showDurationHUDWithSuccess:(NSString *)success{
    [self showHUDWithSuccess:success duration:UIViewHUDDismissDuration];
}

- (void)showHUDWithSuccess:(NSString *)success duration:(NSTimeInterval)duration{
    [[[MMProgressHUD sharedHUD] hud] setCompletionState:MMProgressHUDCompletionStateSuccess];
    [self showHUD:success];
    [MMProgressHUD dismissAfterDelay:duration];
}

@end
