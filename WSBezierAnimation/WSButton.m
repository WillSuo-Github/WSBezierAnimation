
//
//  WSButton.m
//  WSBezierAnimation
//
//  Created by ws on 2016/12/11.
//  Copyright © 2016年 WS. All rights reserved.
//

#import "WSButton.h"

@interface WSButton ()

@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (nonatomic, strong) CAShapeLayer *borderLayer;
@property (nonatomic, strong) UIButton *myButton;
@property (nonatomic, strong) CAShapeLayer *chickCicrlerLayer;
@property (nonatomic, strong) CAShapeLayer *loadingLayer;


@end

@implementation WSButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _borderLayer = [self drawMask:self.bounds.size.height / 2];
        _borderLayer.strokeColor = [UIColor redColor].CGColor;
        _borderLayer.fillColor = [UIColor clearColor].CGColor;
        _borderLayer.lineWidth = 0.5;
        [self.layer addSublayer:_borderLayer];
        
        [self.layer addSublayer:self.maskLayer];
        
        _myButton = ({
            UIButton *btn = [[UIButton alloc] initWithFrame:self.bounds];
            [btn setTitle:@"button" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(buttonChick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setBackgroundColor:[UIColor clearColor]];
            [self addSubview:btn];
            btn;
        });
        
    }
    return self;
}

- (void)buttonChick:(UIButton *)btn{
    [self chickAnimation];
}

- (void)chickAnimation{
    CAShapeLayer *chickCicrleLayer = [CAShapeLayer layer];
    chickCicrleLayer.frame = CGRectMake(self.bounds.size.width / 2, self.bounds.size.height / 2, 5, 5);
    chickCicrleLayer.fillColor = [UIColor whiteColor].CGColor;
    chickCicrleLayer.path = [self drawChickCicrleBezierPath:0].CGPath;
    [self.layer addSublayer:chickCicrleLayer];

    //圆圈变大
    CABasicAnimation *basicAni = [CABasicAnimation animationWithKeyPath:@"path"];
    basicAni.duration = 0.5;
    basicAni.toValue = (__bridge id _Nullable)([self drawChickCicrleBezierPath:(self.bounds.size.height - 20) / 2].CGPath);
    basicAni.removedOnCompletion = false;
    basicAni.fillMode = kCAFillModeForwards;
    [chickCicrleLayer addAnimation:basicAni forKey:@"baiscAni"];
    
    _chickCicrlerLayer = chickCicrleLayer;
    [self performSelector:@selector(chickNextAnimation) withObject:nil afterDelay:basicAni.duration];
}

- (void)chickNextAnimation{
    _chickCicrlerLayer.fillColor = [UIColor clearColor].CGColor;
    _chickCicrlerLayer.strokeColor = [UIColor whiteColor].CGColor;
    _chickCicrlerLayer.lineWidth = 10;
    
    
    CAAnimationGroup *groupAni = [CAAnimationGroup animation];
    //变大
    CABasicAnimation *basicAni = [CABasicAnimation animationWithKeyPath:@"path"];
    basicAni.duration = 0.5;
    basicAni.toValue = (__bridge id _Nullable)([self drawChickCicrleBezierPath:self.bounds.size.height - 20].CGPath);
    basicAni.removedOnCompletion = false;
    basicAni.fillMode = kCAFillModeForwards;
    
    
    //透明
    CABasicAnimation *alphaAni = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAni.beginTime = 0.1;
    alphaAni.duration = 0.5;
    alphaAni.toValue = @0;
    alphaAni.removedOnCompletion = false;
    alphaAni.fillMode = kCAFillModeForwards;
    
    groupAni.duration = alphaAni.beginTime + alphaAni.duration;
    groupAni.removedOnCompletion = false;
    groupAni.fillMode = kCAFillModeForwards;
    [groupAni setAnimations:@[basicAni, alphaAni]];
    
    [_chickCicrlerLayer addAnimation:groupAni forKey:@"groupAni"];
    [self performSelector:@selector(startMaskAnimation) withObject:nil afterDelay:groupAni.duration];
}

//半透明的登录按钮的背景
- (void)startMaskAnimation{
    _maskLayer.opacity = 0.5;
    CABasicAnimation *basicAni = [CABasicAnimation animationWithKeyPath:@"path"];
    basicAni.duration = 0.2;
    basicAni.toValue = (__bridge id _Nullable)([self drawBezierPath:self.bounds.size.height / 2].CGPath);
    basicAni.removedOnCompletion = false;
    basicAni.fillMode = kCAFillModeForwards;
    [_maskLayer addAnimation:basicAni forKey:@"maskAni"];

    [self performSelector:@selector(dismissAnimation) withObject:nil afterDelay:basicAni.duration];
}

//合拢边框 然后变透明
- (void)dismissAnimation{
    [self removeSubviews];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    CABasicAnimation *basicAni = [CABasicAnimation animationWithKeyPath:@"path"];
    basicAni.toValue = (__bridge id _Nullable)([self drawBezierPath:self.bounds.size.width / 2].CGPath);
    basicAni.duration = 0.3;
    basicAni.removedOnCompletion = false;
    basicAni.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *alphaAni = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAni.beginTime = 0.1;
    alphaAni.duration = 0.3;
    alphaAni.toValue = @0;
    alphaAni.removedOnCompletion = false;
    alphaAni.fillMode = kCAFillModeForwards;
    
    [group setAnimations:@[basicAni, alphaAni]];
    group.duration = alphaAni.beginTime + alphaAni.duration;
    group.removedOnCompletion = false;
    group.fillMode = kCAFillModeForwards;
    [_borderLayer addAnimation:group forKey:@"dismissAni"];
    
    [self performSelector:@selector(startLoadingAni) withObject:nil afterDelay:group.duration];
}

- (void)startLoadingAni{
    _loadingLayer = [CAShapeLayer layer];
    _loadingLayer.position = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    _loadingLayer.path = [self drawLoadingPath].CGPath;
    _loadingLayer.fillColor = [UIColor clearColor].CGColor;
    _loadingLayer.strokeColor = [UIColor redColor].CGColor;
    _loadingLayer.lineWidth = 2;
    [self.layer addSublayer:_loadingLayer];
    
    CABasicAnimation *basicAni = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basicAni.fromValue = @(0);
    basicAni.toValue = @(M_PI * 2);
    basicAni.duration = 1;
    basicAni.repeatCount = MAXFLOAT;
    basicAni.removedOnCompletion = false;
    basicAni.fillMode = kCAFillModeForwards;
    [_loadingLayer addAnimation:basicAni forKey:@"loadingAni"];
}


- (void)removeSubviews{
    [self.myButton removeFromSuperview];
    [self.maskLayer removeFromSuperlayer];
    [self.chickCicrlerLayer removeFromSuperlayer];
    [self.loadingLayer removeFromSuperlayer];
}

- (CAShapeLayer *)drawMask:(CGFloat)x{
    CAShapeLayer *layer =[CAShapeLayer layer];
    layer.path = [self drawBezierPath:x].CGPath;
    return layer;
}

- (UIBezierPath *)drawBezierPath:(CGFloat)x{
    CGFloat radius = self.bounds.size.height / 2 - 3;
    CGFloat right = self.bounds.size.width - x;
    CGFloat left = x;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    bezierPath.lineCapStyle = kCGLineCapRound;
    bezierPath.lineJoinStyle = kCGLineJoinRound;
    //左半圆
    [bezierPath addArcWithCenter:CGPointMake(left, self.bounds.size.height / 2) radius:radius startAngle:M_PI / 2  endAngle:-M_PI / 2 clockwise:true];
    //右半圆
    [bezierPath addArcWithCenter:CGPointMake(right, self.bounds.size.height / 2) radius:radius startAngle:- M_PI / 2 endAngle:M_PI / 2 clockwise:true];
    //闭环
    [bezierPath closePath];
    return bezierPath;
}

- (UIBezierPath *)drawLoadingPath{
    CGFloat radius = self.bounds.size.height / 2 - 3;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(0, 0) radius:radius startAngle:- M_PI / 2 endAngle:0 clockwise:true];
    return path;
}

- (UIBezierPath *)drawChickCicrleBezierPath:(CGFloat)radius{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath addArcWithCenter:CGPointMake(0, 0) radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:true];
    
    return bezierPath;
}

- (CAShapeLayer *)maskLayer{
    if (_maskLayer == nil) {
        _maskLayer = [CAShapeLayer layer];
        _maskLayer.opacity = 0;
        _maskLayer.path = [self drawBezierPath:self.bounds.size.width / 2].CGPath;
        _maskLayer.fillColor = [UIColor whiteColor].CGColor;
    }
    return _maskLayer;
}

@end
