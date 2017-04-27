//
//  WSSubmitButton.h
//  WSBezierAnimation
//
//  Created by WS on 2017/4/24.
//  Copyright © 2017年 WS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSSubmitButton : UIView

@property (nonatomic, copy) void(^tappedBlock)();
@end
