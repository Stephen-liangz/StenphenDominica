//
//  JQUserInfoViewController.m
//  StephenDominica
//
//  Created by 钟亮 on 2017/2/9.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "JQUserInfoViewController.h"

#import "JQVCHeaders.h"

@interface JQUserInfoViewController ()

@property (nonatomic, strong)UITextView *infoTextView;///信息展示textview
@property (nonatomic, strong)UIImageView *headerImv;/// 头像imv

@end

@implementation JQUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
 
    [self loadUI];
    
    [self loadData];
}

- (void)loadUI
{
    self.title = @"个人信息功能";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.headerImv];
    [self.view addSubview:self.infoTextView];
}

- (void)loadData
{
    BBNetwork *bbNetwork = [[BBNetwork alloc]initWithUrlStr:@"get_login_info.do?callback" andPramDic:nil];
    [bbNetwork startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        NSLog(@"请求成功 %@", request.responseJSONObject);
        if ([request.responseJSONObject[K_flag] integerValue] == 1) {
            NSDictionary *dic = request.responseObject[K_data];
            
            NSArray * allkeys = [dic allKeys];

            
            for (int i = 0; i < allkeys.count; i++)
            {
                NSString *key = [allkeys objectAtIndex:i];
                NSString *value = [dic objectForKey:key];
                
                _infoTextView.text  = [NSString stringWithFormat:@"%@\n%@ --> %@",_infoTextView.text,key,value];
            }
            
        }else{
            [self.view showMessage:request.responseJSONObject[K_msg]];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"=====请求失败===== %@",request);
    }];
}

- (UIImageView *)headerImv
{
    
    if (!_headerImv) {
        _headerImv =[[UIImageView alloc]initWithFrame:Rect(MainScreenWidth/3, 20, MainScreenWidth/3, MainScreenWidth/3)];
        _headerImv.backgroundColor = [UIColor lightGrayColor];
    }
    
    return _headerImv;
}

- (UITextView *)infoTextView
{
    
    if (!_infoTextView) {
        _infoTextView = [[UITextView alloc]initWithFrame:Rect(10, MainScreenWidth/3 + 30, MainScreenWidth - 20, MainScreenHeight - 64 - MainScreenWidth/3 - 30 - 10)];
        _infoTextView.backgroundColor = RGB(245, 245, 245);
        _infoTextView.font = [UIFont systemFontOfSize:16];
        _infoTextView.textColor = [UIColor darkGrayColor];
        _infoTextView.editable = NO;
    }
    
    return _infoTextView;
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
