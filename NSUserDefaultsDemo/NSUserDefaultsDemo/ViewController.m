//
//  ViewController.m
//  NSUserDefaultsDemo
//
//  Created by 赵清 on 2016/11/14.
//  Copyright © 2016年 赵清. All rights reserved.
//


#import "ViewController.h"

// 博客： http://www.jianshu.com/p/459c15cf6ce2 了解NSUserDefaults中域的概念：应用域，注册域...

/*
 使用registerDefaults:的正确姿势
 
 initialValues与NSUserDefaults registerDefaults：
 
 初始值字典允许您提供一个方法将用户可配置的选项值恢复出厂设置。通常，这些值是您的应用程序使用NSUserDefaults的registerDefaults:方法注册的偏好设置的子集。
 
 调用NSUserDefaultsController的setInitialValues:方法不能代替NSUserDefault的registerDefaults:方法，后者用于注册应用程序偏好设置的偏好设置。
 
 清单2中的示例代码从应用程序包的一个文件中载入偏好设置的值，并通过NSUserDefaults注册这些值，然后注册这些值的一个子集作为共享的用户偏好设置控制器的初始值。setupDefaults方法会在您的应用程序委托的initialize类方法中调用。
 */

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
}

// 清单 2  更改sharedUserDefaultsController实例的初始值
+ (void)setupDefaults
{
    NSString *userDefaultsValuesPath;
    NSDictionary *userDefaultsValuesDict;
    NSDictionary *initialValuesDict;
    NSArray *resettableUserDefaultsKeys;
    
    // load the default values for the user defaults
    userDefaultsValuesPath=[[NSBundle mainBundle] pathForResource:@"UserDefaults"
                                                           ofType:@"plist"];
    userDefaultsValuesDict=[NSDictionary dictionaryWithContentsOfFile:userDefaultsValuesPath];
    
    // set them in the standard user defaults
    [[NSUserDefaults standardUserDefaults] registerDefaults:userDefaultsValuesDict];
    
    // if your application supports resetting a subset of the defaults to
    // factory values, you should set those values
    // in the shared user defaults controller
    resettableUserDefaultsKeys=[NSArray arrayWithObjects:@"Value1",@"Value2",@"Value3",nil];
    initialValuesDict=[userDefaultsValuesDict dictionaryWithValuesForKeys:resettableUserDefaultsKeys];
    
    // Set the initial values in the shared user defaults controller,NSUserDefaultsController为自定义设置类
//    [[NSUserDefaultsController sharedUserDefaultsController] setInitialValues:initialValuesDict];
}

@end
