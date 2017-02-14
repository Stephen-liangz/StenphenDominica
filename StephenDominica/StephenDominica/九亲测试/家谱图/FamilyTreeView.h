//
//  FamilyTreeView.h
//  StephenDominica
//
//  Created by 钟亮 on 2017/1/5.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FamilyTreeView : UIView

/**
 重画家谱树
 **/
- (void)redrawTreeViewWithPersonArray:(NSArray *)personArray;
/**
 画人物关系连线
 **/
- (void)drawRelationshipLine:(NSArray *)relationshipArray;

@end
