//
//  ViewControllerMotion.m
//  多点触摸
//
//  Created by uuzuche on 15/8/9.
//  Copyright (c) 2015年 uuzuche. All rights reserved.
//

#import "ViewControllerMotion.h"

@interface ViewControllerMotion ()

@end

@implementation ViewControllerMotion

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

// 监测手机振动，需要motionBegan一系列中的方法
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"地震了" message:@"别摇一摇了" delegate:nil cancelButtonTitle:@"没有妹子" otherButtonTitles:nil];
    [view show];
}


@end
