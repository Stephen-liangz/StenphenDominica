//
//  PersonNodeView.m
//  StephenDominica
//
//  Created by 钟亮 on 2017/1/5.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "PersonNodeView.h"
#import "UIViewExt.h"


@interface PersonNodeView ()

@end

@implementation PersonNodeView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];// 先调用父类的initWithFrame方法
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 初始化界面
- (void)setupUI
{
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 1;
    
    [self addSubview:self.nameLabel];
    
}

- (UIImageView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIImageView alloc]init];
    }
    return _headerView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _nameLabel.text = @"名字";
        _nameLabel.textColor = [UIColor blueColor];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.numberOfLines = 0;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
