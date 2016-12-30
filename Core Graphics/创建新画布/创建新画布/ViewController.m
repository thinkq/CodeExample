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
    [self creatImage];
    [self drawImageAndString];
}

- (void)creatImage {
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

- (void)drawImageAndString {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[self drawImageAtImageContext]];
    imageView.frame = CGRectMake(0, 200, 300, 200);
    [self.view addSubview:imageView];
}

#pragma mark 利用位图上下文添加水印效果
-(UIImage *)drawImageAtImageContext{
    //获得一个位图图形上下文
    CGSize size=CGSizeMake(300, 188);//画布大小
    UIGraphicsBeginImageContext(size);
    
    UIImage *image=[UIImage imageNamed:@"rulai.png"];
    [image drawInRect:CGRectMake(0, 0, 300, 188)];//注意绘图的位置是相对于画布顶点而言，不是屏幕
    
    
    //添加水印
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 200, 178);
    CGContextAddLineToPoint(context, 270, 178);
    
    [[UIColor redColor]setStroke];
    CGContextSetLineWidth(context, 2);
    
    CGContextDrawPath(context, kCGPathStroke);
    
    NSString *str=@"Kenshin Cui";
    [str drawInRect:CGRectMake(200, 158, 100, 30) withAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Marker Felt" size:15],NSForegroundColorAttributeName:[UIColor greenColor]}];
    
    //返回绘制的新图形
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    
    //最后一定不要忘记关闭对应的上下文
    UIGraphicsEndImageContext();
    
    //保存图片
    //    NSData *data= UIImagePNGRepresentation(newImage);
    //    [data writeToFile:@"/Users/kenshincui/Desktop/myPic.png" atomically:YES];
    
    return newImage;
}
@end
