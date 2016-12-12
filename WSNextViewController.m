//
//  WSNextViewController.m
//  WSBezierAnimation
//
//  Created by ws on 2016/12/12.
//  Copyright © 2016年 WS. All rights reserved.
//

#import "WSNextViewController.h"
#import "WSPresentAnimation.h"

@interface WSNextViewController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIButton *myButton;
@end

@implementation WSNextViewController

- (instancetype)init{
    if (self = [super init]) {
        self.transitioningDelegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
}

- (void)configSubViews{
    self.view.backgroundColor = [UIColor purpleColor];
    
    _myButton = ({
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 10, 10)];
        btn.backgroundColor = [UIColor redColor];
        [btn addTarget:self action:@selector(dismissAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn;
    });
}

- (void)dismissAction{
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
}

#pragma -mark UIViewControllerTransitioningDelegate
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [WSPresentAnimation animationWithType:WSPresentAnimationType_present];
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [WSPresentAnimation animationWithType:WSPresentAnimationType_dismiss];
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
