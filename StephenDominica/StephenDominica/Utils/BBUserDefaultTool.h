//
//  BBUserDefaultTool.h
//  StephenDominica
//
//  Created by 钟亮 on 2017/2/7.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBUserDefaultTool : NSObject

+ (id)udGetDataForKey:(NSString*)key;

+ (void)udUpdateData:(id)data forKey:(NSString*)key;

+ (void)udDeleteDataForKey:(NSString*)key;

+ (void)clearUd;

@end
