//
//  OSJHBaiduMapAnnotationView.m
//  StephenDominica
//
//  Created by Mac on 16/6/14.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "OSJHBaiduMapAnnotationView.h"
#import "OSJHBaiduMapAnnotation.h"

@implementation OSJHBaiduMapAnnotationView

- (instancetype)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //        在大头针旁边加一个label
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, -15, 50, 20)];
        self.label.textColor = [UIColor redColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:20];
        [self addSubview:self.label];
        
    }
    return self;
    
}
@end
