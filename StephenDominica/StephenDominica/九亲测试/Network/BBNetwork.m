//
//  BBNetwork.m
//  StephenDominica
//
//  Created by 钟亮 on 2017/2/7.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "BBNetwork.h"

@implementation BBNetwork
{
    NSString *_urlStr;
    NSDictionary *_pramDic;
}

- (instancetype)initWithUrlStr:(NSString *)urlStr andPramDic:(NSDictionary *)pramDic
{
    if (self = [super init]) {
        _pramDic = pramDic;
        _urlStr = urlStr;
    }
    
    return self;
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl
{
    return _urlStr;
}

- (id)requestArgument
{
    return _pramDic;
}

@end
