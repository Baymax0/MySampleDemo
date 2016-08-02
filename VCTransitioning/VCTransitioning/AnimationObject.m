//
//  AnimationObject.m
//  ViewControllerTransitioning
//
//  Created by Baymax on 16/7/31.
//  Copyright © 2016年 Baymax. All rights reserved.
//

#import "AnimationObject.h"
//应用程序的屏幕高度
#define kWindowH   [UIScreen mainScreen].bounds.size.height
//应用程序的屏幕宽度
#define kWindowW    [UIScreen mainScreen].bounds.size.width
//动画对象  
@implementation AnimationObject

#pragma mark == UIViewControllerAnimatedTransitioning ==
//跳转动画的执行时间
-(NSTimeInterval)transitionDuration:(id < UIViewControllerContextTransitioning >)transitionContext;{
    return 0.5;
}

//具体动画效果1  页面从下往上 弹簧效果（效果一，效果二，二选一）
//-(void)animateTransition:(id < UIViewControllerContextTransitioning >)transitionContext{
//    //获得跳转到的ViewController对象
//    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    //toVC的最终位置 当前窗口的大小
//    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
//    //toVC的初始位置 在屏幕下方
//    toVC.view.frame = CGRectOffset(finalFrame, 0, finalFrame.size.height);
//    //    toVC.view.frame = finalFrame;
//    //将toVC加入到 containerView中
//    [[transitionContext containerView] addSubview:toVC.view];
//    //执行动画
//    NSTimeInterval duration = [self transitionDuration:transitionContext];
//    [UIView animateWithDuration:duration
//                          delay:0.0
//         usingSpringWithDamping:0.6 //弹簧动画
//          initialSpringVelocity:0.0
//                        options:UIViewAnimationOptionCurveLinear
//                     animations:^{
//                         toVC.view.frame = finalFrame;
//                     } completion:^(BOOL finished) {
//                         // 5. Tell context that we completed.
//                         [transitionContext completeTransition:YES];
//                     }];
//}

//动画效果2 按钮圆圈变大 （效果一，效果二，二选一）
-(void)animateTransition:(id < UIViewControllerContextTransitioning >)transitionContext{
    self.transitionContext = transitionContext;
    //无论跳转还是返回  当前视图都是fromVC  动画之后显示的是toVC
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    NSLog(@"toVC.view:%@",toVC.view);
//    NSLog(@"fromVC.view:%@",fromVC.view);
//    NSLog(@"%@",[[transitionContext containerView] subviews]);
    _circleCenterRect = CGRectMake(120, 320, 50, 50);
    //圆圈1--小圆
    UIBezierPath *smallCircleBP =  [UIBezierPath bezierPathWithOvalInRect:_circleCenterRect];
    
    //圆圈2--大圆
    //以_circleCenterRect的中心为圆心
    CGFloat centerX = _circleCenterRect.origin.x+_circleCenterRect.size.width/2;
    CGFloat centerY = _circleCenterRect.origin.y+_circleCenterRect.size.height/2;
    //找出到页面4个角最长的半径
    CGFloat r1 = (kWindowW-centerX)>centerX?(kWindowW-centerX):centerX;
    CGFloat r2 = (kWindowW-centerY)>centerY?(kWindowW-centerY):centerY;
    CGFloat radius = sqrt((r1 * r1) + (r2 * r2));
    UIBezierPath *bigCircleBP = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(_circleCenterRect, -radius, -radius)];
    
    //跳转到新视图
    if (self.type==AnimationTypeGoNewVC) {
        //1.把 页面二 加到内容页
        [[transitionContext containerView] addSubview:toVC.view];
        //设置maskLayer
        CAShapeLayer *maskLayer = [CAShapeLayer layer];//将它的 path 指定为最终的 path 来避免在动画完成后会回弹
        toVC.view.layer.mask = maskLayer;
        maskLayer.path = bigCircleBP.CGPath;
        //执行动画
        CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        maskLayerAnimation.fromValue = (__bridge id)(smallCircleBP.CGPath);
        maskLayerAnimation.toValue = (__bridge id)((bigCircleBP.CGPath));
        maskLayerAnimation.duration = [self transitionDuration:transitionContext];
        maskLayerAnimation.delegate = self;
        [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
    }
    //返回
    else{
        //1.把 页面一 加入到视图 同时挪到当前视图后面
        [[transitionContext containerView] addSubview:toVC.view];
        [[transitionContext containerView] sendSubviewToBack:toVC.view];
        //设置maskLayer
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = smallCircleBP.CGPath;//将它的 path 指定为最终的 path 来避免在动画完成后会回弹
        fromVC.view.layer.mask = maskLayer;
        //执行动画
        CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        maskLayerAnimation.fromValue = (__bridge id)(bigCircleBP.CGPath);
        maskLayerAnimation.toValue = (__bridge id)((smallCircleBP.CGPath));
        maskLayerAnimation.duration = [self transitionDuration:transitionContext];
        maskLayerAnimation.delegate = self;
        [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
    }
}

#pragma mark - CABasicAnimation的Delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    //告诉 iOS 这个 transition 完成
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    //清除 fromVC 的 mask
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}
@end
