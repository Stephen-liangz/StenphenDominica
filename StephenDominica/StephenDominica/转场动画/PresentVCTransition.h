//
//  PresentVCTransition.h
//  StephenDominica
//
//  Created by Mac on 16/5/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZLPresntVCTransitionType){
    ZLPresntVCTransitionTypePresent = 0,
    ZLPresntVCTransitionTypeDismiss
};

@interface PresentVCTransition : NSObject <UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithTransitionType:(ZLPresntVCTransitionType)type;
- (instancetype)initWithTransitionType:(ZLPresntVCTransitionType)type;

@end
