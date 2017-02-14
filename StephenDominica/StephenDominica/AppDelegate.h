//
//  AppDelegate.h
//  StephenDominica
//
//  Created by Mac on 16/5/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <BaiduMapAPI_Base/BMKBaseComponent.h>
@interface BaiduMapApiDemoAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UINavigationController *navigationController;
}
@end

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

