//
//  WSPresentAnimation.h
//  WSBezierAnimation
//
//  Created by ws on 2016/12/12.
//  Copyright © 2016年 WS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WSPresentAnimationType) {
    WSPresentAnimationType_present = 0,//弹出动画
    WSPresentAnimationType_dismiss,//dismiss 动画
};

@interface WSPresentAnimation : NSObject<UIViewControllerAnimatedTransitioning>

+ (instancetype)animationWithType:(WSPresentAnimationType)type;

@end
