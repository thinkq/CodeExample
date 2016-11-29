//
//  ViewController.m
//  CGAffineTransformDemo
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
    [self CGAffineTransform];
}

// 关于CGAffineTransform.h的api
- (void)CGAffineTransform {
    UIView *rulaiView = [[UIView alloc] initWithFrame:CGRectMake(50, 0, 100, 100)];
    rulaiView.layer.contents = (__bridge id _Nullable)([[UIImage imageNamed:@"rulai"] CGImage]);
    [self.view addSubview:rulaiView];
    
    // 不变
    rulaiView.transform = CGAffineTransformIdentity;
    /*
     sx The factor by which to scale the x-axis of the coordinate system.
     缩放坐标系x轴的因子。
     sy The factor by which to scale the y-axis of the coordinate system.
     缩放坐标系y轴的因子。
     
     */
    rulaiView.transform = CGAffineTransformMakeScale(2, 1);
    
    /*
     tx The value by which to move the x-axis of the coordinate system.
     沿着x轴移动的值
     ty The value by which to move the y-axis of the coordinate system.
     沿着y轴移动的值
     */
    rulaiView.transform = CGAffineTransformMakeTranslation(50, 100);
    
    /*
     沿着z轴选装，值为正顺时针旋转，值为负逆时针旋转
     */
    rulaiView.transform = CGAffineTransformMakeRotation(45 * M_PI/180);
    
    // 以上的transform效果不能叠加，要叠加使用一下函数
    rulaiView.transform = CGAffineTransformIdentity;
    rulaiView.transform = CGAffineTransformScale(rulaiView.transform, 2, 1);
    rulaiView.transform = CGAffineTransformTranslate(rulaiView.transform, 50, 100);
    rulaiView.transform = CGAffineTransformRotate(rulaiView.transform, 45 * M_PI/180);
    
    // 用到矩阵的知识——懵逼
    rulaiView.transform = CGAffineTransformIdentity;
    //    rulaiView.transform = CGAffineTransformMake(<#CGFloat a#>, <#CGFloat b#>, <#CGFloat c#>, <#CGFloat d#>, <#CGFloat tx#>, <#CGFloat ty#>)
    
    // 对已有的变换矩阵 t 进行反转,倒置矩阵，将值与倒置矩阵相乘得到原先的值。通常不需要倒置操作，因为我们可以通过保存和恢复图形状态来倒置CTM的效果
    rulaiView.transform = CGAffineTransformIdentity;
    rulaiView.transform = CGAffineTransformInvert(CGAffineTransformMakeRotation(45 * M_PI/180));
    
    // 联合变换将两个矩阵相乘来联接现价变换操作
    rulaiView.transform = CGAffineTransformIdentity;
    rulaiView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(2, 1),CGAffineTransformMakeTranslation(50, 100));
    
    // 调用CGPointApplyAffineTransform在CGPoint结构上执行变换操作。
    // 调用CGSizeApplyAffineTransform在CGSize结构上执行变换操作。
    // 调用CGRectApplyAffineTransform在CGRect结构上执行变换操作
    
}

@end
