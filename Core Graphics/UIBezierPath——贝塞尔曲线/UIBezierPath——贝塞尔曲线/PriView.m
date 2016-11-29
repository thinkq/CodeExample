//
//  PriView.m
//  CGContext——贝塞尔曲线
//
//  Created by 赵清 on 2016/11/29.
//  Copyright © 2016年 赵清. All rights reserved.
//

#import "PriView.h"

@implementation PriView

- (void)drawRect:(CGRect)rect {
//    [self bezier];
    [self roundingCorner];
}

// 贝塞尔曲线
- (void)bezier {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(20, 100)];
    [path addQuadCurveToPoint:CGPointMake(300, 100) controlPoint:CGPointMake(160, 00)];
    [path moveToPoint:CGPointMake(20, 500)];
    [path addCurveToPoint:CGPointMake(300, 300) controlPoint1:CGPointMake(80, 300) controlPoint2:CGPointMake(240, 500)];
    // 设置填充颜色
    UIColor *fillColor = [UIColor greenColor];
    [fillColor set];
    [path fill];

    // 设置画笔颜色
    UIColor *strokeColor = [UIColor blueColor];
    [strokeColor set];
    [path stroke];
}

// 任意圆角
- (void)roundingCorner {
    // 其中第一个参数一样是传了个矩形，第二个参数是指定在哪个方向画圆角，第三个参数是一个CGSize类型，用来指定水平和垂直方向的半径的大小。看下效果图：
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(20, 20, self.frame.size.width - 40, self.frame.size.height - 40) byRoundingCorners:UIRectCornerTopRight cornerRadii:CGSizeMake(20, 20)];
    
    // 设置填充颜色
    UIColor *fillColor = [UIColor greenColor];
    [fillColor set];
    [path fill];
    
    // 设置画笔颜色
    UIColor *strokeColor = [UIColor blueColor];
    [strokeColor set];
    
    // 根据我们设置的各个点连线
    [path stroke];
}

@end
