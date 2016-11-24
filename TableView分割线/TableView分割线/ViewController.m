//
//  ViewController.m
//  TableView分割线
//
//  Created by 赵清 on 2016/11/23.
//  Copyright © 2016年 赵清. All rights reserved.
//

/*
    让cell的分割线伸展到两端
    方法1：
    需要同时设置tableView和cell的layoutMargins和separatorInset为0！！！
 
    方法2：http://www.jianshu.com/p/afa312d046e3
    设置cell的preservesSuperviewLayoutMargins为NO，阻止cell从父视图（tableView）继承layoutMargins，从而阻止UIKit自动调整cell的内容视图以满足tableView的layoutMargins，从而可以独立设置自己的layoutMargins，相当于重写。
 
    方法1实际上也是cell满足了tableView的layoutMargins
    推荐使用方法二，代码比较集中便于管理，但是设置分割线的风格separatorStyle，颜色separatorColor和效果separatorEffect（关于效果有博客：http://blog.csdn.net/lengshengren/article/details/44243119）的设置只能设置tableView的相关属性，cell没有相关属性
 */



#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *objects;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.objects = @[@"张三",@"李四",@"王五",@"赵六"];
    self.tableView.backgroundColor = [UIColor whiteColor];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        // 设置分割线颜色
        _tableView.separatorColor = [UIColor orangeColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

// 在这里设置分割线延伸到两端
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.objects.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.objects[indexPath.row];
    return cell;
}



@end
