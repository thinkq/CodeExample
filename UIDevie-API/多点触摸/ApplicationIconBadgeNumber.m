//
//  ApplicationIconBadgeNumber.m
//  多点触摸
//
//  Created by uuzuche on 15/8/9.
//  Copyright (c) 2015年 uuzuche. All rights reserved.
//

#import "ApplicationIconBadgeNumber.h"

@interface ApplicationIconBadgeNumber (){

    __weak IBOutlet UITextField *textNum;
}

@end

@implementation ApplicationIconBadgeNumber

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)commit:(id)sender {
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    /*
     因为在IOS8中要想设置applicationIconBadgeNumber，需要用户的授权,
     但是这两句授权代码如果是在IOS7的系统中运行的话就会报错，所以需要先判断IOS的版本，完整代码如下
     */
    if (version >= 8.0) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber = [textNum.text integerValue];
    textNum.text = @"";
}
- (IBAction)cancel:(id)sender {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}


@end
