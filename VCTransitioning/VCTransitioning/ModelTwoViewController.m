//
//  ModelTwoViewController.m
//  ViewControllerTransitioning
//
//  Created by Baymax on 16/7/31.
//  Copyright © 2016年 Baymax. All rights reserved.
//

#import "ModelTwoViewController.h"
//通过RGB设置颜色
#define KRGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
@interface ModelTwoViewController ()

@end

@implementation ModelTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
-(void)initUI{
    self.view.backgroundColor = KRGB(41, 128, 185);
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(120, 320, 50, 50)];
    [back setTitle:@"返回" forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
}

-(void)back{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
