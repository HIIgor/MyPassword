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
#import "AddViewController.h"
#import "PasswordModel.h"

@interface MainViewController () <UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchResultsUpdating>

@property (nonatomic, assign) BOOL didSetupConstraints;

@property (nonatomic, strong) UIBarButtonItem *leftBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *rightBarButtonItem;

@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSources;
@property (nonatomic, strong) NSMutableArray *searchDataSources;

@end

@implementation MainViewController

#pragma mark - ViewController LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.definesPresentationContext=YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.title = @"主界面";
    self.navigationItem.leftBarButtonItem = self.leftBarButtonItem;
    self.navigationItem.rightBarButtonItem = self.rightBarButtonItem;

    [self.view addSubview:self.tableView];

    [self updateViewConstraints];

    self.dataSources = [NSMutableArray array];
    self.searchDataSources = [NSMutableArray array];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self loadData];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

#pragma mark - autolayout

- (void)updateViewConstraints {
    if (!self.didSetupConstraints) {
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_topLayoutGuideBottom);
            make.bottom.equalTo(self.view);
            make.width.and.centerX.equalTo(self.view);
        }];

        self.didSetupConstraints = YES;
    }

    [super updateViewConstraints];
}

#pragma mark - Private

- (void)leftAction {

}

- (void)rightAction {

}

- (void)addAction {
    [self pushToAddViewController:nil];
}

- (void)pushToAddViewController:(PasswordModel *)passwordModel {
    AddViewController *addVC = [[AddViewController alloc] init];
    addVC.passwordModel = passwordModel;
    [self.navigationController pushViewController:addVC animated:YES];
}

- (void)loadData {
    [self.dataSources removeAllObjects];
    [self.dataSources addObjectsFromArray:[PasswordModel allObjects]];
}

#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchController.active) {
        return [self.searchDataSources count];
    } else {
        return [self.dataSources count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainViewController"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"MainViewController"];
    }

    PasswordModel *passwordModel;

    if (self.searchController.active) {
        passwordModel = self.searchDataSources[indexPath.row];
    } else {
        passwordModel = self.dataSources[indexPath.row];
    }

    cell.textLabel.text = passwordModel.title;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PasswordModel *passwordModel;

    if (self.searchController.active) {
        passwordModel = self.searchDataSources[indexPath.row];
    } else {
        passwordModel = self.dataSources[indexPath.row];
    }

    [self pushToAddViewController:passwordModel];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.searchController.active) {
        return UITableViewCellEditingStyleNone;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    PasswordModel *passwordModel = self.dataSources[indexPath.row];

    UIAlertController *alertController = [[UIAlertController alloc] init];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm deleteObject:passwordModel];
        [realm commitWriteTransaction];

        [self.dataSources removeObject:passwordModel];
        [self.tableView reloadData];

    }];

    [alertController addAction:cancelAction];
    [alertController addAction:sureAction];

    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - SearchControllerDelegate
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    if (self.searchDataSources!= nil) {
        [self.searchDataSources removeAllObjects];
    }

    NSString *searchString = [self.searchController.searchBar text];

    if (!searchString.length || ![searchString stringByReplacingOccurrencesOfString:@" " withString:@""].length) {
        [self.tableView reloadData];
        return;
    }

    searchString = [searchString lowercaseString];

    for (PasswordModel *model in self.dataSources) {
        if ([model.title containsString:searchString] ||
            [model.password containsString:searchString] ||
            [model.detailDescription containsString:searchString]) {
            [self.searchDataSources addObject:model];
        }
    }

    [self.tableView reloadData];
}

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

- (UISearchController *)searchController {
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.delegate= self;
        _searchController.searchResultsUpdater = self;
        _searchController.searchBar.barTintColor = [UIColor grayColor];
        _searchController.searchBar.tintColor = [UIColor blackColor];
        _searchController.searchBar.placeholder= @"请输入关键字搜索";
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.searchBar.frameHeight = 44.0;
    }

    return _searchController;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 44.f;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.tableHeaderView = self.searchController.searchBar;
    }

    return _tableView;
}

@end
