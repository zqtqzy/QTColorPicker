//
//  HUDView.m
//  QTColorPicker
//
//  Created by 周奇天 on 2017/12/12.
//  Copyright © 2017年 zhouqitian. All rights reserved.
//

#import "QTShadowView.h"

@interface QTShadowView()

@end

@implementation QTShadowView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = frame.size.width/2.f;
        self.clipsToBounds = YES;
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
    // 创建色彩空间对象
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    // 创建起点和终点颜色分量的数组
    CGFloat colors1[] =
    {
        0, 0, 0, 0.4,//start color(r,g,b,alpha)
        0, 0, 0, 0,//end color
    };

    //形成梯形，渐变的效果
    CGGradientRef gradient1 = CGGradientCreateWithColorComponents
    (rgb, colors1, NULL, 2);

    // 起点颜色起始圆心 终点颜色起始圆心
    CGPoint center1 = CGPointMake(rect.size.width/2, rect.size.height/2);
    CGPoint center2 = CGPointMake(rect.size.width/2, rect.size.height/2 + 5.f);

    // 起点颜色圆形半径
    CGFloat startRadius1 = rect.size.width/4.f - 5;
    // 终点颜色圆形半径
    CGFloat endRadius1 = rect.size.width/4.f + 5;

    // 起点颜色圆形半径
    CGFloat startRadius2 = rect.size.width/2.f + 5;
    // 终点颜色圆形半径
    CGFloat endRadius2 = rect.size.width/2.f - 5;

    // 获取上下文
    CGContextRef graCtx = UIGraphicsGetCurrentContext();
    // 创建一个径向渐变
    CGContextDrawRadialGradient(graCtx, gradient1, center1, startRadius1, center2, endRadius1, 0);
    CGContextDrawRadialGradient(graCtx, gradient1, center1, startRadius2, center2, endRadius2, 0);

    //releas
    CGGradientRelease(gradient1);
    gradient1=NULL;

    CGColorSpaceRelease(rgb);

}


@end
