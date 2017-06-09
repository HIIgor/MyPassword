//
//  PasswordModel.h
//  MyPassword
//
//  Created by JvanChow on 08/06/2017.
//  Copyright © 2017 JvanChow. All rights reserved.
//

#import <Realm/Realm.h>
#import <UIKit/UIKit.h>

@interface PasswordModel : RLMObject

@property NSInteger number;
@property NSString *title;
@property NSString *password;
@property NSString *detailDescription;

@end

RLM_ARRAY_TYPE(PasswordModel)
