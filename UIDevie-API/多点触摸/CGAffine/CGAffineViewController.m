//
//  CGAffineViewController.m
//  多点触摸
//
//  Created by uuzuche on 15/8/25.
//  Copyright (c) 2015年 uuzuche. All rights reserved.
//

#import "CGAffineViewController.h"
#import "Masonry.h"
@interface CGAffineViewController ()
{
    UIImageView *_imageView;
}

@end

@implementation CGAffineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageView = [[UIImageView alloc] init];
    _imageView.image = [UIImage imageNamed:@"copyimage"];
    [self.view addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(@100);
        make.height.equalTo(@100);
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _imageView.transform =  CGAffineTransformRotate(_imageView.transform, (45 * (M_PI / 180)));

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
