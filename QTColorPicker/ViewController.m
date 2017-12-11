//
//  ViewController.m
//  QTColorPicker
//
//  Created by 周奇天 on 2017/12/7.
//  Copyright © 2017年 zhouqitian. All rights reserved.
//

#import "ViewController.h"
#import "QTColorPannel.h"
#import "ColorPannelView.h"
#define screenW self.view.bounds.size.width
#define screenH self.view.bounds.size.height


@interface ViewController ()<QTColorPannelDelegate>
@property (nonatomic,strong) QTColorPannel * turntable;;


@end

@implementation ViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.view.backgroundColor = [UIColor whiteColor];
    _turntable = [[QTColorPannel alloc] initWithFrame:CGRectMake(0, 0, screenW - 50, screenW - 50)];
    _turntable.backgroundColor = [UIColor clearColor];
    _turntable.delegate = self;
    [_turntable setCenter:self.view.center];
//    [self.view addSubview:_turntable];

    ColorPannelView *view = [[ColorPannelView alloc] initWithFrame:CGRectMake(0, 0, screenW - 50, screenW - 50)];
    view.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:view];

}

- (void)pannelRotateWithColor:(UIColor *)color{
    self.view.backgroundColor = color;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

