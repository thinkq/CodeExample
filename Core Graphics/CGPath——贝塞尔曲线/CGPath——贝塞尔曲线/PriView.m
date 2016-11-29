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
    [self CGContext];
}

- (void)CGContext {
    CGContextRef context = UIGraphicsGetCurrentContext();

    // 路径也可用CGPath来表示
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 20, 100);
    CGPathAddQuadCurveToPoint(path, nil, 160, 0, 300, 100);
    CGPathMoveToPoint(path, nil, 20, 500);
    CGPathAddCurveToPoint(path, nil, 80, 300, 240, 500, 300, 300);
    // 设置图形上下文状态属性
    CGContextSetRGBStrokeColor(context, 1.0, 0, 0, 1);//设置笔触颜色
    CGContextSetRGBFillColor(context, 0, 1.0, 0, 1);//设置填充色
    // 添加路径到图形上下文
    CGContextAddPath(context, path);
    //最后一个参数是填充类型
    /*CGPathDrawingMode是填充方式,枚举类型
     kCGPathFill:只有填充（非零缠绕数填充），不绘制边框
     kCGPathEOFill:奇偶规则填充（多条路径交叉时，奇数交叉填充，偶交叉不填充）
     kCGPathStroke:只有边框
     kCGPathFillStroke：既有边框又有填充
     kCGPathEOFillStroke：奇偶填充并绘制边框
     */
    CGContextDrawPath(context, kCGPathFillStroke);
    //6.释放对象
    CGPathRelease(path);
}

@end
