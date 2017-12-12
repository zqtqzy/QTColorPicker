//
//  ColorPannelView.h
//  QTColorPicker
//
//  Created by 周奇天 on 2017/12/8.
//  Copyright © 2017年 zhouqitian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QTColorPannelView : UIView


- (void)rotateToColor:(UIColor *)color;
- (UIColor *)colorWithAngle:(CGFloat)angle;

@end
