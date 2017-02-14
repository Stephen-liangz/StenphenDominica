//
//  OSJHBaiduMapAnnotation.h
//  StephenDominica
//
//  Created by Mac on 16/6/14.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>

@interface OSJHBaiduMapAnnotation : BMKPointAnnotation <BMKAnnotation>

@property (nonatomic,assign) CLLocationCoordinate2D coordinateValue;
@property (nonatomic,copy) NSString *nameStr;
@property (nonatomic,copy) NSString *titleStr;

- (instancetype)initWithAnnotationModelWithDict:(NSDictionary *)dic;


@end
