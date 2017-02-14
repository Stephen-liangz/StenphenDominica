//
//  BBNetwork.h
//  StephenDominica
//
//  Created by 钟亮 on 2017/2/7.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "YTKRequest.h"

@interface BBNetwork : YTKRequest

- (instancetype)initWithUrlStr:(NSString *)urlStr andPramDic:(NSDictionary *)pramDic;

@end
