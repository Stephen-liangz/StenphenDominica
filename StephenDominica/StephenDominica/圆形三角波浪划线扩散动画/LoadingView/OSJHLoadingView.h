//
//  OSJHLoadingView.h
//  StephenDominica
//
//  Created by Mac on 16/6/22.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OSJHLoadingViewDelegate <NSObject>

- (void)completeAnimation;

@end

@interface OSJHLoadingView : UIView

@property (weak, nonatomic) id<OSJHLoadingViewDelegate>delegate;

@end
