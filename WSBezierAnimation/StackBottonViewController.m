//
//  StackBottonViewController.m
//  WSBezierAnimation
//
//  Created by WS on 2017/5/3.
//  Copyright © 2017年 WS. All rights reserved.
//

#import "StackBottonViewController.h"
#import "YYCategories.h"
#import <Masonry/Masonry.h>
#import "StackCollectionCell.h"

@interface StackBottonViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIView *navigationView;
@property (nonatomic, strong) UICollectionView *myCollectionView;
@property (nonatomic, strong) UIView *centerContentView;

@property (nonatomic, copy) NSArray<NSString *> *collectionSourceArr;
@end

@implementation StackBottonViewController

#pragma mark -
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configSubViews];
}

#pragma mark -
#pragma mark - layout
- (void)configSubViews {
    self.view.backgroundColor = [UIColor colorWithHexString:@"29292a"];
    
    [self.view addSubview:self.navigationView];
    [_navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.view);
        make.height.mas_equalTo(70);
    }];
    
    [self.view addSubview:self.myCollectionView];
    [_myCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_navigationView.mas_bottom).offset(20);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(300);
    }];
    
    [self.view addSubview:self.centerContentView];
    [_centerContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_myCollectionView.mas_bottom).offset(20);
        make.height.mas_equalTo(60);
        make.left.right.equalTo(self.view);
    }];
}


#pragma mark -
#pragma mark - UICollectionViewDelegate

#pragma mark -
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.collectionSourceArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    StackCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.imageName = self.collectionSourceArr[indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark - lazy
- (UIView *)navigationView {
    if (_navigationView == nil) {
        _navigationView = [[UIView alloc] init];
        _navigationView.backgroundColor = [UIColor colorWithHexString:@"394a52"];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"PHOTOS";
        [titleLabel setTextColor:[UIColor whiteColor]];
        [_navigationView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_navigationView).offset(20);
            make.bottom.equalTo(_navigationView.mas_bottom).offset(-10);
        }];
        
        UIButton *rightNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightNavBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
        [_navigationView addSubview:rightNavBtn];
        [rightNavBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(titleLabel);
            make.right.equalTo(_navigationView).offset(-20);
        }];
        
    }
    return _navigationView;
}

- (UICollectionView *)myCollectionView {
    if (_myCollectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(150, 300);
        _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        _myCollectionView.showsVerticalScrollIndicator = false;
        _myCollectionView.showsHorizontalScrollIndicator = false;
        _myCollectionView.backgroundColor = [UIColor colorWithHexString:@"29292a"];
        [_myCollectionView registerClass:[StackCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _myCollectionView;
}

- (UIView *)centerContentView {
    if (_centerContentView == nil) {
        _centerContentView = [[UIView alloc] init];
        _centerContentView.backgroundColor = [UIColor colorWithHexString:@"424a53"];
        
        UILabel *detailLabel = [[UILabel alloc] init];
        detailLabel.textColor = [UIColor whiteColor];
        detailLabel.text = @"BARCELONA TRIP";
        [_centerContentView addSubview:detailLabel];
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_centerContentView).offset(20);
            make.centerY.equalTo(_centerContentView);
        }];
        
        UILabel *moreLabel = [[UILabel alloc] init];
        moreLabel.textColor = [UIColor whiteColor];
        moreLabel.text = @">";
        [_centerContentView addSubview:moreLabel];
        [moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_centerContentView.mas_right).offset(-20);
            make.centerY.equalTo(_centerContentView);
        }];
    }
    return _centerContentView;
}

- (NSArray<NSString *> *)collectionSourceArr {
    if (_collectionSourceArr == nil) {
        NSMutableArray *tmpArr = [NSMutableArray array];
        for (int i = 1; i < 21; i ++) {
            NSString *imageName = [NSString stringWithFormat:@"timg-%d", i];
            [tmpArr addObject:imageName];
        }
        _collectionSourceArr = tmpArr;
    }
    return _collectionSourceArr;
}
@end
