//
//  LoginViewController.m
//  MyPassword
//
//  Created by JvanChow on 06/06/2017.
//  Copyright © 2017 JvanChow. All rights reserved.
//

#import "LoginViewController.h"
#import <Masonry/Masonry.h>

@interface LoginViewController ()

@property (nonatomic, assign) BOOL didSetupConstraints;

@property (nonatomic, strong) UIButton *fingerprintButton;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton *loginButton;

@end

@implementation LoginViewController

#pragma mark - ViewController LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.loginButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

- (void)updateViewConstraints {
    if (!self.didSetupConstraints) {
        [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            
        }];

        self.didSetupConstraints = YES;
    }

    [super updateViewConstraints];
}


#pragma mark - Getter

- (UIButton *)fingerprintButton {
    if (!_fingerprintButton) {
        _fingerprintButton = [[UIButton alloc] init];
        [_fingerprintButton setTitle:@"指纹" forState:UIControlStateNormal];
        [_fingerprintButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _fingerprintButton.titleLabel.font = [UIFont systemFontOfSize:18];
        _fingerprintButton.layer.cornerRadius = 20;
        _fingerprintButton.backgroundColor = [UIColor whiteColor];
    }

    return _fingerprintButton;
}

- (UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.layer.borderColor = [UIColor grayColor].CGColor;
        _loginButton.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
    }

    return _passwordTextField;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] init];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:18];
        _loginButton.layer.borderColor = [UIColor grayColor].CGColor;
        _loginButton.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
        _loginButton.backgroundColor = [UIColor whiteColor];
    }

    return _loginButton;
}

@end
