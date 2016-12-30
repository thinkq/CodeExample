//
//  CopyViewController.m
//  多点触摸
//
//  Created by uuzuche on 15/8/10.
//  Copyright (c) 2015年 uuzuche. All rights reserved.
//

/*
 复制粘贴的使用
 */

#import "CopyViewController.h"
#import "CopyLabel.h"
#import "CopyImageView.h"
#import "Masonry.h"


@interface CopyViewController (){
    CopyLabel *label;
    UITextField *textField;
    CopyImageView *imageView1;
    CopyImageView *imageView2;
}

@end

@implementation CopyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self copyLabel];
    [self copyImage];
}
- (void)copyLabel{
    label = [[CopyLabel alloc] initWithFrame:CGRectMake(0, 70, self.view.bounds.size.width, 100)];
    label.userInteractionEnabled = YES;
    label.text = @"双击选择复制";
    label.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:label];
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 200, 200, 50)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    CGPoint centerY = CGPointMake(self.view.center.x, textField.center.y);
    textField.center = centerY;
    [self.view addSubview:textField];
}

- (void)copyImage{
    imageView1 = [[CopyImageView alloc] init];
    imageView2 = [[CopyImageView alloc] init];
    [self.view addSubview:imageView1];
    [self.view addSubview:imageView2];
    int padding = 10;
    [imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@120);
        make.left.equalTo(self.view.mas_left).with.offset(padding);
        make.right.equalTo(imageView2.mas_left).with.offset(-padding);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-padding);
    }];
    [imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@120);
        make.width.equalTo(imageView1.mas_width);
        make.left.equalTo(imageView1.mas_right).with.offset(padding);
        make.right.equalTo(self.view.mas_right).with.offset(-padding);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-padding);
    }];
    imageView1.backgroundColor = [UIColor lightGrayColor];
    imageView1.image = [UIImage imageNamed:@"copyimage"];
    imageView2.backgroundColor = [UIColor grayColor];

}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
