//
//  UIImageView+WithUrl.h
//  lucheren
//
//  Created by jzkj on 16/1/8.
//  Copyright © 2016年 jzkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WithUrl)

- (void)loadImageViewUrl:(NSString*)urlString;

- (void)loadImageViewUrl:(NSString *)urlString blcok: (void (^)(UIImage* image))blcok;

- (void)loadImageViewUrl:(NSString *)urlString placehodler:(UIImage*)placeImage;

@end
