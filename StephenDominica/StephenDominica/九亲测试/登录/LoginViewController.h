//
//  LoginViewController.h
//  StephenDominica
//
//  Created by 钟亮 on 2017/1/17.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginViewController : BaseViewController

@property (strong, nonatomic) IBOutlet UITextField *userNameTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;
@property (strong, nonatomic) IBOutlet UITextField *verificationTF;
@property (strong, nonatomic) IBOutlet UIButton *reqVerificationCodeBtn;
@property (strong, nonatomic) IBOutlet UIImageView *verificationCodeImv;

@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UIButton *goBtn;

@end
