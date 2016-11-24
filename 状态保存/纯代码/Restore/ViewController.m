//
//  ViewController.m
//  Restore
//
//  Created by 赵清 on 2016/11/12.
//  Copyright © 2016年 赵清. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()<UIViewControllerRestoration>
@property (nonatomic, copy) NSString *string;
@property (nonatomic) BOOL restoringState;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.restorationIdentifier = @"ViewController";
    self.restorationClass = [self class];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button setTitle:@"next" forState:UIControlStateNormal];
    self.button.frame = CGRectMake(0, 0, 100, 70);
    self.button.center = self.view.center;
    self.button.layer.borderWidth = 1.0f;
    self.button.layer.borderColor = [UIColor orangeColor].CGColor;
    [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(pushSecondVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 70)];
    self.label.frame = CGRectMake(0, 0, 100, 70);
    self.label.center = CGPointMake(self.view.center.x, self.view.center.y + 100);
    self.label.layer.borderWidth = 1.0f;
    self.label.layer.borderColor = [UIColor orangeColor].CGColor;
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.text = @"0";
    [self.view addSubview:self.label];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.restoringState) {
        NSLog(@"============%@",self.string);
        self.restoringState = NO;
        self.label.text = self.string;
    }
}

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.string forKey:@"bgColor"];
    [coder encodeObject:self.view.backgroundColor forKey:@"backgroundcolor"];
    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    self.restoringState = YES;
    self.string = [coder decodeObjectForKey:@"bgColor"];
    self.view.backgroundColor = [coder decodeObjectForKey:@"backgroundcolor"];
    [super decodeRestorableStateWithCoder:coder];
}

+ (UIViewController *)viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder
{
    ViewController *vc = [[ViewController alloc] init];
    vc.restorationIdentifier = @"ViewController";
    vc.restorationClass = [ViewController class];
    return vc;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    static int num = 0;
    self.view.backgroundColor = [UIColor redColor];
    self.string = [NSString stringWithFormat:@"%d",++num];
    self.label.text = self.string;
}

- (void)pushSecondVC {
    SecondViewController *vc = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
