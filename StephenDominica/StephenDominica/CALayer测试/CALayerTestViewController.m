//
//  CALayerTestViewController.m
//  StephenDominica
//
//  Created by Mac on 16/7/6.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "CALayerTestViewController.h"
#import "NSData+Base64Additions.h"
#import "SKPSMTPMessage.h"

@interface CALayerTestViewController ()<SKPSMTPMessageDelegate>

@property (nonatomic, strong)UIButton *layerBtn1;///< 阴影/旋转/border

@end

@implementation CALayerTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigatBackButton];
    
    self.title = @"CALayer测试";

    [self loadUI];
    
    [self email];
}

- (void)email
{
    SKPSMTPMessage *testMsg = [[SKPSMTPMessage alloc] init];
    
    
    [testMsg setSubject:@"我是主题"];  // 设置邮件主题
    [testMsg setFromEmail:@"1025186146@qq.com"]; // 目标邮箱
    [testMsg setToEmail:@"969771358@qq.com"]; // 发送者邮箱
    [testMsg setRelayHost:@"smtp.qq.com"]; // 发送邮件代理服务器
    [testMsg setRequiresAuth:YES];
    [testMsg setLogin:@"1025186146@qq.com"]; // 发送者邮箱账号
    [testMsg setPass:@"zl852460,"]; // 发送者邮箱密码
    [testMsg setWantsSecure:YES];  // 需要加密
    [testMsg setDelegate:self];
    
    // Only do this for self-signed certs!
     testMsg.validateSSLChain = NO;
    testMsg.delegate = self;
    
    NSDictionary *plainPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey,
                               [NSString stringWithCString:"测试正文" encoding:NSUTF8StringEncoding],kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    
    NSString *vcfPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"vcf"];
    NSData *vcfData = [NSData dataWithContentsOfFile:vcfPath];
    
    NSDictionary *vcfPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/directory;\r\n\tx-unix-mode=0644;\r\n\tname=\"test.vcf\"",kSKPSMTPPartContentTypeKey,
                             @"attachment;\r\n\tfilename=\"test.vcf\"",kSKPSMTPPartContentDispositionKey,[vcfData encodeBase64ForData],kSKPSMTPPartMessageKey,@"base64",kSKPSMTPPartContentTransferEncodingKey,nil];
    
    testMsg.parts = [NSArray arrayWithObjects:plainPart,vcfPart, nil];
    
    [testMsg send];
}
- (void)messageSent:(SKPSMTPMessage *)message
{
    NSLog(@"成功了吗%@", message);
}
- (void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error
{
    NSLog(@"失败啦啊啊啊message - %@\nerror - %@", message, error);
}
#pragma mark - load ui
- (void)loadUI
{
    [self initlayerBtn1];
}

#pragma mark - layerBtn1
- (void)initlayerBtn1
{
    [self.layerBtn1 setFrame:Rect(MainScreenWidth/3, 10, MainScreenWidth/3, MainScreenWidth/3)];
    [_layerBtn1 setTitle:@"test1" forState:UIControlStateNormal];
    [_layerBtn1 setImage:[UIImage imageNamed:@"穿越时空"] forState:UIControlStateNormal];
    [self.view addSubview:_layerBtn1];
    
    [_layerBtn1 addTarget:self action:@selector(layerBtn1Action) forControlEvents:UIControlEventTouchUpInside];
    
    _layerBtn1.layer.shadowColor = [UIColor redColor].CGColor;
    _layerBtn1.layer.shadowOffset = CGSizeMake(10, 10);
    _layerBtn1.layer.shadowOpacity = 0.5;
    
    
    
//    UIImageView *img = [[UIImageView alloc]initWithFrame:Rect(MainScreenWidth/3, _layerBtn1.bottom, MainScreenWidth/3, MainScreenWidth/3)];
//    [img setImage:[UIImage imageNamed:@"穿越时空"]];
//    [self.view addSubview:img];
//    
//    img.layer.shadowColor = [UIColor redColor].CGColor;
//    img.layer.shadowOffset = CGSizeMake(45, 45);
//    img.layer.shadowOpacity = 0.5;
}

- (void)layerBtn1Action
{

    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        _layerBtn1.layer.transform = CATransform3DMakeRotation(M_PI/2,0, 0, 1);
        
    } completion:^(BOOL finished) {
        
        
    }];
    
    [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
        
        _layerBtn1.layer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
        
    } completion:^(BOOL finished) {
        
        
    }];
    [UIView animateWithDuration:0.5 delay:1 options:UIViewAnimationOptionCurveLinear animations:^{
        
        _layerBtn1.layer.transform = CATransform3DMakeRotation(M_PI/2*3, 0, 0, 1);
        
    } completion:^(BOOL finished) {
//        _layerBtn1.layer.transform = CATransform3DMakeRotation(0, 0, 0, 0);
        
    }];
    
    [UIView animateWithDuration:0.5 delay:1.5 options:UIViewAnimationOptionCurveLinear animations:^{
        
        _layerBtn1.layer.transform = CATransform3DMakeRotation(M_PI*2, 0, 0, 1);
        
    } completion:^(BOOL finished) {
        //        _layerBtn1.layer.transform = CATransform3DMakeRotation(0, 0, 0, 0);
        
    }];
    
    
   
}

- (UIButton *)layerBtn1
{
    if (!_layerBtn1) {
        _layerBtn1 = [[UIButton alloc]init];
    }
    return _layerBtn1;
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
