//
//  FamilyTreeLinkedList.m
//  StephenDominica
//
//  Created by 钟亮 on 2017/1/6.
//  Copyright © 2017年 Mac. All rights reserved.
//


#import "FamilyTreeLinkedList.h"
#import "PersonRelationshipModel.h"

@interface FamilyTreeLinkedList ()
{
    NSMutableArray *treeDataArray;
    NSInteger processedCount;
}

@end

@implementation FamilyTreeLinkedList
@synthesize list = _list;

- (id)init
{
    self = [super init];
    if (self) {
        _list = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)addNode:(PersonInfoModel *)node
{
    [_list addObject:node];
}

- (void)removeNodeAtIndex:(int)index
{
    [_list removeObjectAtIndex:index];
}

// 查询和某一节点有相同关系的节点
- (NSArray *)nodesOfNode:(PersonInfoModel *)node withRelation:(NSInteger )relationType
{
    NSMutableArray *array = [NSMutableArray array];
    for (PersonInfoModel *p in _list) {
        
        for (PersonRelationshipModel *r in p.relations) {
            if (r.personId == node.pId && r.type == relationType) {
                [array addObject:p];
            }
        }
        
        
    }
    return array;
}

//查询根节点
- (NSMutableArray *)getRootNodes
{
    NSMutableArray *array = [NSMutableArray array];
    for (PersonInfoModel *p in _list) {
        BOOL isChild = NO;
        
        for (PersonRelationshipModel *r in p.relations) {
            if (r.type == 2) {
                isChild = YES;
            }
        }
        
        if (!isChild) {
            [array addObject:p];
        }
    }

    return array;
}

//生成家谱树展示UI数据
- (NSMutableArray *)getTreeViewData
{
    treeDataArray = [NSMutableArray array];
    processedCount = 0;
    
    NSArray *rootArray = [self getRootNodes];
    
    [treeDataArray addObject:rootArray];
    
    processedCount = rootArray.count;
    
    [self getAgain];
    
    return treeDataArray;
}

- (void)getAgain{
    
    NSMutableArray *levelArray = [NSMutableArray array];
    
    NSArray *currentArray = treeDataArray[treeDataArray.count - 1];
    
    if (currentArray.count > 0) {
        for (int i = 0; i < currentArray.count; i ++) {
            
            PersonInfoModel *node = currentArray[i];
            NSArray *tempArray = [self nodesOfNode:node withRelation:2];
            //计数
            processedCount += tempArray.count;
        
            [levelArray addObjectsFromArray:tempArray];
        }
    }

    [treeDataArray addObject:levelArray];
    
//    判断是否判断遍历完所有数据
    if (processedCount < _list.count) {
        [self getAgain];
    }
}

@end
