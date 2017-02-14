//
//  OSJHBaiduMapAnnotation.m
//  StephenDominica
//
//  Created by Mac on 16/6/14.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "OSJHBaiduMapAnnotation.h"

@implementation OSJHBaiduMapAnnotation

- (instancetype)initWithAnnotationModelWithDict:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.coordinateValue = CLLocationCoordinate2DMake([dic[@"latitute"] doubleValue], [dic[@"longitude"] doubleValue]);
        self.titleStr = dic[@"detail"];
        self.nameStr = dic[@"name"];
    }
    return self;
}
@end
