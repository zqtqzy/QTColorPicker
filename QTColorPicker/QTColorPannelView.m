//
//  ColorPannelView.m
//  QTColorPicker
//
//  Created by 周奇天 on 2017/12/8.
//  Copyright © 2017年 zhouqitian. All rights reserved.
//

#import "QTColorPannelView.h"
#import "UIColor+Similar.h"
@implementation QTColorPannelView

#define RGB(r,g,b) [UIColor colorWithRed:r/6.f green:g/6.f blue:b/6.f alpha:1.f]
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGFloat startAng = -M_PI/36.f;
    for (int i = 0; i < 36; i++) {
        [self drawArcWithStartAngel:startAng andEndAngle:startAng + M_PI/18.f andColor:[self colorArray][i] andRadius:rect.size.width/2.f];
        startAng +=M_PI/18.f;
    }

}

- (NSArray *)colorArray{
    return @[RGB(6, 0, 0),
             RGB(6, 1, 0),
             RGB(6, 2, 0),
             RGB(6, 3, 0),
             RGB(6, 4, 0),
             RGB(6, 5, 0),
             RGB(6, 6, 0),
             RGB(5, 6, 0),
             RGB(4, 6, 0),
             RGB(3, 6, 0),
             RGB(2, 6, 0),
             RGB(1, 6, 0),
             RGB(0, 6, 0),
             RGB(0, 6, 1),
             RGB(0, 6, 2),
             RGB(0, 6, 3),
             RGB(0, 6, 4),
             RGB(0, 6, 5),
             RGB(0, 6, 6),
             RGB(0, 5, 6),
             RGB(0, 4, 6),
             RGB(0, 3, 6),
             RGB(0, 2, 6),
             RGB(0, 1, 6),
             RGB(0, 0, 6),
             RGB(1, 0, 6),
             RGB(2, 0, 6),
             RGB(3, 0, 6),
             RGB(4, 0, 6),
             RGB(5, 0, 6),
             RGB(6, 0, 6),
             RGB(6, 0, 5),
             RGB(6, 0, 4),
             RGB(6, 0, 3),
             RGB(6, 0, 2),
             RGB(6, 0, 1),];
}

- (void)rotateToColor:(UIColor *)color{
    NSUInteger targetIdx = 0;
    CGFloat compVal = MAXFLOAT;
    for (UIColor *existColor in [self colorArray]) {
        if (CGColorEqualToColor(color.CGColor, existColor.CGColor)) {
            targetIdx = [[self colorArray] indexOfObject:existColor];
            break;
        }else{
            if ([existColor isSimilarWithColor:color] <= compVal) {
                targetIdx = [[self colorArray] indexOfObject:existColor];
                compVal = [existColor isSimilarWithColor:color];
            }
        }
    }
    [UIView animateWithDuration:0.5 animations:^{
        CGFloat targetAngle = M_PI/2.f*3.f - M_PI/18.f*targetIdx  ;
        NSLog(@"%f",targetAngle);
        CGAffineTransform transform = CGAffineTransformMakeRotation(targetAngle);
        [self setTransform:transform];
    }];
}


- (UIColor *)colorWithAngle:(CGFloat)angle{
    int colorIndex = (angle + M_PI/36.f)/(M_PI/18.f);
    colorIndex -= 9;
    if (colorIndex < 0) {
        colorIndex = 36 + colorIndex;
    }
    if (colorIndex < 0 || colorIndex >= 36) {
        return nil;
    }else{
        return (UIColor *)[[self colorArray] objectAtIndex:colorIndex];
    }
}


-(void)drawArcWithStartAngel:(CGFloat)startAngle andEndAngle:(CGFloat)endAngle andColor:(UIColor *)fillColor andRadius:(CGFloat)radius{
    UIBezierPath *path=[UIBezierPath bezierPath];
    [path moveToPoint:self.center];
    [path addLineToPoint:CGPointMake(cos(startAngle)*radius+self.center.x, sin(startAngle)*radius+self.center.y)];
    [path addArcWithCenter:self.center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    [path moveToPoint:CGPointMake(cos(endAngle)*radius+self.center.x, sin(endAngle)*radius+self.center.y)];
    [path addLineToPoint:self.center];
    [path closePath];

    CAShapeLayer *shapeLayer=[CAShapeLayer layer];
    shapeLayer.frame=self.frame;
    shapeLayer.path=path.CGPath;
    shapeLayer.strokeColor= fillColor.CGColor;
    shapeLayer.fillColor=fillColor.CGColor;
    [self.layer addSublayer:shapeLayer];
}


@end
