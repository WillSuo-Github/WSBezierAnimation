//
//  ViewController.m
//  WSBezierAnimation
//
//  Created by ws on 2016/12/11.
//  Copyright © 2016年 WS. All rights reserved.
//

#import "ViewController.h"
#import "WSButton.h"

@interface ViewController ()
@property (strong, nonatomic) WSButton *mybutton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
}

#pragma mark layout
- (void)configSubViews{
    self.view.backgroundColor = [UIColor orangeColor];
    
    _mybutton = ({
        WSButton *btn = [[WSButton alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
        [self.view addSubview:btn];
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
