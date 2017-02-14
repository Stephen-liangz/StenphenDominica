//
//  PersonRelationshipModel.h
//  StephenDominica
//
//  Created by 钟亮 on 2017/1/6.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonRelationshipModel : NSObject


//我
@property (nonatomic,assign) NSInteger masterpid;

//关系类型 是
@property (nonatomic,assign) NSInteger type;

//关系人 的 谁
@property (nonatomic,assign) NSInteger personId;

//初始化
- (id)initWithDic:(NSDictionary *)dic;

@end
