//
//  UIBarButtonItem+Extension.m
//  MyPassword
//
//  Created by JvanChow on 06/06/2017.
//  Copyright © 2017 JvanChow. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+position.h"

@implementation UIBarButtonItem (Extension)

//+ (instancetype)closeBarButtonItemWithTarget:(id)target action:(SEL)action {
//    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    backButton.accessibilityIdentifier = @"closeBack";
//    backButton.rrc_eventId = @"closeBackButton";
//
//    BONChain *baseChain = BONChain.new.font(kNavigationBarIconFont).string(kIconFontNavigationBarClose40).baselineOffset(-1);
//    [baseChain appendLink:[RRCBonChain chainWithSpace]];
//    [baseChain appendLink:BONChain.new.string(@"关闭").font([UIFont systemFontOfSize:17])];
//
//    BONChain *normalChain = BONChain.new.color(DKCurrentThemeColorWithKey(THEME_TEXT_PRIMARY));
//    [normalChain appendLink:baseChain];
//
//    BONChain *highlitedChain = BONChain.new.color([DKCurrentThemeColorWithKey(THEME_TEXT_PRIMARY) colorWithAlphaComponent:0.4f]);
//    [highlitedChain appendLink:baseChain];
//
//    [backButton setAttributedTitle:normalChain.attributedString forState:UIControlStateNormal];
//    [backButton setAttributedTitle:highlitedChain.attributedString forState:UIControlStateHighlighted];
//
//    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    [backButton setTitleEdgeInsets:UIEdgeInsetsMake(-2, -10, 0, 0)];
//    [backButton setFrame:CGRectMake(0, 0, 50, 44)];
//
//    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//
//    return buttonItem;
//}

+ (instancetype)backBarButtonItemWithTarget:(id)target action:(SEL)action {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitleEdgeInsets:UIEdgeInsetsMake(-2, -15, 0, 0)];
    backButton.frame = CGRectMake(0, 0, 44, 44);

    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];

    return backBarButtonItem;
}

+ (instancetype)rightBarButtonItemWithText:(NSString *)title target:(id)target action:(SEL)action {
    UIButton *rightBarButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    rightBarButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [rightBarButton setTitle:title forState:UIControlStateNormal];
    [rightBarButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBarButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [rightBarButton setTitleEdgeInsets:UIEdgeInsetsMake(-1, 0, 0, 0)];

    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17],}];
    rightBarButton.frameWidth = size.width + 6;

    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButton];

    return rightBarButtonItem;
}

@end
