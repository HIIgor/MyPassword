//
//  UIBarButtonItem+Extension.h
//  MyPassword
//
//  Created by JvanChow on 06/06/2017.
//  Copyright © 2017 JvanChow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

//+ (instancetype)closeBarButtonItemWithTarget:(id)target action:(SEL)action;

+ (instancetype)backBarButtonItemWithTarget:(id)target action:(SEL)action;

//+ (instancetype)backBarButtonItemWithTarget:(id)target action:(SEL)action title:(NSString *)title;

+ (instancetype)rightBarButtonItemWithText:(NSString *)title target:(id)target action:(SEL)action;

+ (instancetype)rightBarButtonItemWithIconFont:(NSString *)title target:(id)target action:(SEL)action;

@end
