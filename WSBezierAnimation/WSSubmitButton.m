//
//  WSSubmitButton.m
//  WSBezierAnimation
//
//  Created by WS on 2017/4/24.
//  Copyright © 2017年 WS. All rights reserved.
//

#define MainColor [UIColor colorWithRed:0 green:194/255.0 blue:129/255.0 alpha:1]

#import "WSSubmitButton.h"

@interface WSSubmitButton ()

@property (nonatomic, strong) CAShapeLayer *borderLayer;
@property (nonatomic, strong) CATextLayer *textLayer;
@property (nonatomic, strong) CAShapeLayer *loadingLayer;

@property (nonatomic, assign) BOOL userInterface;
@end

@implementation WSSubmitButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self createTappedGesture];
        
        _borderLayer = [self createBorderLayer];
        [self.layer addSublayer:_borderLayer];
        
        _loadingLayer = [self createLoadingLayer];
        [_borderLayer addSublayer:_loadingLayer];
        
        _textLayer = [self createTextLayer];
        [self.layer addSublayer:_textLayer];
        
        _userInterface = true;

    }
    return self;
}

#pragma mark -
#pragma mark - layout
- (void)createTappedGesture{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidTapped)];
    [self addGestureRecognizer:tap];
}

- (CAShapeLayer *)createBorderLayer{
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.path = [self drawBorderPathWithRadius:self.bounds.size.height / 2].CGPath;
    layer.strokeColor = MainColor.CGColor;
    layer.fillColor = [UIColor whiteColor].CGColor;
    return layer;
}

- (CATextLayer *)createTextLayer{
    
    UIFont *font = [UIFont systemFontOfSize:12];
    
    CATextLayer *textLayer = [[CATextLayer alloc] init];
    textLayer.string = @"Submit";
    textLayer.alignmentMode = kCAAlignmentCenter;
    textLayer.truncationMode = kCATruncationNone;
    textLayer.wrapped = true;
    textLayer.fontSize = font.pointSize;
    textLayer.foregroundColor = MainColor.CGColor;
    textLayer.frame = CGRectMake(0, self.bounds.size.height / 2 - font.lineHeight / 2, self.bounds.size.width, font.lineHeight);
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    return textLayer;
}

- (CAShapeLayer *)createLoadingLayer{
    CAShapeLayer *loadingLayer = [[CAShapeLayer alloc] init];
    loadingLayer.path = [self drawLoadingPath].CGPath;
    //    loadingLayer.strokeColor = (__bridge CGColorRef _Nullable)([UIColor colorWithRed:25/255.0 green:204/255.0 blue:149/255.0 alpha:1]);
    loadingLayer.strokeColor = [UIColor colorWithRed:25/255.0 green:204/255.0 blue:149/255.0 alpha:1].CGColor;
    loadingLayer.fillColor = [UIColor clearColor].CGColor;
    loadingLayer.strokeStart = -M_PI_2;
    loadingLayer.opacity = 0;
    return loadingLayer;
}

- (UIBezierPath *)drawBorderPathWithRadius:(CGFloat)radius{
    CGPoint leftCenter = CGPointMake(radius, self.bounds.size.height / 2);
    CGPoint rightCenter = CGPointMake(self.bounds.size.width - radius, self.bounds.size.height / 2);
    radius = radius - 3;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:rightCenter radius:radius startAngle:-M_PI_2 endAngle:M_PI_2 clockwise:true];
    [path addArcWithCenter:leftCenter radius:radius startAngle:M_PI_2 endAngle:M_PI / 2 * 3 clockwise:true];
    path.lineWidth = 3.0f;
    
    [path closePath];
    return path;
}

- (UIBezierPath *)drawCenterPathWithRaidus:(CGFloat)radius{
    
    radius = radius - 3;
    CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:center radius:radius startAngle:-M_PI_2 endAngle:M_PI_2 clockwise:true];
    [path addArcWithCenter:center radius:radius startAngle:M_PI_2 endAngle:M_PI / 2 * 3 clockwise:true];
    path.lineWidth = 3.0f;
    [path closePath];
    return path;
}

- (UIBezierPath *)drawLoadingPath{
    
    CGFloat radius = self.bounds.size.height / 2 - 3;
    CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:center radius:radius startAngle:-M_PI_2 endAngle:M_PI / 2 * 3 clockwise:true];
    path.lineWidth = 3.0f;
    [path closePath];
    return path;
}



#pragma mark -
#pragma mark - tapped response
- (void)viewDidTapped{
    
    if (_userInterface) {
        [self startTappedAnimation];
        _userInterface = false;
    }
}

- (void)tappedDidResponse{
    
    _userInterface = true;
    if (self.tappedBlock) {
        self.tappedBlock();
    }
}

#pragma mark -
#pragma mark - animation
- (void)startTappedAnimation{
    CGFloat duration = .5f;
    
    CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"fillColor"];
    anim1.duration = duration;
    anim1.fromValue = (__bridge id _Nullable)([UIColor whiteColor].CGColor);
    anim1.toValue = (__bridge id _Nullable)(MainColor.CGColor);
    anim1.removedOnCompletion = false;
    anim1.fillMode = kCAFillModeForwards;
    [_borderLayer addAnimation:anim1 forKey:@"fillColor"];
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:duration];
    [CATransaction disableActions];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    _textLayer.foregroundColor =[UIColor whiteColor].CGColor;
    [CATransaction commit];
    
    [self performSelector:@selector(startScaleToCycleAnimation) withObject:nil afterDelay:duration];
}

- (void)startScaleToCycleAnimation{
    
    CGFloat duration = 0.5f;
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    CABasicAnimation *opacityAni = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAni.duration = duration / 2;
    opacityAni.fromValue = @(1);
    opacityAni.toValue = @(0);
    opacityAni.removedOnCompletion = false;
    opacityAni.fillMode = kCAFillModeForwards;
    opacityAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_textLayer addAnimation:opacityAni forKey:@"opacity"];
    
    CABasicAnimation *fillColorAni = [CABasicAnimation animationWithKeyPath:@"fillColor"];
    fillColorAni.duration = duration;
    fillColorAni.fromValue = (__bridge id _Nullable)(MainColor.CGColor);
    fillColorAni.toValue = (__bridge id _Nullable)([UIColor whiteColor].CGColor);
    fillColorAni.removedOnCompletion = false;
    fillColorAni.fillMode = kCAFillModeForwards;
    fillColorAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];

    CABasicAnimation *scaleCycleAni = [CABasicAnimation animationWithKeyPath:@"path"];
    scaleCycleAni.duration = duration;
    scaleCycleAni.fromValue = (__bridge id _Nullable)(_borderLayer.path);
    scaleCycleAni.toValue = (__bridge id _Nullable)([self drawCenterPathWithRaidus:self.bounds.size.height/2].CGPath);
    scaleCycleAni.removedOnCompletion = false;
    scaleCycleAni.fillMode = kCAFillModeForwards;
    scaleCycleAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    
    CABasicAnimation *strokeColorAni = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
    strokeColorAni.duration = duration;
    strokeColorAni.fromValue = (__bridge id _Nullable)(MainColor.CGColor);
    strokeColorAni.toValue = (__bridge id _Nullable)([UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1].CGColor);
    strokeColorAni.removedOnCompletion = false;
    strokeColorAni.fillMode = kCAFillModeForwards;
    strokeColorAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    group.duration = duration;
    group.animations = @[fillColorAni, scaleCycleAni, strokeColorAni];
    group.removedOnCompletion = false;
    group.fillMode = kCAFillModeForwards;
    [_borderLayer addAnimation:group forKey:@"gourp"];
    
    [self performSelector:@selector(startLoadingAnimation) withObject:nil afterDelay:duration];
    
}

- (void)startLoadingAnimation{
    CGFloat duration = 4;
    
    _loadingLayer.opacity = 1;
    CABasicAnimation *loadingAni = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    loadingAni.duration = duration;
    loadingAni.fromValue = [NSNumber numberWithFloat:0.1f];
    loadingAni.toValue = [NSNumber numberWithFloat:1.0f];
    loadingAni.removedOnCompletion = false;
    loadingAni.fillMode = kCAFillModeForwards;
    [_loadingLayer addAnimation:loadingAni forKey:@"strokeEnd"];
    
    [self performSelector:@selector(startSuccessAnimation) withObject:nil afterDelay:duration];
}

- (void)startSuccessAnimation{
    CGFloat duration = 1.0f;
    
    _loadingLayer.opacity = 0;
    
    UIFont *font = [UIFont systemFontOfSize:24];
    _textLayer.string = @"✓";
    _textLayer.fontSize = font.pointSize;
    _textLayer.frame = CGRectMake(0, self.bounds.size.height / 2 - font.lineHeight / 2, self.bounds.size.width, font.lineHeight);
    CABasicAnimation *opacityAni = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAni.duration = duration / 2;
    opacityAni.fromValue = @(0);
    opacityAni.toValue = @(1);
    opacityAni.removedOnCompletion = false;
    opacityAni.fillMode = kCAFillModeForwards;
    opacityAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_textLayer addAnimation:opacityAni forKey:@"opacity"];
    
    
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    CABasicAnimation *fillColorAni = [CABasicAnimation animationWithKeyPath:@"fillColor"];
    fillColorAni.duration = duration;
    fillColorAni.fromValue = (__bridge id _Nullable)([UIColor whiteColor].CGColor);
    fillColorAni.toValue = (__bridge id _Nullable)(MainColor.CGColor);
    fillColorAni.removedOnCompletion = false;
    fillColorAni.fillMode = kCAFillModeForwards;
    fillColorAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *scaleCycleAni = [CABasicAnimation animationWithKeyPath:@"path"];
    scaleCycleAni.duration = duration;
    scaleCycleAni.fromValue = (__bridge id _Nullable)([self drawCenterPathWithRaidus:self.bounds.size.height/2].CGPath);
    scaleCycleAni.toValue = (__bridge id _Nullable)(_borderLayer.path);
    scaleCycleAni.removedOnCompletion = false;
    scaleCycleAni.fillMode = kCAFillModeForwards;
    scaleCycleAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *strokeColorAni = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
    strokeColorAni.duration = duration;
    strokeColorAni.fromValue = (__bridge id _Nullable)([UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1].CGColor);
    strokeColorAni.toValue = (__bridge id _Nullable)(MainColor.CGColor);
    strokeColorAni.removedOnCompletion = false;
    strokeColorAni.fillMode = kCAFillModeForwards;
    strokeColorAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    group.animations = @[fillColorAni, scaleCycleAni, strokeColorAni];
    group.duration = duration;
    group.removedOnCompletion = false;
    group.fillMode = kCAFillModeForwards;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [_borderLayer addAnimation:group forKey:@"group"];
    
    [self performSelector:@selector(tappedDidResponse) withObject:nil afterDelay:duration];
}




@end
