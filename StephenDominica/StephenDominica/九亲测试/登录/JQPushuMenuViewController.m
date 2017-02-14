//
//  JQPushuMenuViewController.m
//  StephenDominica
//
//  Created by 钟亮 on 2017/2/10.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "JQPushuMenuViewController.h"
#import "JQVCHeaders.h"

@interface JQPushuMenuViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *_dataArray;///数据源
}

@property (nonatomic, strong)UITableView *tableView;///tableview

@end

@implementation JQPushuMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    
    [self loadUI];
    
    [self loadData];
}

- (void)initData
{
    _dataArray = [NSArray array];
    
    
}

- (void)loadUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
}

- (void)loadData
{
    
    NSDictionary *dic = @{
                          @"gid" : _gidStr
                          };
    BBNetwork *bbNetwork = [[BBNetwork alloc]initWithUrlStr:@"choice_genealogy.do?callback" andPramDic:dic];
    [bbNetwork startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        NSLog(@"请求成功 %@", request.responseJSONObject);
        
        if ([request.responseJSONObject[@"flag"] integerValue] == 1) {
            _dataArray = request.responseJSONObject[@"data"];
            [_tableView reloadData];
        }else{
            [self.view showMessage:request.responseJSONObject[@"msg"]];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"=====请求失败===== %@",request);
    }];
}

#pragma mark - tableview
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:Rect(0, 0, MainScreenWidth, MainScreenHeight - 64)];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self cleanTableViewLine:_tableView];
    }
    
    return _tableView;
}

#pragma mark - tableview 代理 数据源
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary *dic = _dataArray[indexPath.row];
    
    cell.indentationWidth = 30.f; // 每个缩进级别的距离
    if ([dic[@"parent"] integerValue] != 0) {
        cell.indentationLevel = 1;
        cell.textLabel.font = [UIFont systemFontOfSize:14.5];
    }else{
        cell.indentationLevel = 0;
        cell.textLabel.font = [UIFont systemFontOfSize:17 weight:15];
    }
    
    cell.textLabel.text = dic[@"menuName"];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.;
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
