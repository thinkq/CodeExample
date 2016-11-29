//
//  PriView.m
//  CGContext——贝塞尔曲线
//
//  Created by 赵清 on 2016/11/29.
//  Copyright © 2016年 赵清. All rights reserved.
//

#import "PriView.h"
static inline double radians (double degrees) {return degrees * M_PI/180;}

@implementation PriView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIImage *myImage = [UIImage imageNamed:@"rooster"];
    CGRect myRect = CGRectMake(0, 0, myImage.size.width, myImage.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, 0, -(myRect.size.height-(myRect.size.height-2*myRect.origin.y-myRect.size.height)));//向上平移
    
    // 一下两个方法可以实现相同效果
    /*
     方法一
     {
     CGContextTranslateCTM (context, myRect.size.width/4, 0);
     CGContextScaleCTM (context, .25,  .5);
     CGContextRotateCTM (context, radians ( 22.));
     }
     */
    
    
    // 方法二
    {
        CGAffineTransform transform = CGAffineTransformIdentity;
        transform = CGAffineTransformMakeTranslation(myRect.size.width / 4, 0);
        transform = CGAffineTransformScale(transform, .25, .5);
        transform = CGAffineTransformRotate(transform, radians(22.));
        // 联合变换将两个矩阵相乘来联接现价变换操作。我们可以联接多个矩阵来得到一个包含所有矩阵累积效果矩阵。通过调用CGContextConcatCTM来联接CTM和仿射矩阵。
        CGContextConcatCTM(context, transform);
    }
    
    CGContextDrawImage(context, myRect, myImage.CGImage);
}

@end
