//
//  AppDelegate.m
//  Restore
//
//  Created by 赵清 on 2016/11/12.
//  Copyright © 2016年 赵清. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "NavigationViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (!_window) {
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.restorationIdentifier = @"window";
        ViewController *vc = [[ViewController alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
        NavigationViewController *navi = [[NavigationViewController alloc] initWithRootViewController:vc];
        self.window.rootViewController = navi;
    }
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL) application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder {
    return YES;
}

- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder {
    return YES;
}

- (void)application:(UIApplication *)application willEncodeRestorableStateWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.window.rootViewController forKey:@"NavigationViewController1"];
}

- (void)application:(UIApplication *)application didDecodeRestorableStateWithCoder:(NSCoder *)coder {
    NavigationViewController * ctl = [coder decodeObjectForKey:@"NavigationViewController1"];
    if (ctl) {
        UIWindow * window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        window.rootViewController = ctl;
        self.window = window;
    }
}

@end
