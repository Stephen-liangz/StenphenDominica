//
//  UIImageView+WithUrl.m
//  lucheren
//
//  Created by jzkj on 16/1/8.
//  Copyright © 2016年 jzkj. All rights reserved.
//

#import "UIImageView+WithUrl.h"

@implementation UIImageView (WithUrl)

- (void)loadImageViewUrl:(NSString*)urlString
{
    [self loadImageViewUrl:urlString placehodler:nil];
}

- (void)loadImageViewUrl:(NSString *)urlString placehodler:(UIImage*)placeImage
{
    if (placeImage) {
        self.image = placeImage;
    }
    NSURL* url = [NSURL URLWithString:urlString];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:url];
        if (data&& data.length) {
            UIImage* image = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image = image;
            });
        }
    });
}

- (void)loadImageViewUrl:(NSString *)urlString blcok: (void (^)(UIImage* image))blcok
{
    
    NSURL* url = [NSURL URLWithString:urlString];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:url];
        if (data&& data.length) {
            UIImage* image = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image = image;
                if (blcok) {
                    blcok(image);
                }
            });
        }
    });
}


@end
