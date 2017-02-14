

//
//  GuideViewController.m
//  StephenDominica
//
//  Created by 钟亮 on 2017/2/9.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "GuideViewController.h"

#import "JQVCHeaders.h"

@interface GuideViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray *titleArray;///<功能名 数组
@property (nonatomic, copy) NSArray *vcArray;///< VC数组

@property (nonatomic, strong)UITableView *tableView;/// tableview

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self loadUI];
}


- (void)loadUI
{
    self.title = @"功能列表";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - 数据
- (NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = @[
                        @"谱书列表",
                        @"个人信息",
                        @"姓氏功能"
                        ];
    }
    
    return _titleArray;
}

- (NSArray *)vcArray
{
    if (!_vcArray) {
        _vcArray = @[
                        @"PuShuListViewController",
                        @"JQUserInfoViewController",
                        @"SurnameViewController"
                        ];
    }
    
    return _vcArray;
}

#pragma mark - tableView
- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:Rect(0, 0, MainScreenWidth, MainScreenHeight - 64)];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [self cleanTableViewLine:_tableView];
    }
    
    return _tableView;
}

#pragma mark - === tableview 代理 数据源

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseViewController *vc = [[NSClassFromString(self.vcArray[indexPath.row]) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = @"cellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = _titleArray[indexPath.row];
    
    return cell;
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
