//
//  ExportViewController.m
//  MyPassword
//
//  Created by JvanChow on 08/06/2017.
//  Copyright © 2017 JvanChow. All rights reserved.
//

#import "ExportViewController.h"
#import <Masonry/Masonry.h>
#import "PasswordModel.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "UIBarButtonItem+Extension.h"

@interface ExportViewController ()

@property (nonatomic, assign) BOOL didSetupConstraints;

@property (nonatomic, strong) UIBarButtonItem *rightBarButtonItem;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *textView;

@end

@implementation ExportViewController

#pragma mark - ViewController LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.type == 0) {
        self.navigationItem.title = @"导出";
        [self export];
    } else {
        self.navigationItem.title = @"导入页面";
        self.navigationItem.rightBarButtonItem = self.rightBarButtonItem;
    }

    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.textView];

    [self updateViewConstraints];
}

#pragma mark - autolayout

- (void)updateViewConstraints {
    if (!self.didSetupConstraints) {
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(15);
            make.right.equalTo(self.view).offset(-15);
            make.top.equalTo(self.mas_topLayoutGuideBottom).offset(15);
        }];

        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(15);
            make.right.equalTo(self.view).offset(-15);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(15);
            make.bottom.equalTo(self.mas_bottomLayoutGuideTop).offset(-15);
        }];

        self.didSetupConstraints = YES;
    }

    [super updateViewConstraints];
}

#pragma mark - Private

- (void)export {
    NSMutableArray *array = [NSMutableArray array];
    NSMutableDictionary *dictionary;

    for (PasswordModel *model in [PasswordModel allObjects]) {
        dictionary = [NSMutableDictionary dictionary];
        [dictionary setObject:@(model.number) ?: @"" forKey:@"number"];
        [dictionary setObject:model.title ?: @"" forKey:@"title"];
        [dictionary setObject:model.password ?: @"" forKey:@"password"];
        [dictionary setObject:model.detailDescription ?: @"" forKey:@"detailDescription"];
        [array addObject:dictionary];
    }

    NSData *data=[NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    self.textView.text = jsonString;
}

- (void)importAction {
    NSData *objectData = [self.textView.text dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:objectData options:NSJSONReadingMutableContainers error:&error];

    if (error || ![jsonArray isKindOfClass:[NSArray class]]) {
        [SVProgressHUD showInfoWithStatus:@"格式有误"];
    } else {
        NSInteger number = -1;
        if ([PasswordModel allObjects].count > 0) {
            number = ((PasswordModel *)[[PasswordModel allObjects] lastObject]).number;
        }

        for (NSDictionary *dict in jsonArray) {
            PasswordModel *model = [[PasswordModel alloc] init];
            model.title = [dict objectForKey:@"title"] ?: @"";
            model.password = [dict objectForKey:@"password"] ?: @"";
            model.detailDescription = [dict objectForKey:@"detailDescription"] ?: @"";

            if (number == -1) {
                model.number = ((NSNumber *)[dict objectForKey:@"number"]).integerValue;
            } else {
                number++;
                model.number = number;
            }

            RLMRealm *realm = [RLMRealm defaultRealm];
            [realm beginWriteTransaction];
            [realm addOrUpdateObject:model];
            [realm commitWriteTransaction];
        }

        [SVProgressHUD showSuccessWithStatus:@"完成"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Getter

- (UIBarButtonItem *)rightBarButtonItem {
    if (!_rightBarButtonItem) {
        _rightBarButtonItem = [UIBarButtonItem rightBarButtonItemWithText:@"导入" target:self action:@selector(importAction)];
    }

    return _rightBarButtonItem;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"格式是：数组中包含密码实体(key有：number, title, password, detailDescription)";
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 2;
    }

    return _titleLabel;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.textColor = [UIColor blackColor];
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.layer.borderColor = [UIColor grayColor].CGColor;
        _textView.layer.borderWidth = [UIScreen mainScreen].scale / 1;
    }

    return _textView;
}

@end
