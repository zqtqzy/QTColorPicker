//
//  UIColor+Similar.m
//  QTColorPicker
//
//  Created by 周奇天 on 2017/12/11.
//  Copyright © 2017年 zhouqitian. All rights reserved.
//

#import "UIColor+Similar.h"

@implementation UIColor (Similar)


- (CGFloat)isSimilarWithColor:(UIColor *)color{
    int components1[3];
    [self getRGBComponents:components1 forColor:self];

    int components2[3];
    [self getRGBComponents:components2 forColor:color];

    return ColorComp(components1[0], components1[1], components1[2], components2[0], components2[1], components2[2]);
}


- (void)getRGBComponents:(int [3])components forColor:(UIColor *)color {
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixel[4];
    CGContextRef context = CGBitmapContextCreate(&resultingPixel,
                                                 1,
                                                 1,
                                                 8,
                                                 4,
                                                 rgbColorSpace,
                                                 kCGImageAlphaNoneSkipLast);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);

    for (int component = 0; component < 3; component++) {
        components[component] = resultingPixel[component];
    }
}

CGFloat ColorComp(int ar,int ag,int ab,int br,int bg,int bb)
{
    //通过HSV比较两个子RGB的色差
    //比较两个RGB的色差
    int absR=ar-br;
    int absG=ag-bg;
    int absB=ab-bb;
    return sqrt(absR*absR+absG*absG+absB*absB);
}

@end
