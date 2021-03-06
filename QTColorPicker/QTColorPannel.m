//
//  QTColorPannel.m
//  QTColorPicker
//
//  Created by 周奇天 on 2017/12/7.
//  Copyright © 2017年 zhouqitian. All rights reserved.
//

#import "QTColorPannel.h"
//#import "UIView+ColorOfPoint.h"
#import "QTColorPannelView.h"
#import "QTMaskView.h"
#import "UIColor+Similar.h"
#import "QTShadowView.h"
#import "QTHudView.h"

@interface QTColorPannel()<UIGestureRecognizerDelegate>{
    CGFloat _initAngle; /**< 旋转之前角度 */
    CGPoint _initPoint;

//    CADisplayLink *dis; //定时器
//    int updateCount;    //需要刷新次数
//    int currentCount;   //当前刷新次数
//    CGPoint velocity;   //速度
//
//    BOOL isAdd;

}
@property (nonatomic, strong) QTColorPannelView *colorView;
@property (nonatomic, strong) QTShadowView *shadowView;
@property (nonatomic, strong) QTMaskView *maskView;
@property (nonatomic, strong) QTHudView *hudView;

@property (nonatomic, strong) UIImageView *centerImage;
@property (nonatomic, strong) UIPanGestureRecognizer *colorPan;
@property (nonatomic, strong) UIPanGestureRecognizer *brightnessPan;

@end


@implementation QTColorPannel


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CGFloat width = MIN(frame.size.width, frame.size.height);
        _colorView = [[QTColorPannelView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
        [_colorView setCenter:CGPointMake(frame.size.width/2.f, frame.size.width/2.f)];
        _colorView.backgroundColor = [UIColor whiteColor];
        _colorView.layer.cornerRadius = width/2.f;
        _colorView.clipsToBounds = YES;
        [self addSubview:_colorView];

        _shadowView = [[QTShadowView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
        [_shadowView setCenter:CGPointMake(frame.size.width/2.f, frame.size.width/2.f)];
        [self addSubview:_shadowView];

        _hudView = [[QTHudView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
        [_hudView setCenter:CGPointMake(frame.size.width/2.f, frame.size.width/2.f)];
        [self addSubview:_hudView];

        _maskView = [[QTMaskView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
        [_maskView setCenter:CGPointMake(frame.size.width/2.f, frame.size.width/2.f)];
        [self addSubview:_maskView];

        _centerImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width/2.f, width/2.f)];
        _centerImage.contentMode = UIViewContentModeScaleAspectFit;
        _centerImage.layer.cornerRadius = width/4.f;
        _centerImage.clipsToBounds = YES;
        [_centerImage setCenter:CGPointMake(frame.size.width/2.f, frame.size.width/2.f)];
        [_centerImage setImage:[self imageWithId:1]];
        [self addSubview:_centerImage];


        _colorPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(colorPanAction:)];
        _colorPan.delegate = self;
        [self addGestureRecognizer:_colorPan];


        _brightnessPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(brightnessPanAction:)];
        _brightnessPan.delegate = self;
        [self addGestureRecognizer:_brightnessPan];

        [_brightnessPan requireGestureRecognizerToFail:_colorPan];


        [self parametersInit];

    }
    return self;
}


- (void)parametersInit{
    self.brightnessContinus = YES;
    self.brightness = 0;
    self.currentColor = [UIColor redColor];
}



- (UIImage *)imageWithId:(int)Id{
    NSLog(@"index:%d",Id);
    return [UIImage imageNamed:[NSString stringWithFormat:@"up_%d",Id]];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)pan{
    CGPoint touchPoint = [pan locationInView:self.superview];
    CGPoint center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    CGFloat distance = sqrt(pow((touchPoint.x - center.x), 2) + pow((touchPoint.y - center.y), 2));
    if (pan == _colorPan) {
        if (distance <= pan.view.frame.size.width/2.f && distance >= pan.view.frame.size.width/4.f) {
            CGFloat angle = atan2(touchPoint.y-center.y, touchPoint.x-center.x)-atan2(self.transform.b, self.transform.a);
            if (angle >= M_PI/4.f && angle <= M_PI/4.f*3.f) {
                return NO;
            }else{
                return YES;
            }
        }else{
            return NO;
        }
    }else{
        if (distance <= pan.view.frame.size.width/4.f) {
            return YES;
        }else
            return NO;
    }
}

- (void)colorPanAction:(UIGestureRecognizer *)pan{
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

- (void)brightnessPanAction:(UIPanGestureRecognizer *)pan{
    CGPoint currentPoint = [pan locationInView:self.superview];
    if (pan.state == UIGestureRecognizerStateBegan) {

        _initPoint = currentPoint;

    }else if (pan.state == UIGestureRecognizerStateChanged) {


        CGFloat distance = -(currentPoint.y - _initPoint.y)/1.5f;

        [self updateBrightnessWithDicstance:distance];


        if (self.brightnessContinus) {
            [self.hudView changeHudWithPercent:self.brightness/100.f];
        }
        if ([self.delegate respondsToSelector:@selector(brightnessChangingWithValue:)]) {
            [self.delegate brightnessChangingWithValue:self.brightness];
        }

        _initPoint = currentPoint;
    }else {


        [self.hudView changeHudWithPercent:self.brightness/100.f];

        if ([self.delegate respondsToSelector:@selector(brightnessEndChangeWithValue:)]) {
            [self.delegate brightnessEndChangeWithValue:self.brightness];
        }

//        CGFloat distance = -(currentPoint.y - _initPoint.y);
//        if (distance > 0) {
//            isAdd = YES;
//        }else{
//            isAdd = NO;
//        }
//
//        velocity = [pan velocityInView:self];
//        CGFloat magnitude = ABS(velocity.y) ;
//        CGFloat slideMult = magnitude / 200;
//        float slideFactor = 0.1 * slideMult;
//
//        updateCount = slideFactor * 120 + 1;
//        currentCount = 0;
//        dis = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateView)];
//        [dis addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];


    }
}
//
//- (void)updateView{
//    currentCount++;
//    if (currentCount>updateCount || currentCount>60) {
//
//        [dis removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//        [dis invalidate];
//        dis = nil;
//    }else{
//        if (isAdd) {
//            self.brightness -= ABS(velocity.y)/currentCount;
//        }else{
//            self.brightness += ABS(velocity.y)/currentCount;
//        }
//
//        [self.hudView changeHudWithPercent:self.brightness/100.f];
//    }
//
//
//}


- (void)updateBrightnessWithDicstance:(CGFloat)distance{
    self.brightness += distance;



    if (self.brightness < 0) {
        self.brightness = 0;
    }else if(self.brightness > 100){
        self.brightness = 100;
    }

    [self.centerImage setImage:[self imageWithId:(int)self.brightness%10+1]];
}

- (void)rotateToColor:(UIColor *)color{
    [self.colorView rotateToColor:color];
    self.currentColor = color;
    if ([self.delegate respondsToSelector:@selector(pannelRotateWithColor:)]) {
        [self.delegate pannelRotateWithColor:self.currentColor];
    }
}

- (void)changeHudWithPercent:(CGFloat)percent{
    [self.hudView changeHudWithPercent:percent];
}

@end

