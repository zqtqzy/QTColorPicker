//
//  QTColorPannel.h
//  QTColorPicker
//
//  Created by 周奇天 on 2017/12/7.
//  Copyright © 2017年 zhouqitian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QTColorPannelDelegate<NSObject>

@optional

- (void)pannelRotateWithColor:(UIColor *)color;
- (void)pannelEndRotateWithColor:(UIColor *)color;

- (void)brightnessChangingWithValue:(CGFloat)value;
- (void)brightnessEndChangeWithValue:(CGFloat)value;

@end


@interface QTColorPannel : UIView <QTColorPannelDelegate>

@property (nonatomic ,strong) UIColor *currentColor;
@property (nonatomic ,assign) CGFloat brightness;
@property (nonatomic ,assign) BOOL brightnessContinus;

@property (nonatomic, weak) id <QTColorPannelDelegate> delegate;

- (void)rotateToColor:(UIColor *)color;
- (void)changeHudWithPercent:(CGFloat)percent;
@end
