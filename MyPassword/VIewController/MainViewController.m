//
//  MainViewController.m
//  MyPassword
//
//  Created by JvanChow on 06/06/2017.
//  Copyright © 2017 JvanChow. All rights reserved.
//

#import "MainViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "UIView+position.h"
#import <Masonry/Masonry.h>

@interface MainViewController ()

@property (nonatomic, assign) BOOL didSetupConstraints;

@property (nonatomic, strong) UIBarButtonItem *leftBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *rightBarButtonItem;

@end

@implementation MainViewController

#pragma mark - ViewController LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.title = @"主界面";
    self.navigationItem.leftBarButtonItem = self.leftBarButtonItem;
    self.navigationItem.rightBarButtonItem = self.rightBarButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

#pragma mark - autolayout

- (void)updateViewConstraints {
    if (!self.didSetupConstraints) {


        self.didSetupConstraints = YES;
    }

    [super updateViewConstraints];
}

#pragma mark - Private

- (void)leftAction {
    NSLog(@"leftAction");
}

- (void)rightAction {
    NSLog(@"rightAction");
}

- (void)addAction {
    NSLog(@"addAction");
}

#pragma mark - Public

#pragma mark - Getter

- (UIBarButtonItem *)leftBarButtonItem {
    if (!_leftBarButtonItem) {
        _leftBarButtonItem = [UIBarButtonItem rightBarButtonItemWithText:@"导入" target:self action:@selector(leftAction)];
    }

    return _leftBarButtonItem;
}

- (UIBarButtonItem *)rightBarButtonItem {
    if (!_rightBarButtonItem) {
        _rightBarButtonItem = [UIBarButtonItem rightBarButtonItemWithText:@"导出" target:self action:@selector(rightAction)];
        _rightBarButtonItem.customView.frameWidth = 130;

        UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(86, 0, 44, 44)];
        addButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [addButton setTitle:@"添加" forState:UIControlStateNormal];
        [addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
        [addButton setTitleEdgeInsets:UIEdgeInsetsMake(-1, 0, 0, 0)];

        CGSize size = [@"添加" sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17],}];
        addButton.frameWidth = size.width + 6;
        [_rightBarButtonItem.customView addSubview:addButton];
    }

    return _rightBarButtonItem;
}

@end
