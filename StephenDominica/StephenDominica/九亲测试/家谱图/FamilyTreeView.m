//
//  FamilyTreeView.m
//  StephenDominica
//
//  Created by 钟亮 on 2017/1/5.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "FamilyTreeView.h"
#import "UIViewExt.h"
#import "PersonNodeView.h"
#import "PersonInfoModel.h"
#import "UIViewExt.h"

static const CGFloat KGenerationViewWidth = 30.;

@interface FamilyTreeView ()

@property (strong, nonatomic)UIScrollView *familyScrollView;/// right 家谱树View 滚动view

@property (strong, nonatomic)UIView *generationView;/// left世代View

@property (strong, nonatomic)UIView *familyTreeShowView;/// right 家谱树View

@end

@implementation FamilyTreeView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];// 先调用父类的initWithFrame方法
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
        
    
        [self addSubview:self.generationView];
        [self addSubview:self.familyScrollView];
        [_familyScrollView addSubview:self.familyTreeShowView];
    }
    return self;
}


#pragma mark - 世代view的生成
- (UIView *)generationView
{
    if (!_generationView) {
        
        _generationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KGenerationViewWidth, self.height)];
        _generationView.backgroundColor = self.backgroundColor;
        //目前设置为展示5代
        NSArray *generationTitleArray = @[@"第一世",@"第二世",@"第三世",@"第四世",@"第五世"];
        for (int i = 0; i < 5; i ++) {
            UILabel *tagTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, ((i+1)*2-1)*self.height/11 , KGenerationViewWidth, self.height/11)];
            tagTitleLabel.text = generationTitleArray[i];
            tagTitleLabel.adjustsFontSizeToFitWidth = YES;
            tagTitleLabel.numberOfLines = 0;
            tagTitleLabel.textAlignment = NSTextAlignmentCenter;
            tagTitleLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
            tagTitleLabel.layer.borderWidth = 1;
            [_generationView addSubview:tagTitleLabel];
        }
        
    }
    return _generationView;
}

- (UIScrollView *)familyScrollView
{
    if (!_familyScrollView) {
        
        _familyScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(_generationView.right, 0, MainScreenWidth - _generationView.width, self.height)];
        _familyScrollView.contentSize = self.frame.size;
        _familyScrollView.bounces = NO;
        _familyScrollView.showsVerticalScrollIndicator = NO;
        _familyScrollView.showsHorizontalScrollIndicator = NO;
        
    }
    
    return _familyScrollView;
}

#pragma mark - 家谱树View的生成
- (UIView *)familyTreeShowView
{
    if (!_familyTreeShowView) {
        
        _familyTreeShowView = [[UIView alloc]initWithFrame:CGRectMake(_generationView.right, 0, MainScreenWidth - _generationView.width, self.height)];
        //目前设置为展示5代
//        NSArray *generationArray = @[@"第一世人",@"第二世人",@"第三世人",@"第四世人",@"第五世人"];
//        for (int i = 0; i < 5; i ++) {
//            PersonNodeView *personNodeView = [[PersonNodeView alloc]initWithFrame:CGRectMake(MainScreenWidth/2 - (MainScreenWidth - _generationView.width - 30)/6 , ((i+1)*2-1)*self.height/11, , self.height/11)];
//            personNodeView.nameLabel.text = generationArray[i];
//            [_familyTreeShowView addSubview:personNodeView];
//        }
        
    }
    return _familyTreeShowView;
}

- (void)redrawTreeViewWithPersonArray:(NSArray *)personArray
{
//    边距
    CGFloat Vleading = 30;
    CGFloat Vtop = self.height/11;
    CGFloat Vmargin = 16;
    
    CGFloat VWidth = (MainScreenWidth - _generationView.width - 30 - Vmargin * 3 )/3;
    CGFloat VHeight = self.height/11;
    
    ///宽比例
    NSInteger w = 0;
    NSInteger h = 0;
    
    for (NSArray *gA in personArray) {
        //计算横轴 最大个数
        w = w < gA.count ? gA.count : w;
    }
    
    for (int k = 0; k < personArray.count; k ++) {
        NSArray *gArray = personArray[k];
        //高比例
        for (int i = 0; i < gArray.count; i ++ ) {
            PersonInfoModel *p = gArray[i];
            CGRect viewFrame;
            if (k != 0) {
                viewFrame = CGRectMake(
                                              Vleading + i*(Vmargin + VWidth),
                                              Vtop + h*(VHeight + VHeight),
                                              VWidth,
                                              VHeight);
            }else{
                //第一世代
                if (w%2 != 0) {
                    //当单世代里面最多人数为单数时
                    viewFrame = CGRectMake(
                                           Vleading + ((w+1)/2 - 1)*(Vmargin + VWidth),
                                           Vtop + h*(VHeight + VHeight),
                                           VWidth,
                                           VHeight);
                }else{
                    //当单世代里面最多人数为双数时
                    CGFloat tempXValue = (w*(Vmargin + VWidth) - Vmargin)/2;
                    
                    viewFrame = CGRectMake(tempXValue > 0 ? tempXValue : Vleading,
                                           Vtop + h*(VHeight + VHeight),
                                           VWidth,
                                           VHeight);

                }
                
            }
            
            
            PersonNodeView *personNodeView = [[PersonNodeView alloc]initWithFrame:viewFrame];
            personNodeView.nameLabel.text = p.genealogyname;
            personNodeView.tag = p.pId;
            [_familyTreeShowView addSubview:personNodeView];
        }
        
        //计算纵轴 偏移
        h += 1;
    }
    
    _familyScrollView.contentSize = CGSizeMake(Vleading + w*(Vmargin + VWidth) + Vleading, MainScreenHeight - 64);
}


- (void)drawRelationshipLine:(NSArray *)relationshipArray
{
    for (PersonRelationshipModel *relationshipModel in relationshipArray) {
        [self drawLine:relationshipModel];
    }
}

- (void)drawLine:(PersonRelationshipModel *)relationshipModel
{
    if (relationshipModel.personId < 0) {
        return;
    }
    
    PersonNodeView *fatherView = [self viewWithTag:relationshipModel.personId];
    PersonNodeView *childView = [self viewWithTag:relationshipModel.masterpid];
    
    CGFloat VyContenOffset =  self.height/22;


    CAShapeLayer *solidShapeLayer = [CAShapeLayer layer];
    CGMutablePathRef solidShapePath =  CGPathCreateMutable();
    [solidShapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [solidShapeLayer setStrokeColor:[[UIColor orangeColor] CGColor]];
    solidShapeLayer.lineWidth = 2.0f ;
    CGPathMoveToPoint(solidShapePath, NULL, _generationView.width + fatherView.frame.origin.x + fatherView.width/2, fatherView.frame.origin.y + fatherView.height);
    CGPathAddLineToPoint(solidShapePath, NULL, _generationView.width + fatherView.frame.origin.x + fatherView.width/2, fatherView.frame.origin.y + fatherView.height + VyContenOffset);
    CGPathAddLineToPoint(solidShapePath, NULL, _generationView.width + childView.frame.origin.x + childView.width/2, childView.frame.origin.y - VyContenOffset);
    CGPathAddLineToPoint(solidShapePath, NULL, _generationView.width + childView.frame.origin.x + childView.width/2, childView.frame.origin.y);
    
    [solidShapeLayer setPath:solidShapePath];
    CGPathRelease(solidShapePath);
    [_familyScrollView.layer addSublayer:solidShapeLayer];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
