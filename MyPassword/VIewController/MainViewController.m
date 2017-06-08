//
//  MainViewController.m
//  MyPassword
//
//  Created by JvanChow on 06/06/2017.
//  Copyright © 2017 JvanChow. All rights reserved.
//

#import "MainViewController.h"
#import "UIBarButtonItem+Extension.h"

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

}

- (void)rightAction {

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
//        UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
//        rightButton.titleLabel.font = [UIFont systemFontOfSize:17];
//        [rightButton setTitle:@"" forState:UIControlStateNormal];
//        [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [rightButton addTarget:self action:@selector(clearAction:) forControlEvents:UIControlEventTouchUpInside];
//
        //        _rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
        _rightBarButtonItem = [UIBarButtonItem rightBarButtonItemWithText:@"导出" target:self action:@selector(rightAction)];
    }

    return _rightBarButtonItem;
}

@end
