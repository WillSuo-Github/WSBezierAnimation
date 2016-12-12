//
//  WSPresentAnimation.m
//  WSBezierAnimation
//
//  Created by ws on 2016/12/12.
//  Copyright © 2016年 WS. All rights reserved.
//

#import "WSPresentAnimation.h"

@interface WSPresentAnimation()<CAAnimationDelegate>

@property (nonatomic, assign) WSPresentAnimationType type;
@end

@implementation WSPresentAnimation

+ (instancetype)animationWithType:(WSPresentAnimationType)type{
    return [[self alloc] initWithAnimationType:type];
}

- (instancetype)initWithAnimationType:(WSPresentAnimationType)type{
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.6;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    switch (_type) {
        case WSPresentAnimationType_present:
            [self startPresentAnimation:transitionContext];
            break;
        case WSPresentAnimationType_dismiss:
            [self startDismissAnimation:transitionContext];
            break;
            
        default:
            break;
    }
}

- (void)startPresentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *buttonView = fromVc.view.subviews.lastObject;
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toVc.view];
    
    //画圆
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:buttonView.frame];
    
    CGFloat x = MAX(buttonView.frame.origin.x, containerView.bounds.size.width - buttonView.frame.origin.x);
    CGFloat y = MAX(buttonView.frame.origin.y, containerView.bounds.size.height - buttonView.frame.origin.y);
    CGFloat radius = sqrtf(pow(x, 2) + pow(y, 2));
    
    UIBezierPath *endPath = [UIBezierPath bezierPath];
    [endPath addArcWithCenter:buttonView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:true];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath;
    toVc.view.layer.mask = maskLayer;
    
    CABasicAnimation *basicMaskAni = [CABasicAnimation animationWithKeyPath:@"path"];
    basicMaskAni.fromValue = (__bridge id _Nullable)(startPath.CGPath);
    basicMaskAni.toValue = (__bridge id _Nullable)(endPath.CGPath);
    basicMaskAni.duration = [self transitionDuration:transitionContext];
    basicMaskAni.delegate = self;
    basicMaskAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [maskLayer addAnimation:basicMaskAni forKey:@"basicMaskAni"];
    [transitionContext completeTransition:true];
}

- (void)startDismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *buttonView = toVc.view.subviews.lastObject;
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toVc.view atIndex:0];
    
    CGFloat x = MAX(buttonView.frame.origin.x, containerView.bounds.size.width - buttonView.frame.origin.x);
    CGFloat y = MAX(buttonView.frame.origin.y, containerView.bounds.size.height - buttonView.frame.origin.y);
    CGFloat radius = sqrtf(pow(x, 2) + pow(y, 2));
    
    UIBezierPath *startPath = [UIBezierPath bezierPath];
    [startPath addArcWithCenter:buttonView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:true];
    
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:buttonView.frame];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath;
    fromVc.view.layer.mask = maskLayer;
    
    CABasicAnimation *basicMaskAni = [CABasicAnimation animationWithKeyPath:@"path"];
    basicMaskAni.fromValue = (__bridge id _Nullable)(startPath.CGPath);
    basicMaskAni.toValue = (__bridge id _Nullable)(endPath.CGPath);
    basicMaskAni.duration = [self transitionDuration:transitionContext];
    basicMaskAni.delegate = self;
    basicMaskAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [maskLayer addAnimation:basicMaskAni forKey:@"basicMaskAni"];

}


#pragma mark CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    switch (_type) {
        case WSPresentAnimationType_present:{
            
            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:true];
            [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
        }
            break;
        case WSPresentAnimationType_dismiss:{
            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if ([transitionContext transitionWasCancelled]) {
                [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
            }
            
        }
            break;
            
        default:
            break;
    }
}
@end
