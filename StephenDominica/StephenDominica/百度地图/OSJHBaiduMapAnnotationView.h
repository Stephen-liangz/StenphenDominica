//
//  OSJHBaiduMapAnnotationView.h
//  StephenDominica
//
//  Created by Mac on 16/6/14.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Map/BMKAnnotationView.h>

#import "OSJHBaiduMapAnnotation.h"

@interface OSJHBaiduMapAnnotationView : BMKAnnotationView
@property (nonatomic,strong) UILabel *label;

@end
