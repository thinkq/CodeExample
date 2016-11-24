//
//  SecondViewController.m
//  Restore
//
//  Created by 赵清 on 2016/11/21.
//  Copyright © 2016年 赵清. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()<UIViewControllerRestoration>

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.restorationIdentifier = @"SecondViewController";
    self.restorationClass = [self class];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.view.backgroundColor = [UIColor greenColor];
}

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.view.backgroundColor forKey:@"secondbackgroundcolor"];
    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    self.view.backgroundColor = [coder decodeObjectForKey:@"secondbackgroundcolor"];
    [super decodeRestorableStateWithCoder:coder];
}

+ (UIViewController *)viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder
{
    SecondViewController *vc = [[SecondViewController alloc] init];
    vc.restorationIdentifier = @"ViewController";
    vc.restorationClass = [SecondViewController class];
    return vc;
}

@end
