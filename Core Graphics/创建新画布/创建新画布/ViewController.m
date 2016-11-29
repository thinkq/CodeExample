//
//  ViewController.m
//  创建新画布
//
//  Created by 赵清 on 2016/11/29.
//  Copyright © 2016年 赵清. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatContext];
}

- (void)creatContext {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[self imageWithColor:[UIColor orangeColor]]];
    imageView.frame = CGRectMake(0, 0, 100, 100);
    [self.view addSubview:imageView];
}

// 创建一个新画布，在新画布上通过一个颜色获取一个image
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 创建一个新画布并且压入系统会维护一个CGContextRef的栈
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0.0);
    // 此时获取的就是刚才压入栈的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    // 获得image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 释放上下文
    UIGraphicsEndImageContext();
    return image;
}

@end
