//
//  ModelOneViewController.m
//  ViewControllerTransitioning
//
//  Created by Baymax on 16/7/31.
//  Copyright © 2016年 Baymax. All rights reserved.
//

#import "ModelOneViewController.h"
#import "ModelTwoViewController.h"
#import "AnimationObject.h"

//通过RGB设置颜色
#define KRGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
@interface ModelOneViewController ()<UIViewControllerTransitioningDelegate>

@property (strong , nonatomic) AnimationObject * animation;

@end

@implementation ModelOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //自己出现 或 消失的时候  是否调用动画
//    self.transitioningDelegate = self;
    [self initUI];
}
#pragma mark == 初始化页面 及 跳转按钮 ==
-(void)initUI{
    self.view.backgroundColor = KRGB(231, 76, 60);
    
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 50, 50)];
    [back setTitle:@"返回" forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    
    UIButton *next = [[UIButton alloc] initWithFrame:CGRectMake(120, 320, 50, 50)];
    [next setTitle:@"next" forState:UIControlStateNormal];
    [next addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:next];
}
-(void)back{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

-(void)next{
    ModelTwoViewController *vc = [[ModelTwoViewController alloc] init];
    //vc出现 或 消失的时候  是否调用动画
    vc.transitioningDelegate = self;
    [self presentViewController:vc animated:YES completion:^{}];
}

#pragma mark == UIViewControllerTransitioningDelegate ==
//模态跳转时  从新赋予 动画对象
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    if(!_animation){
        _animation = [[AnimationObject alloc] init];
    }
    _animation.circleCenterRect = CGRectMake(120, 320, 50, 50);
    _animation.type = AnimationTypeGoNewVC;
    return _animation;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    if(!_animation){
        _animation = [[AnimationObject alloc] init];
    }
    _animation.type = AnimationTypeBack;
    _animation.circleCenterRect = CGRectMake(120, 320, 50, 50);
    return _animation;
}

@end
