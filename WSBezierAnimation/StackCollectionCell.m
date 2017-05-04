//
//  StackCollectionCell.m
//  WSBezierAnimation
//
//  Created by WS on 2017/5/3.
//  Copyright © 2017年 WS. All rights reserved.
//

#import "StackCollectionCell.h"
#import <Masonry/Masonry.h>

@interface StackCollectionCell ()

@property (nonatomic, strong) UIImageView *myImageView;
@end

@implementation StackCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self configSubviews];
    }
    return self;
}

#pragma mark -
#pragma mark - layout 
- (void)configSubviews {
    
    [self addSubview:self.myImageView];
    [_myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark -
#pragma mark - setter and getter
- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    [_myImageView setImage:[UIImage imageNamed:imageName]];
    
}

#pragma mark -
#pragma mark - lazy
- (UIImageView *)myImageView {
    if (_myImageView == nil) {
        _myImageView = [[UIImageView alloc] init];
    }
    return _myImageView;
}

@end
