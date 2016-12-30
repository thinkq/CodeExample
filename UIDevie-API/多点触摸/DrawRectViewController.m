//
//  DrawRectViewController.m
//  多点触摸
//
//  Created by uuzuche on 15/8/14.
//  Copyright (c) 2015年 uuzuche. All rights reserved.
//

#import "DrawRectViewController.h"
#import "DrawRectView.h"
#import "DrawRectView1.h"
#import "DrawRectView2.h"
#import "DrawRectView3.h"
#import "DrawRectView4.h"
@interface DrawRectViewController ()<UIActionSheetDelegate>

@end

@implementation DrawRectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(barButtonClick)];
    self.navigationItem.rightBarButtonItem = item;
}
- (void)barButtonClick{
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"显示哪个视图" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"圆" otherButtonTitles:@"同心圆",@"绘制图像",@"点击变色",@"合并多个UIImage成一个", nil];
    [as showInView:self.view];
}


//actionSheet的点击事件
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        for (UIView *view in [self.view subviews])
        {
            [view removeFromSuperview];
        }
        DrawRectView *view = [[DrawRectView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:view];
    }
    else if (buttonIndex == 1)
    {
        for (UIView *view in [self.view subviews])
        {
            [view removeFromSuperview];
        }
        DrawRectView1 *view = [[DrawRectView1 alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:view];
    }
    else if (buttonIndex == 2)
    {
        for (UIView *view in [self.view subviews])
        {
            [view removeFromSuperview];
        }
        DrawRectView2 *view = [[DrawRectView2 alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:view];
    }
    else if (buttonIndex == 3)
    {
        for (UIView *view in [self.view subviews])
        {
            [view removeFromSuperview];
        }
        DrawRectView3 *view = [[DrawRectView3 alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:view];
    }
    else if (buttonIndex == 4)
    {
        for (UIView *view in [self.view subviews])
        {
            [view removeFromSuperview];
        }
        DrawRectView4 *view = [[DrawRectView4 alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:view];
    }
}
@end
