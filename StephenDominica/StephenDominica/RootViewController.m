//
//  RootViewController.m
//  StephenDominica
//
//  Created by Mac on 16/5/27.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "RootViewController.h"
#import "BaseViewController.h"

@interface RootViewController ()
@property (nonatomic, copy) NSArray *data;///< 数组呀
@property (nonatomic, copy) NSArray *viewControllers;///< 呀
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"StephenDominica";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationController.navigationBar.translucent = NO;


}


#pragma mark - lazyLoding
- (NSArray *)data{
    if (!_data) {
        _data = [@[
                   @"Paint Code 画图",
                   @"邻信首页模式",
                   @"粒子动画",
                   @"UIBezierPath实现果冻效果",
                   @"文字闪现Label",
                   @"百度地图",
                   @"动画-圆形.三角冒尖.划线.波浪.扩散",
                   @"CALayer测试",
                   @"发邮件啦啊啊啊啊",
                   @"九亲家谱测试"]
                 copy];
    }
    return _data;
}

- (NSArray *)viewControllers{
    if (!_viewControllers) {
        _viewControllers = [@[
                              @"PaintCodeViewController",
                              @"LXHomePageViewController",
                              @"FireEmitterViewController",
                              @"BezierPathViewController",
                              @"TextFlashesViewController",
                              @"BaiduMapViewController",
                              @"OSJHAnimationViewController",
                              @"CALayerTestViewController",
                              @"EmailViewController",
                              @"LoginViewController"
                              ] copy];
    }
    return _viewControllers;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _data[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseViewController *vc = [[NSClassFromString(self.viewControllers[indexPath.row]) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
