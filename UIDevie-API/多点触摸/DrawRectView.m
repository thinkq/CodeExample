//
//  DrawRectView.m
//  多点触摸
//
//  Created by uuzuche on 15/8/14.
//  Copyright (c) 2015年 uuzuche. All rights reserved.
//

#import "DrawRectView.h"

@implementation DrawRectView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGRect bounds = self.bounds;

    // 根据bounds计算中心点
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;

    // 根据视图宽和高中的较小值计算圆形的半径
    float radius = (MIN(bounds.size.width, bounds.size.height) / 2.0);

    // UIBeizerPath用来绘制直线或曲线，从而组成各种形状
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    // 以中心为原点，radius的值为半径，定义一个0到M_PI * 2.0弧度的路径（整圆）
    [path addArcWithCenter:center radius:radius startAngle:0.0 endAngle:M_PI * 2.0 clockwise:YES];
    
    // 设置线条宽度
    path.lineWidth = radius;
    
    // 设置绘制颜色为红色
    [[UIColor redColor] setStroke];
    
    // 绘制路径
    [path stroke];
    
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


@end
