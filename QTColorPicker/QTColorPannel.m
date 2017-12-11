//
//  QTColorPannel.m
//  QTColorPicker
//
//  Created by 周奇天 on 2017/12/7.
//  Copyright © 2017年 zhouqitian. All rights reserved.
//

#import "QTColorPannel.h"
#import "UIView+ColorOfPoint.h"
#import "ColorPannelView.h"
#import "MaskView.h"
#import "UIColor+Similar.h"

@interface QTColorPannel()<UIGestureRecognizerDelegate>{
    CGFloat _initAngle; /**< 旋转之前角度 */

}
@property (nonatomic, strong) ColorPannelView *colorView;
@property (nonatomic, strong) MaskView *maskImage;

@end


@implementation QTColorPannel


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CGFloat width = MIN(frame.size.width, frame.size.height);
        _colorView = [[ColorPannelView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
        [_colorView setCenter:CGPointMake(frame.size.width/2.f, frame.size.width/2.f)];
        _colorView.backgroundColor = [UIColor whiteColor];
        _colorView.layer.cornerRadius = width/2.f;
        _colorView.clipsToBounds = YES;
        [self addSubview:_colorView];

        _maskImage = [[MaskView alloc] initWithFrame:CGRectMake(0, 0, width, width)];

        [_maskImage setCenter:CGPointMake(frame.size.width/2.f, frame.size.width/2.f)];
        [self addSubview:_maskImage];

        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        pan.delegate = self;
        [self addGestureRecognizer:pan];
    }
    return self;
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)pan{
    CGPoint touchPoint = [pan locationInView:self.superview];
    CGPoint center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    CGFloat distance = sqrt(pow((touchPoint.x - center.x), 2) + pow((touchPoint.y - center.y), 2));
//    NSLog(@"------%f",distance);
    if (distance <= pan.view.frame.size.width/2.f && distance >= pan.view.frame.size.width/4.f) {
        CGFloat angle = atan2(touchPoint.y-center.y, touchPoint.x-center.x)-atan2(self.transform.b, self.transform.a);
//        NSLog(@"------%f",angle);
        if (angle >= M_PI/4.f && angle <= M_PI/4.f*3.f) {
            return NO;
        }else{
            return YES;
        }
    }else{
        return NO;
    }
}

- (void)pan:(UIGestureRecognizer *)pan{
    CGPoint touchPoint = [pan locationInView:self.superview];
    CGPoint center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    if (pan.state == UIGestureRecognizerStateBegan) {

        _initAngle = atan2(touchPoint.y-center.y, touchPoint.x-center.x)-atan2(self.colorView.transform.b, self.colorView.transform.a);

    }else if (pan.state == UIGestureRecognizerStateChanged) {

        /* Rotation */
        float ang = atan2([pan locationInView:self.superview].y - self.center.y,
                          [pan locationInView:self.superview].x - self.center.x);
        float angleDiff = _initAngle - ang;
        self.colorView.transform = CGAffineTransformMakeRotation(-angleDiff);
        [self setNeedsDisplay];

        if ([self.colorView colorWithAngle:angleDiff] != nil) {
            self.currentColor = [self.colorView colorWithAngle:angleDiff];
        }
        if ([self.delegate respondsToSelector:@selector(pannelRotateWithColor:)]) {
            [self.delegate pannelRotateWithColor:self.currentColor];
        }
        NSLog(@"%f",angleDiff);

    }else {

        _initAngle = atan2(self.colorView.transform.b, self.colorView.transform.a);

        if ([self.delegate respondsToSelector:@selector(pannelEndRotateWithColor:)]) {
            [self.delegate pannelRotateWithColor:self.currentColor];
        }
    }

}

- (void)rotateToColor:(UIColor *)color{
    [self.colorView rotateToColor:color];
    self.currentColor = color;
    if ([self.delegate respondsToSelector:@selector(pannelRotateWithColor:)]) {
        [self.delegate pannelRotateWithColor:self.currentColor];
    }
}

@end

