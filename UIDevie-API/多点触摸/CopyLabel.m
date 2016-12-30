//
//  CopyLabel.m
//  多点触摸
//
//  Created by uuzuche on 15/8/10.
//  Copyright (c) 2015年 uuzuche. All rights reserved.
//
/*
 有时候我们可能需要复制UILabel上的文本，或者UIImageView的图片，而UILabel和UIImageView默认是不响应Touch事件的，也无法复制，那么我们就需要自己实现一个可复制的UILabel
 */
#import "CopyLabel.h"

@implementation CopyLabel
// 绑定事件
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self attachTapHandler];
    }
    return self;
}
//同上
-(void)awakeFromNib{
    [super awakeFromNib];
    [self attachTapHandler];
}

// 为了能接收到事件（能成为第一响应者
- (BOOL)canBecomeFirstResponder{
    return YES;
}

// "反馈"关心的功能
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return (action == @selector(copy:)); 
}

// 针对于copy的实现
- (void)copy:(id)sender{
    [UIPasteboard generalPasteboard].string = self.text;
}

// UILabel默认是不接收事件的，我们需要自己添加touch事件
-(void)attachTapHandler{
    self.userInteractionEnabled = YES;  //用户交互的总开关
    UITapGestureRecognizer *touch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    touch.numberOfTapsRequired = 2;
    [self addGestureRecognizer:touch];
}

/*
 我们已经可以接收到事件了！由于我在上方将tap数设为2，所以需要双击才能捕获，接下来，我们需要处理这个tap，以便让菜单栏弹出来
 */
-(void)handleTap:(UIGestureRecognizer*) recognizer{
    [self becomeFirstResponder];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setTargetRect:self.frame inView:self.superview];
    [menu setMenuVisible:YES animated:YES];
}

@end
