//
//  ViewController.m
//  WSBezierAnimation
//
//  Created by ws on 2016/12/11.
//  Copyright © 2016年 WS. All rights reserved.
//

#import "ViewController.h"
#import "WSPresentViewController.h"
#import "WSSubmitButtonController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *sourceArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:tableView];
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView;
    });
}


#pragma mark -
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",_sourceArr[indexPath.row]);
    switch (indexPath.row) {
        case 0:
            [self presentViewController:[[WSPresentViewController alloc] init] animated:true completion:nil];
            break;
        case 1:
            [self presentViewController:[[WSSubmitButtonController alloc] init] animated:true completion:nil];
            break;
            
        default:
            break;
    }
}

#pragma mark -
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = _sourceArr[indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark - lazy
- (NSArray *)sourceArr{
    if (!_sourceArr) {
        _sourceArr = @[@"presentAni", @"SubmitButton", @"2"];
    }
    return _sourceArr;
}

@end



