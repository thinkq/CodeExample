//
//  ViewController.m
//  多点触摸
//
//  Created by uuzuche on 15/8/6.
//  Copyright (c) 2015年 uuzuche. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGR:)];
    // 设置三根手指点击两次才触发方法
    tapGR.numberOfTapsRequired = 2;      // 点击两次
    tapGR.numberOfTouchesRequired = 3;   // 三根手指
    //创建一个点击的手势（类似于btn的点击）
    [self.view addGestureRecognizer:tapGR];

}
//点击事件
- (void)tapGR:(UITapGestureRecognizer *)tapGR
{
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"收到点击" message:@"嗯，对的，三根手指同时点击两次才有效的" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [view show];
}
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSString *message = [NSString stringWithFormat:@"%d个手指同时触摸了",[touches count]];
//    NSLog(@"%@",message);
//}
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
////    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"哪里不会点哪里" message:[NSString stringWithFormat:@"%d个手指同时触摸了",[touches count]] delegate:nil cancelButtonTitle:@"还是不会吧" otherButtonTitles:nil];
////    [view show];
//    NSString *message = [NSString stringWithFormat:@"=====%d个手指同时触摸了",[touches count]];
//    NSLog(@"%@",message);
//}



@end
