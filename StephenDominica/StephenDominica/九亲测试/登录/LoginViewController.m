//
//  LoginViewController.m
//  StephenDominica
//
//  Created by 钟亮 on 2017/1/17.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "LoginViewController.h"

#import "JQVCHeaders.h"

@interface LoginViewController ()


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"登录一次就够了";
 
    
    [self setupNetworkConfig];
    
}


- (void)setupNetworkConfig
{
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = @"http://192.168.1.115:8080/pushu/api/";
    config.cdnUrl = @"http://192.168.1.115:8080/pushu/";
}
- (IBAction)reqVerCodeAction:(id)sender {

    // 1.根据网址初始化OC字符串对象
    NSString *urlStr = @"http://192.168.1.115:8080/pushu/api/verify_code.do";
    // 2.创建NSURL对象
    NSURL *url = [NSURL URLWithString:urlStr];
    // 3.创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // 4.创建参数字符串对象
    NSString *parmStr = @"";
    // 5.将字符串转为NSData对象
    NSData *pramData = [parmStr dataUsingEncoding:NSUTF8StringEncoding];
    // 6.设置请求体
    [request setHTTPBody:pramData];
    // 7.设置请求方式
    [request setHTTPMethod:@"POST"];
    // 创建同步链接
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    UIImage *vImage = [UIImage imageWithData:data];
    
    [_verificationCodeImv setImage:vImage];
    
    
}

- (IBAction)pushVC:(id)sender {
    [self basePushViewController:[[NSClassFromString(@"GuideViewController") alloc] init] animated:YES];
}

- (IBAction)loginBtnAction:(id)sender {
    if (_passwordTF.text.length > 0 && _userNameTF.text.length > 0) {
        
        NSDictionary *dic = @{
                              @"account":_userNameTF.text,
                              @"password":_passwordTF.text,
                              @"vcode":_verificationTF.text
                              };
        NSString *url = @"login.do?callback";
        
        BBNetwork *bbNetwork = [[BBNetwork alloc]initWithUrlStr:url andPramDic:dic];
        [bbNetwork startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            
            NSLog(@"请求成功 %@", request.responseJSONObject);
            
            NSInteger flagV = [request.responseJSONObject[@"flag"] integerValue];
            
            if (flagV == 0) {
                [self.view showMessage:request.responseJSONObject[@"msg"]];
            }else{
//                [BBUserDefaultTool udUpdateData:request.responseJSONObject[@"data"] forKey:@"userInfo"];
                
                [self basePushViewController:[[NSClassFromString(@"GuideViewController") alloc] init] animated:YES];
                
                
            }
            
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            NSLog(@"=====请求失败===== %@",request);
            
        }];
        
    }else{
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    //    //    串行队列
    //    //使用dispatch_queue_create函数创建串行队列
    //    dispatch_queue_t queue1 = dispatch_queue_create("codeingQueue", NULL);// 队列名称， 队列属性，一般用NULL即可
    //    //使用dispatch_get_main_queue()获得主队列,主队列是GCD自带的一种特殊的串行队列,放在主队列中的任务，都会放到主线程中执行
    //    dispatch_queue_t queue2 = dispatch_get_main_queue();
    //
    //    //    并行队列
    //    //使用dispatch_get_global_queue函数获得全局的并发队列
    //    dispatch_queue_t queue3 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //
    //
    //
    //    dispatch_async(queue1, ^{
    //        NSLog(@"串行队列 --> 1 %@",[NSThread currentThread]);
    //    });
    //
    //    dispatch_async(queue2, ^{
    //        NSLog(@"主队列 --> 2 %@",[NSThread currentThread]);
    //    });
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
