//
//  AddViewController.m
//  MyPassword
//
//  Created by JvanChow on 08/06/2017.
//  Copyright © 2017 JvanChow. All rights reserved.
//

#import "AddViewController.h"
#import "UIBarButtonItem+Extension.h"
#import <Masonry/Masonry.h>

@interface AddViewController ()

@property (nonatomic, assign) BOOL didSetupConstraints;

@property (nonatomic, strong) UIBarButtonItem *rightBarButtonItem;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *titleTextField;
@property (nonatomic, strong) UILabel *passwordLabel;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UITextView *descriptionTextView;

@end

@implementation AddViewController

#pragma mark - ViewController LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"创建";
    self.navigationItem.rightBarButtonItem = self.rightBarButtonItem;

    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.titleTextField];
    [self.view addSubview:self.passwordLabel];
    [self.view addSubview:self.passwordTextField];
    [self.view addSubview:self.descriptionLabel];
    [self.view addSubview:self.descriptionTextView];

    [self updateViewConstraints];
}

#pragma mark - autolayout

- (void)updateViewConstraints {
    if (!self.didSetupConstraints) {
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(15);
            make.top.equalTo(self.view).offset(80);
            make.width.equalTo(@50);
        }];

        [self.titleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(15);
            make.height.equalTo(@30);
            make.right.equalTo(self.view).offset(-15);
            make.centerY.equalTo(self.titleLabel);
        }];

        [self.passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.equalTo(self.titleLabel);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
        }];

        [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.passwordLabel);
            make.width.height.equalTo(self.titleTextField);
            make.left.equalTo(self.passwordLabel.mas_right).offset(15);
        }];

        [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.equalTo(self.titleLabel);
            make.top.equalTo(self.passwordTextField.mas_bottom).offset(20);
        }];

        [self.descriptionTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel);
            make.width.equalTo(self.view).offset(-30);
            make.top.equalTo(self.descriptionLabel.mas_bottom).offset(20);
            make.bottom.equalTo(self.mas_bottomLayoutGuideTop).offset(-20);
        }];

        self.didSetupConstraints = YES;
    }

    [super updateViewConstraints];
}

#pragma mark - Private

- (void)saveAction {
    PasswordModel *passwordModel = [[PasswordModel alloc] init];
    passwordModel.title = self.titleTextField.text;
    passwordModel.password = self.passwordTextField.text;
    passwordModel.detailDescription = self.descriptionTextView.text;

    if (self.passwordModel) {
        passwordModel.number = self.passwordModel.number;
    } else {
        PasswordModel *lastObject = [[PasswordModel allObjects] lastObject];
        passwordModel.number = lastObject.number + 1;
    }

    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addOrUpdateObject:passwordModel];
    [realm commitWriteTransaction];

    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Public

- (void)setPasswordModel:(PasswordModel *)passwordModel {
    _passwordModel = passwordModel;

    self.titleTextField.text = passwordModel.title;
    self.passwordTextField.text = passwordModel.password;
    self.descriptionTextView.text = passwordModel.detailDescription;
}

#pragma mark - Getter

- (UIBarButtonItem *)rightBarButtonItem {
    if (!_rightBarButtonItem) {
        _rightBarButtonItem = [UIBarButtonItem rightBarButtonItemWithText:@"保存" target:self action:@selector(saveAction)];
    }

    return _rightBarButtonItem;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"标题:";
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor blackColor];
    }

    return _titleLabel;
}

- (UITextField *)titleTextField {
    if (!_titleTextField) {
        _titleTextField = [[UITextField alloc] init];
        _titleTextField.textColor = [UIColor blackColor];
        _titleTextField.font = [UIFont systemFontOfSize:15];
        _titleTextField.layer.borderColor = [UIColor grayColor].CGColor;
        _titleTextField.layer.borderWidth = [UIScreen mainScreen].scale / 1;
    }

    return _titleTextField;
}

- (UILabel *)passwordLabel {
    if (!_passwordLabel) {
        _passwordLabel = [[UILabel alloc] init];
        _passwordLabel.text = @"密码:";
        _passwordLabel.font = [UIFont systemFontOfSize:16];
        _passwordLabel.textColor = [UIColor blackColor];
    }

    return _passwordLabel;
}

- (UITextField *)passwordTextField {
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.textColor = [UIColor blackColor];
        _passwordTextField.font = [UIFont systemFontOfSize:15];
        _passwordTextField.layer.borderColor = [UIColor grayColor].CGColor;
        _passwordTextField.layer.borderWidth = [UIScreen mainScreen].scale / 1;
    }

    return _passwordTextField;
}

- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.text = @"描述:";
        _descriptionLabel.font = [UIFont systemFontOfSize:16];
        _descriptionLabel.textColor = [UIColor blackColor];
    }

    return _descriptionLabel;
}

- (UITextView *)descriptionTextView {
    if (!_descriptionTextView) {
        _descriptionTextView = [[UITextView alloc] init];
        _descriptionTextView.textColor = [UIColor blackColor];
        _descriptionTextView.font = [UIFont systemFontOfSize:15];
        _descriptionTextView.layer.borderColor = [UIColor grayColor].CGColor;
        _descriptionTextView.layer.borderWidth = [UIScreen mainScreen].scale / 1;
    }

    return _descriptionTextView;
}

@end
