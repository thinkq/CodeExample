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
    
    CGContextSaveGState(context);
    // 做修改，对图形状态所做的修改会影响随后的描画操作，但不影响存储在堆栈中的拷贝。在修改完成后，您可以通过CGContextRestoreGState函数把堆栈顶部的状态弹出，返回到之前的图形状态。这种推入和弹出的方式是回到之前图形状态的快速方法，避免逐个撤消所有的状态修改；这也是将某些状态（比如裁剪路径）恢复到原有设置的唯一方式。
    CGContextRestoreGState(context);
    // 方法一
    {
    CGContextMoveToPoint(context, 20, 100);//移动到起始位置
    /*绘制二次贝塞尔曲线
     c:图形上下文
     cpx:控制点x坐标
     cpy:控制点y坐标
     x:结束点x坐标
     y:结束点y坐标
     */
    CGContextAddQuadCurveToPoint(context, 160, 0, 300, 100);

    CGContextMoveToPoint(context, 20, 500);
    /*绘制三次贝塞尔曲线
     c:图形上下文
     cp1x:第一个控制点x坐标
     cp1y:第一个控制点y坐标
     cp2x:第二个控制点x坐标
     cp2y:第二个控制点y坐标
     x:结束点x坐标
     y:结束点y坐标
     */
    CGContextAddCurveToPoint(context, 80, 300, 240, 500, 300, 300);

    //设置图形上下文属性
    [[UIColor yellowColor]setFill];
    [[UIColor redColor]setStroke];
    
    
    //绘制路径
    CGContextDrawPath(context, kCGPathFillStroke);
    }
}

@end
