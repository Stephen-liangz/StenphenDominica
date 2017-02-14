//
//  PersonInfoModel.h
//  StephenDominica
//
//  Created by 钟亮 on 2017/1/6.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonRelationshipModel.h"

@interface PersonInfoModel : NSObject

- (id)initWithDic:(NSDictionary *)dic;
- (void)addRelationWithID:(NSInteger)pId2 relation:(NSInteger)relationType;

#pragma mark - 关系
@property (nonatomic, strong) NSMutableArray *relations;
#pragma mark - 个人信息
//个人
@property (nonatomic,assign) NSInteger pId;
//谱书id
@property (nonatomic,assign) NSInteger gId;
//支系id
@property (nonatomic,assign) NSInteger branchId;
//世代
@property (nonatomic,assign) NSInteger ggen;
//排行
@property (nonatomic,assign) NSInteger arrangenum;
//姓
@property (nonatomic,strong) NSString *surname;
///谱名
@property (nonatomic,strong) NSString *genealogyname;
//
@property (nonatomic,strong) NSString *sex;
//
@property (nonatomic,strong) NSString *hzinfo;
//
@property (nonatomic,strong) NSString *avatar;
//亲生父亲id
@property (nonatomic,assign) NSInteger fatherId;///亲生父亲id
//
@property (nonatomic,strong) NSString *hasChildrens;
//
@property (nonatomic,strong) NSString *islive;
//
@property (nonatomic,strong) NSString *isadoption;
///是否被挑
@property (nonatomic,strong) NSString *ispyiq;///是否被挑

//是否为根节点
@property (nonatomic,assign) BOOL root;

@end
