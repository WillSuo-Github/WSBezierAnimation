//
//  ViewController.m
//  WSBezierAnimation
//
//  Created by ws on 2016/12/11.
//  Copyright © 2016年 WS. All rights reserved.
//

#import "ViewController.h"
#import "WSButton.h"
#import "WSNextViewController.h"

@interface ViewController ()
@property (strong, nonatomic) WSButton *mybutton;
@property (nonatomic, strong) WSNextViewController *nextVc;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
}

#pragma mark layout
- (void)configSubViews{
    self.view.backgroundColor = [UIColor orangeColor];
    
    __weak typeof(self) weakSelf = self;
    _mybutton = ({
        WSButton *btn = [[WSButton alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
        [self.view addSubview:btn];
        [btn setAddActionBlock:^{
            WSNextViewController *nextVc = [[WSNextViewController alloc] init];
            [self presentViewController:nextVc animated:true completion:nil];
        }];
        btn;
    });
}

#pragma mark action
- (void)myButtonDidChick{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
