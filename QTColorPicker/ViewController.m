//
//  ViewController.m
//  QTColorPicker
//
//  Created by 周奇天 on 2017/12/7.
//  Copyright © 2017年 zhouqitian. All rights reserved.
//

#import "ViewController.h"
#import "QTColorPannel.h"
#import "QTColorPannelView.h"
#define screenW self.view.bounds.size.width
#define screenH self.view.bounds.size.height
#define RGB(r,g,b) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1.f]

@interface ViewController ()<QTColorPannelDelegate>
@property (nonatomic,strong) QTColorPannel * turntable;;

@property (weak, nonatomic) IBOutlet UILabel *brightnessLabel;

@end

@implementation ViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.view.backgroundColor = [UIColor whiteColor];
    _turntable = [[QTColorPannel alloc] initWithFrame:CGRectMake(0, 0, screenW - 100, screenW - 100)];
    _turntable.backgroundColor = [UIColor clearColor];
    _turntable.delegate = self;
    [_turntable setCenter:self.view.center];
    [self.view addSubview:_turntable];

    _brightnessLabel.text = [NSString stringWithFormat:@"%d",(int)_turntable.brightness];

}

- (void)pannelRotateWithColor:(UIColor *)color{
    self.view.backgroundColor = color;
}

- (void)brightnessChangingWithValue:(CGFloat)value{
    _brightnessLabel.text = [NSString stringWithFormat:@"%d",(int)value];
}

- (IBAction)redAction:(id)sender {
    [self.turntable rotateToColor:RGB(255, 0, 0)];
}

- (IBAction)blueAction:(id)sender {
    [self.turntable rotateToColor:RGB(0, 0, 255)];
}

- (IBAction)greenAction:(id)sender {
    [self.turntable rotateToColor:RGB(0, 255, 0)];
}

- (IBAction)randomAction:(id)sender {
    [self.turntable rotateToColor:[UIColor redColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

