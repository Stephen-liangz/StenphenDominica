//
//  PuShuListViewController.m
//  StephenDominica
//
//  Created by 钟亮 on 2017/2/7.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "PuShuListViewController.h"

#import "JQVCHeaders.h"

#import "PushuCollectionViewCell.h"

#import "JQPushuMenuViewController.h"

@interface PuShuListViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSArray *_dataArray;
    NSArray *_btnInfoArray;
    NSArray *_urlArray;
    NSString *_url;
}
@property (nonatomic, strong)UIView *switchTypeView;/// 切换谱书列表类型

@property (nonatomic, strong)UICollectionView *collectionView;/// 显示的collectionView
@property (nonatomic, strong)UICollectionViewFlowLayout *layout;/// 显示的collection的layout

@end

@implementation PuShuListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initData];
    [self loadUI];
    
    [self loadData];
}
- (void)initData
{
    _dataArray = [NSArray array];
    _btnInfoArray = @[@"我创建的谱书",@"我参与的谱书"];
    _urlArray = @[@"get_my_genealogy.do?callback",@"get_my_join_genealogy.do?callback"];
    
    _url = _urlArray[0];
}

- (void)loadUI
{
    self.title = @"我创建的谱书";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.switchTypeView];
    [self.view addSubview:self.collectionView];
}

- (void)loadData
{
    NSDictionary *dic = @{
                          
                          };

    BBNetwork *bbNetwork = [[BBNetwork alloc]initWithUrlStr:_url andPramDic:dic];
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

- (void)switchListTypeAction:(UIButton *)btn
{
    [self setTitle:_btnInfoArray[btn.tag - 100]];
    _url = _urlArray[btn.tag - 100];
    [self loadData];
}

- (UIView *)switchTypeView
{
    if (!_switchTypeView) {
        
        _switchTypeView = [[UIView alloc]initWithFrame:Rect(0, 0, MainScreenWidth, 45)];
        
        
        for (int i = 0; i < _btnInfoArray.count; i ++ ) {
            UIButton *btn = [[UIButton alloc]initWithFrame:Rect(i*MainScreenWidth/_btnInfoArray.count, 0, MainScreenWidth/_btnInfoArray.count, 45)];
            [btn setTitle:_btnInfoArray[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            btn.tag = 100 + i;
            [btn addTarget:self action:@selector(switchListTypeAction:) forControlEvents:UIControlEventTouchUpInside];
            [_switchTypeView addSubview:btn];
        }
    }
    return _switchTypeView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        _collectionView = [[UICollectionView alloc]initWithFrame:Rect(0, 45, MainScreenWidth, MainScreenHeight - 64 - 45) collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
//        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PushuCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"cellid"];
    }
    
    return _collectionView;
}

- (UICollectionViewFlowLayout *)layout
{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc]init];
        // 定义大小
        _layout.itemSize = CGSizeMake(MainScreenWidth/2 - 2, MainScreenWidth/2 - 2);
        // 设置最小行间距
        _layout.minimumLineSpacing = 2;
        // 设置垂直间距
        _layout.minimumInteritemSpacing = 2;
        // 设置滚动方向（默认垂直滚动）
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _layout;
}

#pragma mark === collectionView 代理 数据源 delegate dataSource
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = _dataArray[indexPath.row];
    NSLog(@"谱书信息 %@",dic);
    
    JQPushuMenuViewController *vc = [[JQPushuMenuViewController alloc]init];
    vc.title = dic[@"familyname"];
    vc.gidStr = dic[@"gid"];
    [self basePushViewController:vc animated:YES];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PushuCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    cell.titleLab.text = _dataArray[indexPath.row][@"familyname"];
    
    [cell.imgView loadImageViewUrl:[NSString stringWithFormat:@"%@%@",[YTKNetworkConfig sharedConfig].cdnUrl,_dataArray[indexPath.row][@"cover"]] placehodler:[UIImage imageNamed:@"穿越时空"]];
    
    
    
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
