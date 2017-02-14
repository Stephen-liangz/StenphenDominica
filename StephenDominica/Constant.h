//
//  Constant.h
//  StephenDominica
//
//  Created by Mac on 16/5/27.
//  Copyright © 2016年 Mac. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

#define Rect(x,y,w,h) CGRectMake(x, y, w, h)

#define Size(w,h) CGSizeMake(w, h)

#define FONT(fontSize) [UIFont systemFontOfSize:fontSize]

#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define MainScreenWidth   [UIScreen mainScreen].bounds.size.width

#define MainScreenHeight  [UIScreen mainScreen].bounds.size.height

#define MainScreenHeight_noNavigat  [UIScreen mainScreen].bounds.size.height - 64

#endif /* Constant_h */
