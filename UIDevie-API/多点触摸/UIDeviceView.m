//
//  UIDeviceView.m
//  多点触摸
//
//  Created by uuzuche on 15/8/10.
//  Copyright (c) 2015年 uuzuche. All rights reserved.
//

#import "UIDeviceView.h"

@interface UIDeviceView ()
{
    NSString *_emoT;
}

@end
//将数字转为
#define EMOJI_CODE_TO_SYMBOL(x) ((((0x808080F0 | (x & 0x3F000) >> 4) | (x & 0xFC0) << 10) | (x & 0x1C0000) << 18) | (x & 0x3F) << 24);


@implementation UIDeviceView

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    // 电池电量，0.0-1.0
    NSLog(@"%f", [UIDevice currentDevice].batteryLevel);
    // 取得充电状态
    NSLog(@"%ld", (long)[UIDevice currentDevice].batteryState);
    // 本地型号名
    NSLog(@"本地型号名：%@", [UIDevice currentDevice].localizedModel);
    // 型号名
    NSLog(@"型号名：%@", [UIDevice currentDevice].model);
    // 用户自定义终端名
    NSLog(@"用户自定义终端名：%@", [UIDevice currentDevice].name);
    // OS名
    NSLog(@"OS名：%@", [UIDevice currentDevice].systemName);
    // OS版本
    NSLog(@"OS版本：%@", [UIDevice currentDevice].systemVersion);
    // 获取设备UUID
    NSLog(@"终端识别符：%@", [[[UIDevice currentDevice] identifierForVendor] UUIDString]);

    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // 当前应用名称
    NSString *appCurName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSLog(@"当前应用名称：%@", appCurName);
    // 当前应用软件版本 比如：1.0.1
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"当前应用软件版本:%@", appCurVersion);
    // 当前应用版本号码 int类型
    NSString *appCurVersionNum = [infoDictionary objectForKey:@"CFBundleVersion"];
    NSLog(@"当前应用版本号码：%@", appCurVersionNum);

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(batteryLevelDidChange)
                                                 name:UIDeviceBatteryLevelDidChangeNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(batteryStateDidChange)
                                                 name:UIDeviceBatteryStateDidChangeNotification
                                               object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(proximityStateDidChange) name:UIDeviceProximityStateDidChangeNotification object:nil];
    
    //获取单个表情
    int sym = EMOJI_CODE_TO_SYMBOL(0x1F600);
    _emoT = [[NSString alloc] initWithBytes:&sym length:sizeof(sym) encoding:NSUTF8StringEncoding];
    
    //获取数组表情
    NSArray *arrEmotion = [self defaultEmoticons];
    for (NSString *str in arrEmotion) {
        NSLog(@"===%@",str);
    }
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 100, 320, 50);
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:_emoT forState:UIControlStateNormal];
    [self.view addSubview:button];
}

//获取默认表情数组
- (NSArray *)defaultEmoticons {
    NSMutableArray *array = [NSMutableArray new];
    for (int i=0x1F600; i<=0x1F64F; i++) {
        if (i < 0x1F641 || i > 0x1F644) {
            int sym = EMOJI_CODE_TO_SYMBOL(i);
            NSString *emoT = [[NSString alloc] initWithBytes:&sym length:sizeof(sym) encoding:NSUTF8StringEncoding];
            [array addObject:emoT];
        }
    }
    return array;
}


// 接近传感器的使用（目前不能用，不知是否是touch的愿意）
- (void)proximityStateDidChange
{
    if ([UIDevice currentDevice].proximityState) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"接近传感器" message:@"duang duang duang" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

// 电池剩余电量发生变化
- (void)batteryLevelDidChange
{
    // 获取电量具体信息
    double deviceLevel = [UIDevice currentDevice].batteryLevel;
    NSString *battryStr = [NSString stringWithFormat:@"%.f%%%@",deviceLevel * 100,_emoT];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"电池剩余电量" message:battryStr delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

// 充点状态发生变化
- (void)batteryStateDidChange
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"充电状态变化" message:@"duang duang duang" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

@end
