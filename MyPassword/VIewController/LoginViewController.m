//
//  LoginViewController.m
//  MyPassword
//
//  Created by JvanChow on 06/06/2017.
//  Copyright © 2017 JvanChow. All rights reserved.
//

#import "LoginViewController.h"
#import <Masonry/Masonry.h>
#import "MainViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import <SVProgressHUD/SVProgressHUD.h>

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

    [self.view addSubview:self.fingerprintButton];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.loginButton];

    [self updateViewConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self fingerprintAction];
}

- (void)updateViewConstraints {
    if (!self.didSetupConstraints) {
        [self.fingerprintButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(50);
            make.center.equalTo(self.view);
        }];

        [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.top.equalTo(self.mas_topLayoutGuideBottom).offset(5);
            make.width.mas_equalTo(120);
        }];

        [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(30);
            make.top.equalTo(self.passwordTextField.mas_bottom).offset(5);
        }];

        self.didSetupConstraints = YES;
    }

    [super updateViewConstraints];
}

- (void)fingerprintAction {
    if ([UIDevice currentDevice].systemVersion.floatValue < 8.0) {
        return;
    }

    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    NSString *result = @"请验证已有指纹";

    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:result reply:^(BOOL success, NSError *error) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self changeRootViewControllerToMainViewController];
                });
            }
        }];
    } else {
        [SVProgressHUD showInfoWithStatus:@"不支持指纹"];
    }
}

- (void)loginAction {
    self.passwordTextField.hidden = NO;

    if ([self.passwordTextField.text isEqualToString:@"mima123"]) {
        [self changeRootViewControllerToMainViewController];
    }
}

- (void)changeRootViewControllerToMainViewController {
    [UIApplication sharedApplication].keyWindow.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[MainViewController alloc] init]];
}

#pragma mark - Getter

- (UIButton *)fingerprintButton {
    if (!_fingerprintButton) {
        _fingerprintButton = [[UIButton alloc] init];
        [_fingerprintButton setTitle:@"指纹" forState:UIControlStateNormal];
        [_fingerprintButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _fingerprintButton.titleLabel.font = [UIFont systemFontOfSize:18];
        _fingerprintButton.layer.cornerRadius = 20;
        _fingerprintButton.layer.borderColor = [UIColor grayColor].CGColor;
        _fingerprintButton.layer.borderWidth = 1;
        _fingerprintButton.backgroundColor = [UIColor whiteColor];
        [_fingerprintButton addTarget:self action:@selector(fingerprintAction) forControlEvents:UIControlEventTouchUpInside];
    }

    return _fingerprintButton;
}

- (UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.layer.borderColor = [UIColor grayColor].CGColor;
        _passwordTextField.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
        _passwordTextField.hidden = YES;
    }

    return _passwordTextField;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [[UIButton alloc] init];
        _loginButton.backgroundColor = [UIColor clearColor];
        [_loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    }

    return _loginButton;
}

@end
