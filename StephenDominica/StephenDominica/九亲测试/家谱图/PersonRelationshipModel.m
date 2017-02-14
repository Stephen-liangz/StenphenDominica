//
//  PersonRelationshipModel.m
//  StephenDominica
//
//  Created by 钟亮 on 2017/1/6.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "PersonRelationshipModel.h"

@implementation PersonRelationshipModel

@synthesize masterpid = _masterpid;
@synthesize type = _type;
@synthesize personId = _personId;

- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if(self)
    {
        _masterpid = [[dic objectForKey:@"masterpid"] integerValue];
        _type = [[dic objectForKey:@"type"] integerValue];
        _personId = [[dic objectForKey:@"personId"] integerValue];
    }
    return self;
}

@end
