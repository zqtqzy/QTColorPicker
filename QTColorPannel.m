//
//  QTColorPannel.m
//  QTColorPicker
//
//  Created by 周奇天 on 2017/12/7.
//  Copyright © 2017年 zhouqitian. All rights reserved.
//

#import "QTColorPannel.h"
#import "UIView+ColorOfPoint.h"


@interface QTColorPannel(){
    CGFloat _initAngle; /**< 旋转之前角度 */

}
@property (nonatomic, strong) UIImageView *colorImage;
@property (nonatomic, strong) UIImageView *maskImage;

@end


@implementation QTColorPannel


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CGFloat width = MIN(frame.size.width, frame.size.height);
        _colorImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
        _colorImage.image = [UIImage imageNamed:@"pickerColorWheel"];
        [_colorImage setCenter:CGPointMake(frame.size.width/2.f, frame.size.width/2.f)];
        [self addSubview:_colorImage];

        _maskImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
//        _maskImage.image = [UIImage imageNamed:@"2_0000_up.png"];
        _maskImage.contentMode = UIViewContentModeScaleAspectFit;
        [_maskImage setCenter:CGPointMake(frame.size.width/2.f, frame.size.width/2.f)];
        [self addSubview:_maskImage];

        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:pan];
    }
    return self;
}



- (void)pan:(UIGestureRecognizer *)pan{
    CGPoint touchPoint = [pan locationInView:self.superview];
    CGPoint center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    if (pan.state == UIGestureRecognizerStateBegan) {
        _initAngle = atan2(touchPoint.y-center.y, touchPoint.x-center.x)-atan2(self.colorImage.transform.b, self.colorImage.transform.a);

    }else if (pan.state == UIGestureRecognizerStateChanged) {

        /* Rotation */
        float ang = atan2([pan locationInView:self.superview].y - self.center.y,
                          [pan locationInView:self.superview].x - self.center.x);
        float angleDiff = _initAngle - ang;
        self.colorImage.transform = CGAffineTransformMakeRotation(-angleDiff);
        [self setNeedsDisplay];

        self.currentColor = [self colorOfPoint:CGPointMake(CGRectGetMidX(self.bounds), 10)];
        if ([self.delegate respondsToSelector:@selector(pannelRotateWithColor:)]) {
            [self.delegate pannelRotateWithColor:self.currentColor];
        }

    }else {

        _initAngle = atan2(self.colorImage.transform.b, self.colorImage.transform.a);

        self.currentColor = [self colorOfPoint:CGPointMake(CGRectGetMidX(self.bounds), 10)];
        if ([self.delegate respondsToSelector:@selector(pannelEndRotateWithColor:)]) {
            [self.delegate pannelRotateWithColor:self.currentColor];
        }
    }

}

@end

