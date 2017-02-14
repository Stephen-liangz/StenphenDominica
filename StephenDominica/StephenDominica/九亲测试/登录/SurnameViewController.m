//
//  SurnameViewController.m
//  StephenDominica
//
//  Created by 钟亮 on 2017/2/13.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "SurnameViewController.h"
#import "JQSurnameCollectionViewCell.h"
#import "JQVCHeaders.h"

@interface SurnameViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)UITextView *infoTextView;/// 切换谱书列表类型

@property (nonatomic, strong)UICollectionView *collectionView;/// 显示的collectionView
@property (nonatomic, strong)UICollectionViewFlowLayout *layout;/// 显示的collection的layout

@end

@implementation SurnameViewController
{
    NSArray *_dataArray;
}

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
    self.title = @"姓氏";
    
    [self.view addSubview:self.infoTextView];
    [self.view addSubview:self.collectionView];
}

- (void)loadData
{
    NSDictionary *dic = @{
                          
                          };
    
    BBNetwork *bbNetwork = [[BBNetwork alloc]initWithUrlStr:@"get_surname_select_list.do?callback" andPramDic:dic];
    [bbNetwork startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        NSLog(@"请求成功 %@", request.responseJSONObject);
        
        if ([request.responseJSONObject[@"flag"] integerValue] == 1) {
            _dataArray = request.responseJSONObject[@"data"];
            [_collectionView reloadData];
        }else{
            [self.view showMessage:request.responseJSONObject[@"msg"]];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"=====请求失败===== %@",request);
    }];
    
}

- (void)loadSurnameInfo:(NSString *)surnameId
{
    NSDictionary *dic = @{
                          @"sid":surnameId
                          };
    
    BBNetwork *bbNetwork = [[BBNetwork alloc]initWithUrlStr:@"get_surname_common.do?callback" andPramDic:dic];
    [bbNetwork startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        NSLog(@"请求成功 %@", request.responseJSONObject);
        
        if ([request.responseJSONObject[@"flag"] integerValue] == 1) {
            NSDictionary *dic = request.responseObject[@"data"];
            NSString *infoStr = [NSString stringWithFormat:@"%@ == %@\n%@\n%@\n%@",dic[@"cnname"],dic[@"ancestor"],dic[@"region"],dic[@"introduction"],dic[@"summary"]];
            _infoTextView.text = infoStr;
        }else{
            [self.view showMessage:request.responseJSONObject[@"msg"]];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSLog(@"=====请求失败===== %@",request);
    }];
}

- (UITextView *)infoTextView
{
    
    if (!_infoTextView) {
        _infoTextView = [[UITextView alloc]initWithFrame:Rect(10, 10, MainScreenWidth - 20, 160)];
        _infoTextView.backgroundColor = RGB(245, 245, 245);
        _infoTextView.font = [UIFont systemFontOfSize:14];
        _infoTextView.textColor = [UIColor darkGrayColor];
        _infoTextView.editable = NO;
    }
    
    return _infoTextView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        _collectionView = [[UICollectionView alloc]initWithFrame:Rect(0, 180, MainScreenWidth, MainScreenHeight - 64 - 180) collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([JQSurnameCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"cellid"];
    }
    
    return _collectionView;
}

- (UICollectionViewFlowLayout *)layout
{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc]init];
        // 定义大小
        _layout.itemSize = CGSizeMake(MainScreenWidth/5 - 5, MainScreenWidth/5 - 5);
        // 设置最小行间距
        _layout.minimumLineSpacing = 1;
        // 设置垂直间距
        _layout.minimumInteritemSpacing = 1;
        // 设置滚动方向（默认垂直滚动）
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _layout;
}

#pragma mark === collectionView 代理 数据源 delegate dataSource
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = _dataArray[indexPath.row];
    [self loadSurnameInfo:dic[@"id"]];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JQSurnameCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    
    cell.textLab.text = _dataArray[indexPath.row][@"surname"];
    
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
