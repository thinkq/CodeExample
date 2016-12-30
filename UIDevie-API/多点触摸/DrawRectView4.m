//
//  DrawRectView4.m
//  多点触摸
//
//  Created by uuzuche on 15/8/14.
//  Copyright (c) 2015年 uuzuche. All rights reserved.
//

#import "DrawRectView4.h"
#import "Masonry.h"
@interface DrawRectView4 ()
@property (nonatomic,strong)UIImageView *imageView;
@end
@implementation DrawRectView4
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}
- (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 {
    // image2放到image1下边，合成后的图片用较宽的那个，比较宽度得出较宽的数值
    float maxWidth = MAX(image1.size.width, image2.size.height);
    // 计算合并后图片的尺寸
    CGSize size = CGSizeMake(maxWidth, image1.size.height + image2.size.height);
    UIGraphicsBeginImageContext(size);
    
    // Draw image1
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    
    // Draw image2
    [image2 drawInRect:CGRectMake(0, image1.size.height, image2.size.width, image2.size.height)];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    UIImage *image1 = [UIImage imageNamed:@"computer"];
    UIImage *image2 = [UIImage imageNamed:@"run"];
    UIImage *image = [self addImage:image1 toImage:image2];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self addSubview:imageView];
    
    // image2放到image1下边，合成后的图片用较宽的那个，比较宽度得出较宽的数值
    float maxWidth = MAX(image1.size.width, image2.size.width);
    imageView.backgroundColor = [UIColor blueColor];

    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(image1.size.height + image2.size.height));
        make.width.equalTo(@(maxWidth));
        make.center.mas_equalTo(self);
    }];

}

@end
