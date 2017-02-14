
//
//  JiapuViewController.m
//  StephenDominica
//
//  Created by 钟亮 on 2017/1/5.
//  Copyright © 2017年 Mac. All rights reserved.
//


#import "JiapuViewController.h"
#import "FamilyTreeView.h"

#import "PersonRelationshipModel.h"
#import "PersonInfoModel.h"

//#import "MJExtension.h"

@interface JiapuViewController ()
{
    NSArray *relationShipArray;
    NSArray *personInfoArray;
}

@property (strong, nonatomic)FamilyTreeView *jiapuView;/// 家谱树展示View


@end

@implementation JiapuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"九亲家谱测试";
    
   
    
    [self.view addSubview:self.jiapuView];
    
     [self familyDataProcessing];
}

- (FamilyTreeView *)jiapuView
{
    if (!_jiapuView) {
        _jiapuView = [[FamilyTreeView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight - 64)];
    }
    return _jiapuView;
}

#pragma mark - 家谱树数据处理
- (void)familyDataProcessing
{
    [self setFamilyData];
    
    _addDic = [[NSMutableDictionary alloc]init];
    _list = [[FamilyTreeLinkedList alloc]init];
    
    for (PersonInfoModel *p in personInfoArray) {
        
        for (PersonRelationshipModel *r in relationShipArray) {
            if (r.masterpid == p.pId && r.personId > 0) {
                [p addRelationWithID:r.personId relation:r.type];
            }
        }
        [_list addNode:p];
    }
    
    [_jiapuView redrawTreeViewWithPersonArray:[_list getTreeViewData]];
    [_jiapuView drawRelationshipLine:relationShipArray];
    
    //    [self.view setNeedsDisplay];
 
    
}

#pragma mark - 家谱树数据初始化
- (void)setFamilyData
{
    PersonInfoModel *pm1 = [[PersonInfoModel alloc]init];
    pm1.pId = 21;
    pm1.fatherId = -1;
    pm1.sex = @"男";
    pm1.ggen = 1;
    pm1.arrangenum = 1;
    pm1.surname = @"敖";
    pm1.genealogyname = @"打个[zbiaiu]";
    pm1.root = YES;
    
    PersonInfoModel *pm2 = [[PersonInfoModel alloc]init];
    pm2.pId = 22;
    pm2.fatherId = 21;
    pm2.sex = @"男";
    pm2.surname = @"敖";
    pm2.genealogyname = @"555";
    pm2.ggen = 2;
    pm2.root = NO;
    
    PersonInfoModel *pm3 = [[PersonInfoModel alloc]init];
    pm3.pId = 23;
    pm3.fatherId = 21;
    pm3.sex = @"男";
    pm3.ggen = 2;
    pm3.arrangenum = 2;
    pm3.surname = @"敖";
    pm3.genealogyname = @"规格";
    pm3.root = NO;
    
    PersonInfoModel *pm4 = [[PersonInfoModel alloc]init];
    pm4.pId = 24;
    pm4.fatherId = 21;
    pm4.sex = @"男";
    pm4.ggen = 2;
    pm4.arrangenum = 3;
    pm4.surname = @"敖";
    pm4.genealogyname = @"打算";
    pm4.root = NO;
    
    PersonInfoModel *pm5 = [[PersonInfoModel alloc]init];
    pm5.pId = 25;
    pm5.fatherId = 23;
    pm5.sex = @"男";
    pm5.ggen = 3;
    pm5.arrangenum = 1;
    pm5.surname = @"敖";
    pm5.genealogyname = @"地方";
    pm5.root = NO;
    
    PersonInfoModel *pm6 = [[PersonInfoModel alloc]init];
    pm6.pId = 26;
    pm6.fatherId = 23;
    pm6.sex = @"男";
    pm6.ggen = 3;
    pm6.arrangenum = 2;
    pm6.surname = @"敖";
    pm6.genealogyname = @"丫丫";
    pm6.root = NO;
    
    PersonInfoModel *pm7 = [[PersonInfoModel alloc]init];
    pm7.pId = 27;
    pm7.fatherId = 26;
    pm7.sex = @"男";
    pm7.ggen = 4;
    pm7.arrangenum = 1;
    pm7.surname = @"敖";
    pm7.genealogyname = @"焦点";
    pm7.root = NO;
    
    PersonInfoModel *pm8 = [[PersonInfoModel alloc]init];
    pm8.pId = 28;
    pm8.fatherId = 26;
    pm8.sex = @"男";
    pm8.ggen = 4;
    pm8.arrangenum = 2;
    pm8.surname = @"敖";
    pm8.genealogyname = @"焦点2";
    pm8.root = NO;
    
    
    PersonInfoModel *pm9 = [[PersonInfoModel alloc]init];
    pm9.pId = 29;
    pm9.fatherId = 28;
    pm9.sex = @"男";
    pm9.ggen = 5;
    pm9.arrangenum = 1;
    pm9.surname = @"敖";
    pm9.genealogyname = @"大神";
    pm9.root = NO;
    
    PersonInfoModel *pm10 = [[PersonInfoModel alloc]init];
    pm10.pId = 30;
    pm10.fatherId = 28;
    pm10.sex = @"男";
    pm10.ggen = 5;
    pm10.arrangenum = 1;
    pm10.surname = @"敖";
    pm10.genealogyname = @"大神";
    pm10.root = NO;
    
    PersonInfoModel *pm11 = [[PersonInfoModel alloc]init];
    pm11.pId = 31;
    pm11.fatherId = 28;
    pm11.sex = @"男";
    pm11.ggen = 5;
    pm11.arrangenum = 1;
    pm11.surname = @"敖";
    pm11.genealogyname = @"大神";
    pm11.root = NO;
    
    PersonInfoModel *pm12 = [[PersonInfoModel alloc]init];
    pm12.pId = 32;
    pm12.fatherId = 28;
    pm12.sex = @"男";
    pm12.ggen = 5;
    pm12.arrangenum = 1;
    pm12.surname = @"敖";
    pm12.genealogyname = @"大神";
    pm12.root = NO;
    
    PersonInfoModel *pm13 = [[PersonInfoModel alloc]init];
    pm13.pId = 33;
    pm13.fatherId = 28;
    pm13.sex = @"男";
    pm13.ggen = 5;
    pm13.arrangenum = 1;
    pm13.surname = @"敖";
    pm13.genealogyname = @"大神";
    pm13.root = NO;
    
    PersonRelationshipModel *prm1 = [[PersonRelationshipModel alloc]init];
    prm1.masterpid = 21;
    prm1.type = 2;
    prm1.personId = -1;
    
    PersonRelationshipModel *prm2 = [[PersonRelationshipModel alloc]init];
    prm2.masterpid = 22;
    prm2.type = 2;
    prm2.personId = 21;
    
    PersonRelationshipModel *prm3 = [[PersonRelationshipModel alloc]init];
    prm3.masterpid = 23;
    prm3.type = 2;
    prm3.personId = 21;
    
    PersonRelationshipModel *prm4 = [[PersonRelationshipModel alloc]init];
    prm4.masterpid = 24;
    prm4.type = 2;
    prm4.personId = 21;
    
    PersonRelationshipModel *prm5 = [[PersonRelationshipModel alloc]init];
    prm5.masterpid = 25;
    prm5.type = 2;
    prm5.personId = 23;
    
    PersonRelationshipModel *prm6 = [[PersonRelationshipModel alloc]init];
    prm6.masterpid = 26;
    prm6.type = 2;
    prm6.personId = 23;
    
    PersonRelationshipModel *prm7 = [[PersonRelationshipModel alloc]init];
    prm7.masterpid = 27;
    prm7.type = 2;
    prm7.personId = 26;
    
    PersonRelationshipModel *prm8 = [[PersonRelationshipModel alloc]init];
    prm8.masterpid = 28;
    prm8.type = 2;
    prm8.personId = 26;
    
    PersonRelationshipModel *prm9 = [[PersonRelationshipModel alloc]init];
    prm9.masterpid = 29;
    prm9.type = 2;
    prm9.personId = 28;
    
    PersonRelationshipModel *prm10 = [[PersonRelationshipModel alloc]init];
    prm10.masterpid = 30;
    prm10.type = 2;
    prm10.personId = 28;
    
    PersonRelationshipModel *prm11 = [[PersonRelationshipModel alloc]init];
    prm11.masterpid = 31;
    prm11.type = 2;
    prm11.personId = 28;
    
    PersonRelationshipModel *prm12 = [[PersonRelationshipModel alloc]init];
    prm12.masterpid = 32;
    prm12.type = 2;
    prm12.personId = 28;
    
    PersonRelationshipModel *prm13 = [[PersonRelationshipModel alloc]init];
    prm13.masterpid = 33;
    prm13.type = 2;
    prm13.personId = 28;
    
//    relationShipArray = @[prm1,prm2,prm3,prm4,prm5,prm6,prm7,prm8,prm9,prm10,prm11,prm12,prm13];
//    personInfoArray = @[pm1,pm2,pm3,pm4,pm5,pm6,pm7,pm8,pm9,pm10,pm11,pm12,pm13];
    
    relationShipArray = @[prm1,prm2,prm3,prm4,prm5,prm6,prm7,prm8,prm9,prm10,prm11,prm12];
    personInfoArray = @[pm1,pm2,pm3,pm4,pm5,pm6,pm7,pm8,pm9,pm10,pm11,pm12];
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
