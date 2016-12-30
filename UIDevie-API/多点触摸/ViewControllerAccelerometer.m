//
//  ViewControllerAccelerometer.m
//  多点触摸
//
//  Created by uuzuche on 15/8/9.
//  Copyright (c) 2015年 uuzuche. All rights reserved.
//

#import "ViewControllerAccelerometer.h"

@interface ViewControllerAccelerometer ()
{
    UIImageView *imageView; // 球体图像
    UIAccelerationValue speedX; // x轴方向的运动速度
    UIAccelerationValue speedY; // y轴方向的运动速度
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;

    CMMotionManager *motionManager;
    NSOperationQueue *quene;
}

@end

@implementation ViewControllerAccelerometer

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 17, 17)];
    imageView.image = [UIImage imageNamed:@"metal"];
    imageView.center = self.view.center;
    [self.view addSubview:imageView];

    label1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 60, 100, 40)];
    label1.text = @"label1";
    [self.view addSubview:label1];

    label2 = [[UILabel alloc] initWithFrame:CGRectMake(30, 120, 100, 40)];
    label2.text = @"label2";
    [self.view addSubview:label2];

    label3 = [[UILabel alloc] initWithFrame:CGRectMake(30, 180, 100, 40)];
    label3.text = @"label3";
    [self.view addSubview:label3];
}
- (void)viewWillAppear:(BOOL)animated
{
    motionManager = [[CMMotionManager alloc] init];
    [motionManager startAccelerometerUpdates];
    // 加速度器的检测
    if ([motionManager isAccelerometerAvailable])
    {
        // 查看加速度器是否可用
        NSLog(@"Accelerometer is available.");
    }
    else
    {
        NSLog(@"Accelerometer is not available.");
    }
    if ([motionManager isAccelerometerActive])
    {
        // 查看加速度器的状态：是否Active（启动）
        NSLog(@"Accelerometer is active.");
    }
    else
    {
        NSLog(@"Accelerometer is not active.");
    }

    //    [motionManager startDeviceMotionUpdates];
    //    [motionManager startAccelerometerUpdates];
    //    [motionManager startGyroUpdates];
    //    [motionManager startMagnetometerUpdates];

    [motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                        withHandler:^(CMAccelerometerData *latestAcc, NSError *error) {
                                            label1.text =
                                                [NSString stringWithFormat:@"%f", latestAcc.acceleration.x];
                                            label2.text =
                                                [NSString stringWithFormat:@"%f", latestAcc.acceleration.y];
                                            label3.text =
                                                [NSString stringWithFormat:@"%f", latestAcc.acceleration.z];
                                            // NSLog(@"%@",label1.text);
                                            if (latestAcc.acceleration.x > 1.0 || latestAcc.acceleration.z > 0.01)
                                            {
                                                NSLog(@"niubi");
                                            }
                                            // 设置球的运动
                                            speedX += latestAcc.acceleration.x; // 在x轴方向速度上附加x轴方向加速符
                                            CGFloat posX = imageView.center.x + speedX; // 根据速度调整球体的位置坐标
                                            speedY += latestAcc.acceleration.y; // 在y轴方向速度上附加y轴方向加速符
                                            CGFloat posY = imageView.center.y - speedY; // 根据速度调整球体的位置坐标

                                            if (posX < 0.0)
                                            {
                                                posX = 0.0;
                                                speedX *= -0.4; // 碰到边时以0.4倍的速度反弹
                                            }
                                            else if (posX > self.view.bounds.size.width)
                                            {
                                                posX = self.view.bounds.size.width;
                                                speedX *= -0.4; // 碰到边时以0.4倍的速度反弹
                                            }

                                            if (posY < 69.0)
                                            {
                                                posY = 69.0;
                                                speedY *= -0.4;
                                            }
                                            else if (posY > self.view.bounds.size.height)
                                            {
                                                posY = self.view.bounds.size.height;
                                                speedY *= -0.4;
                                            }

                                            // 防止粘滞
                                            if (posX == 0.0 && speedX == 0.0)
                                            {
                                                return;
                                            }
                                            if (posY == 0.0 && speedY == 0.0)
                                            {
                                                return;
                                            }
                                            [UIView beginAnimations:nil context:nil];
                                            [UIView setAnimationDuration:0.1];
                                            imageView.center = CGPointMake(posX, posY);
                                            [UIView commitAnimations];


                                        }];


    // 陀螺仪的检测,同理isGyroAvailable方法和isGyroActive方法用来检测陀螺仪。
    if ([motionManager isGyroAvailable])
    {
        NSLog(@"Gryro is available.");
    }
    else
    {
        NSLog(@"Gyro is not available.");
    }
    if ([motionManager isGyroActive])
    {
        NSLog(@"Gryo is active.");
    }
    else
    {
        NSLog(@"Gryo is not active.");
    }
    // 陀螺仪的检测
    if ([motionManager isGyroAvailable])
    {
        NSLog(@"Gryro is available.");

        if ([motionManager isGyroActive] == NO)
        {
            [motionManager setGyroUpdateInterval:1.0f / 1.0f];
            NSOperationQueue *queue = [[NSOperationQueue alloc] init];
            [motionManager startGyroUpdatesToQueue:queue
                                       withHandler:^(CMGyroData *gyroData, NSError *error) {
                                           NSLog(@"Gyro Rotation x = %.04f", gyroData.rotationRate.x);
                                           NSLog(@"Gyro Rotation y = %.04f", gyroData.rotationRate.y);
                                           NSLog(@"Gyro Rotation z = %.04f", gyroData.rotationRate.z);
                                       }];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [motionManager stopAccelerometerUpdates];
    [motionManager stopDeviceMotionUpdates];
    [motionManager stopGyroUpdates];
    [motionManager stopMagnetometerUpdates];
}


@end
