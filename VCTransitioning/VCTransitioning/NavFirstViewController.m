//
//  NavFirstViewController.m
//  ViewControllerTransitioning
//
//  Created by Baymax on 16/7/31.
//  Copyright © 2016年 Baymax. All rights reserved.
//

#import "NavFirstViewController.h"
#import "NavSecendViewController.h"
#import "AnimationObject.h"
//通过RGB设置颜色
#define KRGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
@interface NavFirstViewController ()<UINavigationControllerDelegate>

@property (strong , nonatomic) AnimationObject * animation;

@end

@implementation NavFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视图一";
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.delegate = self;
}

#pragma mark == 初始化界面 ==
-(void)initUI{
    self.view.backgroundColor = KRGB(230, 126, 34);
    
    //返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    UIButton *next = [[UIButton alloc] initWithFrame:CGRectMake(5, 64, 50, 20)];
    [next setTitle:@"next" forState:UIControlStateNormal];
    [next addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:next];
}
-(void)back{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
-(void)next{
    NavSecendViewController *vc = [[NavSecendViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark == 修改页面跳转效果 ==

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    if(!_animation){
        _animation = [[AnimationObject alloc] init];
    }
    if (operation==UINavigationControllerOperationPush) {
        _animation.type = AnimationTypeGoNewVC;
    }else{
        _animation.type = AnimationTypeBack;
    }
    _animation.circleCenterRect = CGRectMake(5, 64, 50, 20);
    return _animation;
}

@end
