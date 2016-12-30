//
//  TextFieldViewController.m
//  多点触摸
//
//  Created by uuzuche on 15/8/18.
//  Copyright (c) 2015年 uuzuche. All rights reserved.
//

#import "TextFieldViewController.h"
#import "DrawRectView2.h"
@interface TextFieldViewController ()

@end

@implementation TextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView{
    CGRect frame = [UIScreen mainScreen].bounds;
    DrawRectView2 *view = [[DrawRectView2 alloc] initWithFrame:frame];
    CGRect textFieldRect = CGRectMake(40, 70, 240, 30);
    UITextField *textField = [[UITextField alloc] initWithFrame:textFieldRect];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [view addSubview:textField];
    self.view = view;

}

@end
