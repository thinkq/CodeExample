//
//  ViewController.m
//  CGContext——贝塞尔曲线
//
//  Created by 赵清 on 2016/11/29.
//  Copyright © 2016年 赵清. All rights reserved.
//

#import "ViewController.h"
#import "PriView.h"

@interface ViewController ()
@property (nonatomic, strong) PriView *priView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.priView = [[PriView alloc] initWithFrame:self.view.bounds];
    self.priView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.priView];
}


@end
