//
//  ViewController.m
//  04-指南针
//
//  Created by apple on 14/11/1.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>
/**
 *  定位管理者
 */
@property (nonatomic ,strong) CLLocationManager *mgr;
// 指南针图片
@property (nonatomic, strong) UIImageView *compasspointer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.添加指南针图片
    
    UIImageView *iv = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"bg_compasspointer"]];
    iv.center = CGPointMake(self.view.center.x, self.view.center.y);
    [self.view addSubview:iv];
    self.compasspointer = iv;
    
    // 2.成为CoreLocation管理者的代理监听获取到的位置
    self.mgr.delegate = self;
    
    // 3.开始获取用户位置
    // 注意:获取用户的方向信息是不需要用户授权的
    [self.mgr startUpdatingHeading];
    
    
}
#pragma mark - CLLocationManagerDelegate
// 当获取到用户方向时就会调用
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
//    NSLog(@"%s", __func__);
    /*
     magneticHeading 设备与磁北的相对角度
     trueHeading 设置与真北的相对角度, 必须和定位一起使用, iOS需要设置的位置来计算真北
     真北始终指向地理北极点
     */
//    NSLog(@"%f", newHeading.magneticHeading);
    
    // 1.将获取到的角度转为弧度 = (角度 * π) / 180;
    CGFloat angle = newHeading.magneticHeading * M_PI / 180;
    // 2.旋转图片
    /*
     顺时针 正
     逆时针 负数
     */
//    self.compasspointer.transform = CGAffineTransformIdentity;
    self.compasspointer.transform = CGAffineTransformMakeRotation(-angle);
    
    
    
    
}

#pragma mark - 懒加载
- (CLLocationManager *)mgr
{
    if (!_mgr) {
        _mgr = [[CLLocationManager alloc] init];
    }
    return _mgr;
}

@end
