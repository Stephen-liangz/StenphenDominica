//
//  TextFlashesViewController.m
//  StephenDominica
//
//  Created by Mac on 16/6/1.
//  Copyright © 2016年 Mac. All rights reserved.
//

/**
 RQShineLabel、CADisplay
 **/

#import "TextFlashesViewController.h"
#import "RQShineLabel.h"

@interface TextFlashesViewController ()

@property (nonatomic, strong) RQShineLabel *shineLabel;///< 文字闪现label
@property (nonatomic, strong) NSArray *textArray;///< 文字数组
@property (nonatomic, strong) UIImageView *bgImgView;///< 背景img

@property int textIndex;

@end

@implementation TextFlashesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"文字闪现效果";
    
    self.view.backgroundColor = [UIColor blackColor];
    
    _textArray = @[
                   @"我确实说我这样说我不在乎结果 \n我对你说我有把握成功例子好多\n 人们虚假又造作总爱得不温不火\n 我们用真心就不会有差错",
                   @"We’re just enthusiastic about what we do.",
                   @"That's right now\n仅此而已\n\nMeet me in the middle of the day\n让我在晴朗的午后遇见你\n请我会在明媚的阳光中盛放\n\nMeet me in the middle of the night\n让我在安静的夜色中遇见你。"
                   ];
    _textIndex  = 0;
    
    
    _bgImgView = ({
        UIImageView *imv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"will.jpg"]];
        imv.contentMode = UIViewContentModeScaleAspectFit;
        imv.frame = Rect(0, 0, MainScreenWidth, MainScreenWidth);
        imv.alpha = 0;
        [imv setCenter:self.view.center];
        imv;
    });
    [self.view addSubview:_bgImgView];
    
    _shineLabel = ({
        RQShineLabel *rqLab = [[RQShineLabel alloc]initWithFrame:Rect(16, 30, MainScreenWidth - 32, MainScreenHeight - 60)];
        rqLab.numberOfLines = 0;
        rqLab.text = _textArray[_textIndex];
        rqLab.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:22];
        rqLab.backgroundColor = [UIColor clearColor];
        rqLab.center = self.view.center;
        rqLab;
    });
    [self.view addSubview:_shineLabel];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [UIView animateWithDuration:0.5 animations:^{
//        _bgImgView.alpha = 1;
//    }];
    [_shineLabel shine];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [_shineLabel fadeOutWithCompletion:^{
        [self updateText];
        [_shineLabel shine];
    }];
    
}

- (void)updateText
{
    self.shineLabel.text = self.textArray[(++self.textIndex) % self.textArray.count];
//   _shineLabel.text = _textArray[(++_textIndex)%_textArray.count];
}
@end
