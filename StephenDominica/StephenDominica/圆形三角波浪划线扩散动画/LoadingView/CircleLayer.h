//
//  CircleLayer.h
//  StephenDominica
//
//  Created by Mac on 16/6/22.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CircleLayer : CAShapeLayer

/**
 扩大动画
 **/
- (void)expand;///<   扩大动画

- (void)wobbleAnimation;///<    摇晃动画

- (void)contract;///<   联系动画

@end
