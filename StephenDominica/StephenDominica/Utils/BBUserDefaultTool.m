//
//  BBUserDefaultTool.m
//  StephenDominica
//
//  Created by 钟亮 on 2017/2/7.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "BBUserDefaultTool.h"

@implementation BBUserDefaultTool

+ (id)udGetDataForKey:(NSString*)key
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    return [ud objectForKey:key];
}

+ (void)udUpdateData:(id)data forKey:(NSString*)key
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:data forKey:key];
    [ud synchronize];
}

+ (void)udDeleteDataForKey:(NSString*)key
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud removeObjectForKey:key];
    [ud synchronize];
}

+ (void)clearUd
{
    [NSUserDefaults resetStandardUserDefaults];
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    [ud synchronize];
}

@end
