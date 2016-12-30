
//
//  TableViewController.m
//  多点触摸
//
//  Created by uuzuche on 15/8/9.
//  Copyright (c) 2015年 uuzuche. All rights reserved.
//

#import "TableViewController.h"
#import "ViewController.h"
#import "ViewControllerMotion.h"
#import "ViewControllerAccelerometer.h"
#import "ApplicationIconBadgeNumber.h"
#import "UIDeviceView.h"
#import "CopyViewController.h"
#import "DrawRectViewController.h"
#import "NotificationViewController.h"
#import "TextFieldViewController.h"
#import "CGAffineViewController.h"

@interface TableViewController (){
    NSDictionary *examples;
}

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor whiteColor];
    examples = @{
                @"多点触控":[[ViewController alloc] init],
                @"摇一摇":[[ViewControllerMotion alloc] init],
                @"加速度":[[ViewControllerAccelerometer alloc] init],
                @"应用程序标记的设置":[[ApplicationIconBadgeNumber alloc] init],
                @"获取UIDevice的相关信息":[[UIDeviceView alloc] init],
                @"复制":[[CopyViewController alloc] init],
                @"重绘":[[DrawRectViewController alloc] init],
                @"本地通知":[[NotificationViewController alloc] init],
                @"loadView":[[TextFieldViewController alloc] init],
                @"图片旋转":[[CGAffineViewController alloc] init]
                 };
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return examples.allKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qqq"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"qqq"];
    }
    cell.textLabel.text = examples.allKeys[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *view = examples.allValues[indexPath.row];
    view.title = examples.allKeys[indexPath.row];
    [self.navigationController pushViewController:view animated:YES];
}

@end
