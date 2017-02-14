//
//  PersonInfoModel.m
//  StephenDominica
//
//  Created by 钟亮 on 2017/1/6.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "PersonInfoModel.h"

@implementation PersonInfoModel

@synthesize relations = _relations;

- (id)init
{
    self = [super init];
    if(self)
    {
        _relations = [[NSMutableArray alloc]init];
    }
    return self;
}

- (id)initWithDic:(NSDictionary *)dic
{
    self = [self init];
    if(self)
    {
        
    }
    return self;
}
- (void)addRelationWithID:(NSInteger)pId2 relation:(NSInteger)relationType
{
    PersonRelationshipModel *r = [[PersonRelationshipModel alloc]init];
    r.masterpid = _pId;
    r.personId = pId2;
    r.type = relationType;
    [_relations addObject:r];
}

@end
