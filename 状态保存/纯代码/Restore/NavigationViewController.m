//
//  NavigationViewController.m
//  Restore
//
//  Created by 赵清 on 2016/11/21.
//  Copyright © 2016年 赵清. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()<UIViewControllerRestoration>

@end

@implementation NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.restorationIdentifier = @"NavigationViewController";
    self.restorationClass = [self class];
}

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    [super decodeRestorableStateWithCoder:coder];
}

+ (UIViewController *)viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder
{
    NavigationViewController *vc = [[NavigationViewController alloc] init];
    vc.restorationIdentifier = @"NavigationViewController";
    vc.restorationClass = [NavigationViewController class];
    return vc;
}

@end
