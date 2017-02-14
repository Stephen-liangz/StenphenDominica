//
//  FamilyTreeLinkedList.h
//  StephenDominica
//
//  Created by 钟亮 on 2017/1/6.
//  Copyright © 2017年 Mac. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "PersonInfoModel.h"

@interface FamilyTreeLinkedList : NSObject
{
    NSMutableArray *_list;
}
@property (nonatomic, strong) NSMutableArray *list;

- (void)addNode:(PersonInfoModel *)node;
- (void)removeNodeAtIndex:(int)index;
- (NSArray *)nodesOfNode:(PersonInfoModel *)node withRelation:(NSInteger )relationType;
- (NSMutableArray *)getRootNodes;
//得到家谱图展示数组 数组
- (NSMutableArray *)getTreeViewData;
@end
