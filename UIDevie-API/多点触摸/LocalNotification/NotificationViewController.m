//
//  NotificationViewController.m
//  多点触摸
//
//  Created by uuzuche on 15/8/18.
//  Copyright (c) 2015年 uuzuche. All rights reserved.
//

#import "NotificationViewController.h"

@interface NotificationViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *dataPicker;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    // 允许用户选择一个距离现在至少60秒以后的时间
    _dataPicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:60];
}
- (IBAction)addReminder:(id)sender {
    NSDate *date = _dataPicker.date;
    NSLog(@"Setting a reminder for %@",date);
    UILocalNotification *note = [[UILocalNotification alloc] init];
    note.alertBody = @"别特么的睡了，起来嗨呀";
    note.fireDate = date;
    // 通知参数
    NSDictionary *userDict = [NSDictionary dictionaryWithObject:@"开始学习iOS开发了" forKey:@"key"];
    note.userInfo = userDict;
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
    }  

    [[UIApplication sharedApplication] scheduleLocalNotification:note];
}


// 取消某个本地推送通知
+ (void)cancelLocalNotificationWithKey:(NSString *)key {
    // 获取所有本地通知数组
    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    
    for (UILocalNotification *notification in localNotifications) {
        NSDictionary *userInfo = notification.userInfo;
        if (userInfo) {
            // 根据设置通知参数时指定的key来获取通知参数
            NSString *info = userInfo[key];
            
            // 如果找到需要取消的通知，则取消
            if (info != nil) {
                [[UIApplication sharedApplication] cancelLocalNotification:notification];
                break;  
            }  
        }  
    }  
}
@end
