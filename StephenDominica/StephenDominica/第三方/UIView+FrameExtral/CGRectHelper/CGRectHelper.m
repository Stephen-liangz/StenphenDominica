//
//  CGRectHelper.m
//  VXiao
//
//  Created by YiJianjun on 14-2-13.
//  Copyright (c) 2014年 hc. All rights reserved.
//

#import "CGRectHelper.h"

@implementation CGRectHelper


+ (CGRect)rectChange:(CGRect)rect withDx:(CGFloat)dx{
    rect.origin.x += dx;
    
    return rect;
}

+ (CGRect)rectChange:(CGRect)rect withDy:(CGFloat)dy{
    rect.origin.y += dy;
    return rect;
}

+ (CGRect)rectChange:(CGRect)rect withDWidth:(CGFloat)dWidth{
    rect.size.width += dWidth;
    return rect;
}

+ (CGRect)rectChange:(CGRect)rect withDHeight:(CGFloat)dHeight{
    rect.size.height += dHeight;
    return rect;
}

+ (CGRect)rectChange:(CGRect)rect withDx:(CGFloat)dx dWidth:(CGFloat)dWidth{
    rect.origin.x += dx;
    rect.size.width += dWidth;
    return rect;
}

+ (CGRect)rectChange:(CGRect)rect withDy:(CGFloat)dy dHeight:(CGFloat)dHeight{
    rect.origin.y += dy;
    rect.size.height += dHeight;
    return rect;
}

+ (CGRect)rectChange:(CGRect)rect withDxAndDWidth:(CGFloat)dValue{
    return [self rectChange:rect withDx:dValue dy:0 dWidth:dValue dHeight:0];
}

+ (CGRect)rectChange:(CGRect)rect withDyAndDHeight:(CGFloat)dValue{
    return [self rectChange:rect withDx:0 dy:dValue dWidth:0 dHeight:dValue];
}

+ (CGRect)rectChange:(CGRect)rect withDx:(CGFloat)dx dy:(CGFloat)dy dWidth:(CGFloat)dWidth dHeight:(CGFloat)dHeight{
    rect.origin.x += dx;
    rect.origin.y += dy;
    rect.size.width += dWidth;
    rect.size.height += dHeight;
    return rect;
}

+ (CGRect)rectChange:(CGRect)rect withX:(CGFloat)x{
    rect.origin.x = x;
    return rect;
}

+ (CGRect)rectChange:(CGRect)rect withY:(CGFloat)y{
    rect.origin.y = y;
    return rect;
}

+ (CGRect)rectChange:(CGRect)rect withWidth:(CGFloat)width{
    rect.size.width = width;
    return rect;
}

+ (CGRect)rectChange:(CGRect)rect withHeight:(CGFloat)height{
    rect.size.height = height;
    return rect;
}

+ (CGRect)rectChange:(CGRect)rect withX:(CGFloat)x width:(CGFloat)width{
    rect.origin.x = x;
    rect.size.width = width;
    return rect;
}

+ (CGRect)rectChange:(CGRect)rect withY:(CGFloat)y height:(CGFloat)height{
    rect.origin.y = y;
    rect.size.height = height;
    return rect;
}

+ (CGRect)rectChange:(CGRect)rect withPoint:(CGPoint)point{
    return (CGRect){point,rect.size};
}

+ (CGRect)rectChange:(CGRect)rect withSize:(CGSize)size{
    return (CGRect){rect.origin,size};
}

+ (CGRect)rectWithPoint:(CGPoint)point size:(CGSize)size{
    return (CGRect){point,size};
}

+ (CGRect)rectChange:(CGRect)rect withCenterPoint:(CGPoint)point{
    CGSize size = rect.size;
    CGPoint fixedPoint = CGPointMake(point.x - size.width/2, point.y - size.height/2);
    return [self rectWithPoint:fixedPoint size:size];
}

+ (CGRect)rectWithFitSize:(CGSize)fitSize maxSize:(CGSize)size{
    
    CGSize sizeImage = size;
    CGSize sizeView = fitSize;
    CGSize sizeFixed;
    
    float scaleWidth = sizeView.width/sizeImage.width;
    float scaleHeight = sizeView.height/sizeImage.height;
    
    if(fabs(scaleHeight - 1.0) < 1e-6 && fabs(scaleWidth - 1.0) < 1e-6){
        sizeFixed = sizeImage;
        CGRect frame = CGRectMake( (sizeView.width-sizeFixed.width)/2 ,(sizeView.height-sizeFixed.height)/2, sizeFixed.width, sizeFixed.height);
        return frame;
    }
    if(fabs(scaleHeight - scaleWidth) < 1e-6 ){
        if(fabs(scaleHeight - 1.0) < 1e-6){//scaleHeight<= 1.0
            sizeFixed.height = sizeView.height;
            
        }else{
            sizeFixed.height = sizeImage.height;
        }
        sizeFixed.width = scaleHeight * sizeImage.width;
    }else if(fabs(scaleHeight - scaleWidth) > 1e-6 ){
        if(fabs(scaleWidth - 1.0) < 1e-6){//scaleHeight<= 1.0
            sizeFixed.width = sizeView.width;
            
        }else{
            sizeFixed.width = sizeImage.width;
        }
        sizeFixed.height = sizeImage.height * scaleWidth;
    }
    CGRect frame = CGRectMake( (sizeView.width-sizeFixed.width)/2 ,(sizeView.height-sizeFixed.height)/2, sizeFixed.width, sizeFixed.height);
    
    return frame;
}

+ (CGRect)rectChange:(CGRect)rect withTop:(CGFloat)top{
    return [self rectChange:rect withTop:top];
}

+ (CGRect)rectChange:(CGRect)rect withLeft:(CGFloat)left{
    return [self rectChange:rect withX:left];
}

+ (CGRect)rectChange:(CGRect)rect withBottom:(CGFloat)bottom{
    return [self rectChange:rect withY:bottom - rect.size.height];
}

+ (CGRect)rectChange:(CGRect)rect withRight:(CGFloat)right{
    return [self rectChange:rect withX:right - rect.size.width];
}

@end


