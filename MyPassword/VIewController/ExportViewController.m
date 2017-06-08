//
//  ExportViewController.m
//  MyPassword
//
//  Created by JvanChow on 08/06/2017.
//  Copyright © 2017 JvanChow. All rights reserved.
//

#import "ExportViewController.h"

@interface ExportViewController ()

@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation ExportViewController

#pragma mark - ViewController LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setThemeColorPicker];
    [self setTrackEvent];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Do any additional setup before the view appear.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Do any addition operation when after view appear.
}

#pragma mark - autolayout

- (void)updateViewConstraints {
    if (!self.didSetupConstraints) {


        self.didSetupConstraints = YES;
    }

    [super updateViewConstraints];
}

#pragma mark - Private

- (void)setThemeColorPicker {

}

- (void)setTrackEvent {

}

#pragma mark - Public

#pragma mark - Setter

#pragma mark - Getter

@end