//
//  ViewController.m
//  LayoutMargins
//
//  Created by 赵清 on 2016/11/24.
//  Copyright © 2016年 赵清. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self example1];
    [self example2];
    [self example3];
}

- (void)example1 {
    UIView *blueView = [[UIView alloc] init];
    blueView.backgroundColor = [UIColor blueColor];
    blueView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:blueView];
    NSMutableArray *constraints = [NSMutableArray array];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraints:constraints];
    
    UIView *yellowView = [[UIView alloc] init];
    yellowView.backgroundColor = [UIColor yellowColor];
    yellowView.translatesAutoresizingMaskIntoConstraints = NO;
    [blueView addSubview:yellowView];
    [constraints removeAllObjects];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:yellowView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:yellowView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeHeight multiplier:0.5 constant:0.0]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:yellowView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:yellowView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [blueView addConstraints:constraints];
    
    // yellowView的约束通过设置宽等于blueView的宽，高等于blueView的一半，这么设置即使设置了blueView的layoutMargins也没有效果yellowView的左右边缘还是和blueView的重合
    blueView.layoutMargins = UIEdgeInsetsMake(50, 50, 50, 50);
}

- (void)example2 {
        UIView *blueView = [[UIView alloc] init];
        blueView.backgroundColor = [UIColor blueColor];
        blueView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:blueView];
        NSMutableArray *constraints = [NSMutableArray array];
        [constraints addObject:[NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
        [constraints addObject:[NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
        [constraints addObject:[NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
        [constraints addObject:[NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
        [self.view addConstraints:constraints];
    
        UIView *yellowView = [[UIView alloc] init];
        yellowView.backgroundColor = [UIColor yellowColor];
        yellowView.translatesAutoresizingMaskIntoConstraints = NO;
        [blueView addSubview:yellowView];
        [constraints removeAllObjects];
        [constraints addObject:[NSLayoutConstraint constraintWithItem:yellowView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
        [constraints addObject:[NSLayoutConstraint constraintWithItem:yellowView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeHeight multiplier:0.5 constant:0.0]];
        [constraints addObject:[NSLayoutConstraint constraintWithItem:yellowView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
        [constraints addObject:[NSLayoutConstraint constraintWithItem:yellowView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
        [blueView addConstraints:constraints];
    
        UIView *blackView = [[UIView alloc] init];
        blackView.backgroundColor = [UIColor blackColor];
        blackView.translatesAutoresizingMaskIntoConstraints = NO;
        [yellowView addSubview:blackView];
        [constraints removeAllObjects];
        [constraints addObject:[NSLayoutConstraint constraintWithItem:blackView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:yellowView attribute:NSLayoutAttributeTrailingMargin multiplier:1.0 constant:0.0]];
        [constraints addObject:[NSLayoutConstraint constraintWithItem:blackView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:yellowView attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:0.0]];
        [constraints addObject:[NSLayoutConstraint constraintWithItem:blackView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:yellowView attribute:NSLayoutAttributeTopMargin multiplier:1.0 constant:0.0]];
        [constraints addObject:[NSLayoutConstraint constraintWithItem:blackView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:yellowView attribute:NSLayoutAttributeBottomMargin multiplier:1.0 constant:0.0]];
        [yellowView addConstraints:constraints];
    
        // 设置blueView的layoutMargins都为50，yellowView高为blueView的一半且中心点重合，UIKit约束计算后得出yellowView此时上下边缘到blueView的上下边缘距离满足50 points距离的结论。但是左右边缘不满足所以当yellowView的preservesSuperviewLayoutMargins为YES时，UIKit自动调整blackView的左右边距以满足blueView的margins。当yellowView.preservesSuperviewLayoutMargins = NO;的时候blackView完全遮盖yellowView
        blueView.layoutMargins = UIEdgeInsetsMake(50, 50, 50, 50);
        yellowView.layoutMargins = UIEdgeInsetsZero;
        yellowView.preservesSuperviewLayoutMargins = YES;
}

- (void)example3 {
    UIView *blueView = [[UIView alloc] init];
    blueView.backgroundColor = [UIColor blueColor];
    blueView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:blueView];
    NSMutableArray *constraints = [NSMutableArray array];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraints:constraints];
    
    UIView *yellowView = [[UIView alloc] init];
    yellowView.backgroundColor = [UIColor yellowColor];
    yellowView.translatesAutoresizingMaskIntoConstraints = NO;
    [blueView addSubview:yellowView];
    [constraints removeAllObjects];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:yellowView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:yellowView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeHeight multiplier:0.5 constant:0.0]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:yellowView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:yellowView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [blueView addConstraints:constraints];
    
    UIView *blackView = [[UIView alloc] init];
    blackView.backgroundColor = [UIColor blackColor];
    blackView.translatesAutoresizingMaskIntoConstraints = NO;
    [yellowView addSubview:blackView];
    [constraints removeAllObjects];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:blackView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:yellowView attribute:NSLayoutAttributeTrailingMargin multiplier:1.0 constant:0.0]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:blackView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:yellowView attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:0.0]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:blackView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:yellowView attribute:NSLayoutAttributeTopMargin multiplier:1.0 constant:0.0]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:blackView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:yellowView attribute:NSLayoutAttributeBottomMargin multiplier:1.0 constant:0.0]];
    [yellowView addConstraints:constraints];
    
    // 设置blueView的layoutMargins都为50，yellowView高为blueView的一半且中心点重合，UIKit约束计算后得出yellowView此时上下边缘到blueView的上下边缘距离满足50 points距离的结论。但是左右边缘不满足所以当yellowView的preservesSuperviewLayoutMargins为YES时，UIKit自动调整blackView的左右边距以满足blueView的margins。当yellowView.preservesSuperviewLayoutMargins = NO;的时候blackView完全遮盖yellowView
    blueView.layoutMargins = UIEdgeInsetsMake(50, 50, 50, 50);
    yellowView.layoutMargins = UIEdgeInsetsZero;
    yellowView.preservesSuperviewLayoutMargins = YES;
}

@end
