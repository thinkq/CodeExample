//
//  DrawRectView2.m
//  多点触摸
//
//  Created by uuzuche on 15/8/14.
//  Copyright (c) 2015年 uuzuche. All rights reserved.
//

#import "DrawRectView2.h"

@implementation DrawRectView2

- (void)drawRect:(CGRect)rect
{
    CGRect bounds = self.bounds;

    // 根据bounds计算中心点
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;

    // 使最外层圆形成为视图的外接圆
    float maxRadius = hypotf(bounds.size.width, bounds.size.height) / 2.0;

    // UIBeizerPath用来绘制直线或曲线，从而组成各种形状
    UIBezierPath *path = [[UIBezierPath alloc] init];

    // 连续画多个同心圆
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20)
    {
        // 每画一个同心圆之前，都要把path（画笔）放置到正确位置
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        [path addArcWithCenter:center
                        radius:currentRadius
                    startAngle:0.0
                      endAngle:M_PI * 2.0
                     clockwise:YES];
    }

    // 设置线条宽度
    path.lineWidth = 10.0;

    // 设置绘制颜色为红色
    [[UIColor redColor] setStroke];

    // 绘制路径
    [path stroke];

    UIImage *logoImage = [UIImage imageNamed:@"logo"];
    // 将图片绘制到视图上
    [logoImage drawInRect:rect];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
@end
