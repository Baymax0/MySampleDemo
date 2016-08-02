//
//  ViewController.m
//  VCTransitioning
//
//  Created by Baymax on 16/8/3.
//  Copyright © 2016年 Baymax. All rights reserved.
//

#import "ViewController.h"
#import "NavFirstViewController.h"
#import "ModelOneViewController.h"

@interface ViewController ()

@property (strong , nonatomic) NavFirstViewController * navVC;

@property (strong , nonatomic) ModelOneViewController * presentionVC;
@end

@implementation ViewController

-(ModelOneViewController *)presentionVC{
    if (!_presentionVC) {
        _presentionVC = [[ModelOneViewController alloc] init];
    }
    return _presentionVC;
}
-(NavFirstViewController *)navVC{
    if (!_navVC) {
        _navVC = [[NavFirstViewController alloc] init];
    }
    return _navVC;
}

- (IBAction)navigationTransiting:(id)sender {
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:self.navVC];
    [self presentViewController:navigation animated:YES completion:^{}];
}
- (IBAction)modelTransiting:(id)sender {
    [self presentViewController:self.presentionVC animated:YES completion:^{}];
}

@end