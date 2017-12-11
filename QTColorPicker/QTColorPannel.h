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

@end


@interface QTColorPannel : UIView <QTColorPannelDelegate>

@property (nonatomic ,strong) UIColor *currentColor;
@property (nonatomic, weak) id <QTColorPannelDelegate> delegate;

- (void)rotateToColor:(UIColor *)color;

@end
