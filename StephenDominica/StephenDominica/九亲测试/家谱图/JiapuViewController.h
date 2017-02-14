//
//  JiapuViewController.h
//  StephenDominica
//
//  Created by 钟亮 on 2017/1/5.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "BaseViewController.h"
#import "FamilyTreeLinkedList.h"

@interface JiapuViewController : BaseViewController
{
    FamilyTreeLinkedList *_list;
    NSMutableDictionary *_addDic;
}
@end
