//
//  QTHudView.m
//  QTColorPicker
//
//  Created by 周奇天 on 2017/12/12.
//  Copyright © 2017年 zhouqitian. All rights reserved.
//

#import "QTHudView.h"

@interface QTHudView(){
    CGFloat hudPercent;

}

@end

@implementation QTHudView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = frame.size.width/2.f;
        self.clipsToBounds = YES;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    // 创建色彩空间对象
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    // 创建起点和终点颜色分量的数组

    CGFloat colorVal = 1.f - 1.f * hudPercent;

    CGFloat colors1[] =
    {
        colorVal, colorVal, colorVal, 0.5 + 0.5 * hudPercent,//start color(r,g,b,alpha)
        255, 255, 255, 0,//end color
    };

    NSLog(@"colorval:%f  percent:%f",colorVal, hudPercent);
    //形成梯形，渐变的效果
    CGGradientRef gradient1 = CGGradientCreateWithColorComponents
    (rgb, colors1, NULL, 2);

    // 起点颜色起始圆心 终点颜色起始圆心
    CGPoint center1 = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    CGPoint center2 = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);

    // 起点颜色圆形半径
    CGFloat startRadius1 = 0;
    // 终点颜色圆形半径
    CGFloat endRadius1 = rect.size.width/2.f + rect.size.width * hudPercent;


    // 获取上下文
    CGContextRef graCtx = UIGraphicsGetCurrentContext();
    // 创建一个径向渐变
    CGContextDrawRadialGradient(graCtx, gradient1, center1, startRadius1, center2, endRadius1, 0);

    //releas
    CGGradientRelease(gradient1);
    gradient1=NULL;

    CGColorSpaceRelease(rgb);
}

- (void)changeHudWithPercent:(CGFloat)percent{
    hudPercent = 1 - percent;
    [self setNeedsDisplay];
}

@end
