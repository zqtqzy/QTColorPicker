//
//  MaskView.m
//  QTColorPicker
//
//  Created by 周奇天 on 2017/12/11.
//  Copyright © 2017年 zhouqitian. All rights reserved.
//

#import "MaskView.h"

@implementation MaskView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = frame.size.width/2.f;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code

    [self addMaskWithRect:rect];

    [self addPoinerWithRect:rect];


}

- (void)addMaskWithRect:(CGRect)rect{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:[self pointWithAngle:M_PI/6.f Radius:rect.size.width/4.f]];
    [path addArcWithCenter:self.center radius:rect.size.width/4.f startAngle:M_PI/6.f endAngle:M_PI/6.f*5.f clockwise:NO];
    [path addLineToPoint:[self pointWithAngle:M_PI/6.f*5 Radius:rect.size.width/2.f]];
    [path addArcWithCenter:self.center radius:rect.size.width/2.f startAngle:M_PI/6.f*5.f endAngle:M_PI/6.f clockwise:NO];
    [path addLineToPoint:[self pointWithAngle:M_PI/6.f Radius:rect.size.width/2.f]];
    [path closePath];

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.frame;
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = [UIColor clearColor].CGColor;
    shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    shapeLayer.fillRule = kCAFillRuleEvenOdd;
    shapeLayer.shadowColor = [UIColor lightGrayColor].CGColor;
    shapeLayer.shadowOffset = CGSizeMake(0, 0);
    shapeLayer.shadowOpacity = 1.f;
    [self.layer addSublayer:shapeLayer];
}


- (void)addPoinerWithRect:(CGRect)rect{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:[self pointWithAngle:M_PI + M_PI/2.f + M_PI/36.f Radius:rect.size.width/4.f]];
    [path addArcWithCenter:self.center radius:rect.size.width/4.f startAngle:M_PI + M_PI/2.f + M_PI/36.f endAngle:M_PI + M_PI/2.f - M_PI/36.f clockwise:NO];
    [path addLineToPoint:[self pointWithAngle:M_PI + M_PI/2.f Radius:rect.size.width/4.f + rect.size.width/8.f]];
    [path addLineToPoint:[self pointWithAngle:M_PI + M_PI/2.f + M_PI/36.f Radius:rect.size.width/4.f]];
    [path closePath];

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.frame;
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = [UIColor clearColor].CGColor;
    shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    shapeLayer.opacity = 0.6f;
    [self.layer addSublayer:shapeLayer];

}


- (CGPoint)pointWithAngle:(CGFloat)angle Radius:(CGFloat)radius{
    CGPoint point = CGPointMake(cos(angle)*radius+self.center.x, sin(angle)*radius+self.center.y);
    return point;
}







@end
