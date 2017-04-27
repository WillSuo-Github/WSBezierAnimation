//
//  WSSubmitButtonController.m
//  WSBezierAnimation
//
//  Created by WS on 2017/4/24.
//  Copyright © 2017年 WS. All rights reserved.
//

#import "WSSubmitButtonController.h"
#import "WSSubmitButton.h"

@interface WSSubmitButtonController ()

@end

@implementation WSSubmitButtonController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configSubViews];
}

#pragma mark -
#pragma mark - layout
- (void)configSubViews{
    WSSubmitButton *submitBtn = [[WSSubmitButton alloc] initWithFrame:CGRectMake(100, 100, 120, 37)];
    [self.view addSubview:submitBtn];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
