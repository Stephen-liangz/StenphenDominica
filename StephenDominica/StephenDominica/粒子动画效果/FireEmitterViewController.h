//
//  FireEmitterViewController.h
//  StephenDominica
//
//  Created by Mac on 16/5/27.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "BaseViewController.h"


@interface FireEmitterViewController : BaseViewController


@end
//一、粒子发射器
//http://my.oschina.net/u/2340880/blog/485095#OSC_h2_1
//iOS中的粒子效果有两部分组成，一部分为发射器，设置例子发射的宏观属性，另一部分是粒子单元，用于设置相应的粒子属性。粒子发射器是基于Layer层，没错，又是Layer，他的全名叫做：
//
//CAEmitterLayer。其中常用的属性如下：
//
//@property(copy) NSArray *emitterCells;
//粒子单元数组，例如你在绘制火焰的效果时，你可以创建两个单元，一个单元负责烟雾，一个单元负责火苗。
//
//@property float birthRate;
//粒子的创建速率，默认为1/s。
//
//
//@property float lifetime;
//粒子的存活时间。默认为1S。
//
//
//@property CGPoint emitterPosition;
//发射器在xy平面的中心位置
//
//@property CGFloat emitterZPosition;
//发射器在Z平面的位置
//
//
//@property CGSize emitterSize;
//发射器的尺寸大小
//
//
//@property CGFloat emitterDepth;
//发射器的深度，在某些模式下会产生立体效果
//
//
//@property(copy) NSString *emitterShape;
//发射器的形状，这个参数的几个系统字符串如下：
//
//CA_EXTERN NSString * const kCAEmitterLayerPoint
//__OSX_AVAILABLE_STARTING (__MAC_10_6, __IPHONE_5_0); //点的形状，粒子从一个点发出
//CA_EXTERN NSString * const kCAEmitterLayerLine
//__OSX_AVAILABLE_STARTING (__MAC_10_6, __IPHONE_5_0);//线的形状，粒子从一条线发出
//CA_EXTERN NSString * const kCAEmitterLayerRectangle
//__OSX_AVAILABLE_STARTING (__MAC_10_6, __IPHONE_5_0);//矩形形状，粒子从一个矩形中发出
//CA_EXTERN NSString * const kCAEmitterLayerCuboid
//__OSX_AVAILABLE_STARTING (__MAC_10_6, __IPHONE_5_0);//立方体形状，会影响Z平面的效果
//CA_EXTERN NSString * const kCAEmitterLayerCircle
//__OSX_AVAILABLE_STARTING (__MAC_10_6, __IPHONE_5_0);//圆形，粒子会在圆形范围发射
//CA_EXTERN NSString * const kCAEmitterLayerSphere
//__OSX_AVAILABLE_STARTING (__MAC_10_6, __IPHONE_5_0);//球型
//
//@property(copy) NSString *emitterMode;
//发射器的发射模式，参数如下：
//
//CA_EXTERN NSString * const kCAEmitterLayerPoints
//__OSX_AVAILABLE_STARTING (__MAC_10_6, __IPHONE_5_0);//从发射器中发出
//CA_EXTERN NSString * const kCAEmitterLayerOutline
//__OSX_AVAILABLE_STARTING (__MAC_10_6, __IPHONE_5_0);//从发射器边缘发出
//CA_EXTERN NSString * const kCAEmitterLayerSurface
//__OSX_AVAILABLE_STARTING (__MAC_10_6, __IPHONE_5_0);//从发射器表面发出
//CA_EXTERN NSString * const kCAEmitterLayerVolume
//__OSX_AVAILABLE_STARTING (__MAC_10_6, __IPHONE_5_0);//从发射器中点发出
//
//@property(copy) NSString *renderMode;
//发射器渲染模式，参数如下：
//
//CA_EXTERN NSString * const kCAEmitterLayerUnordered
//__OSX_AVAILABLE_STARTING (__MAC_10_6, __IPHONE_5_0);//这种模式下，粒子是无序出现的，多个发射源将混合
//CA_EXTERN NSString * const kCAEmitterLayerOldestFirst
//__OSX_AVAILABLE_STARTING (__MAC_10_6, __IPHONE_5_0);//这种模式下，声明久的粒子会被渲染在最上层
//CA_EXTERN NSString * const kCAEmitterLayerOldestLast
//__OSX_AVAILABLE_STARTING (__MAC_10_6, __IPHONE_5_0);//这种模式下，年轻的粒子会被渲染在最上层
//CA_EXTERN NSString * const kCAEmitterLayerBackToFront
//__OSX_AVAILABLE_STARTING (__MAC_10_6, __IPHONE_5_0);//这种模式下，粒子的渲染按照Z轴的前后顺序进行
//CA_EXTERN NSString * const kCAEmitterLayerAdditive
//__OSX_AVAILABLE_STARTING (__MAC_10_6, __IPHONE_5_0);//这种模式会进行粒子混合
//
//@property BOOL preservesDepth;
//是否开启三维空间效果
//
//
//@property float velocity;
//粒子的运动速度
//
//
//@property float scale;
//粒子的缩放大小
//
//
//@property float spin;
//粒子的旋转位置
//
//
//@property unsigned int seed;
//初始化随机的粒子种子
//
//二、粒子单元
//
//设置好了粒子发射器，我们还需要初始化一些粒子单元，设置具体粒子的属性，我们使用到的类是CAEmitterCell这个类。
//
//
//+ (instancetype)emitterCell;
//类方法创建发射单元
//
//
//@property(copy) NSString *name;
//设置发射单元的名称
//
//
//@property(getter=isEnabled) BOOL enabled;
//是否允许发射器渲染
//
//
//@property float birthRate;
//粒子的创建速率
//
//
//@property float lifetime;
//粒子的生存时间
//
//
//@property float lifetimeRange;
//粒子的生存时间容差
//
//
//@property CGFloat emissionLatitude;
//粒子在Z轴方向的发射角度
//
//
//@property CGFloat emissionLongitude;
//粒子在xy平面的发射角度
//
//
//@property CGFloat emissionRange;
//粒子发射角度的容差
//
//
//@property CGFloat velocity;
//粒子的速度
//
//
//@property CGFloat velocityRange;
//粒子速度的容差
//
//
//@property CGFloat xAcceleration;
//@property CGFloat yAcceleration;
//@property CGFloat zAcceleration;
//x，y，z三个方向的加速度
//
//
//@property CGFloat scale;
//@property CGFloat scaleRange;
//@property CGFloat scaleSpeed;
//缩放大小，缩放容差和缩放速度
//
//
//@property CGFloat spin;
//@property CGFloat spinRange;
//旋转度与旋转容差
//
//@property CGColorRef color;
//粒子的颜色
//
//
//@property float redRange;
//@property float greenRange;
//@property float blueRange;
//@property float alphaRange;
//粒子在rgb三个色相上的容差和透明度的容差
//
//@property float redSpeed;
//@property float greenSpeed;
//@property float blueSpeed;
//@property float alphaSpeed;
//粒子在RGB三个色相上的变化速度和透明度的变化速度
//
//
//@property(strong) id contents;
//渲染粒子，可以设置为一个CGImage的对象
//
//
//@property CGRect contentsRect;
//渲染的范围
