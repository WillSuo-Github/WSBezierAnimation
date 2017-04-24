//
//  WSPresentViewController.m
//  WSBezierAnimation
//
//  Created by WS on 2017/4/24.
//  Copyright © 2017年 WS. All rights reserved.
//

#import "WSPresentViewController.h"
#import "WSButton.h"
#import "WSPresentNextViewController.h"

@interface WSPresentViewController ()
@property (strong, nonatomic) WSButton *mybutton;
@property (nonatomic, strong) WSPresentNextViewController *nextVc;
@end

@implementation WSPresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configSubViews];
}

#pragma mark layout
- (void)configSubViews{
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    __weak typeof(self) weakSelf = self;
    _mybutton = ({
        WSButton *btn = [[WSButton alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
        [self.view addSubview:btn];
        [btn setAddActionBlock:^{
            WSPresentNextViewController *nextVc = [[WSPresentNextViewController alloc] init];
            [weakSelf presentViewController:nextVc animated:true completion:nil];
        }];
        btn;
    });
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
