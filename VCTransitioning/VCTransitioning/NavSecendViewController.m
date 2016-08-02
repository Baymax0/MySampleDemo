//
//  NavSecendViewController.m
//  ViewControllerTransitioning
//
//  Created by Baymax on 16/7/31.
//  Copyright © 2016年 Baymax. All rights reserved.
//

#import "NavSecendViewController.h"
//通过RGB设置颜色
#define KRGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
@interface NavSecendViewController ()

@end

@implementation NavSecendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视图二";
    self.view.backgroundColor = KRGB(52, 73, 94);
}


@end
