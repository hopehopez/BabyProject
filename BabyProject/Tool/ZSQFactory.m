//
//  ZSQFactory.m
//  UITabBarControllerV1
//
//  Created by 张树青 on 15/12/23.
//  Copyright (c) 2015年 zsq. All rights reserved.
//

#import "ZSQFactory.h"
@implementation ZSQFactory

#pragma mark - 根据控制器的名字创建出对应的控制器

+ (UIViewController *)createViewControllerWithName:(NSString *)ctrName{
    //1.先获取对应的类型
    Class cls = NSClassFromString(ctrName);
    
    return [[cls alloc] init ];
//    //2.通过类型创建对象
//    UIViewController *ctr = [[cls alloc] init ];
//    //3.返回控制器
//    return ctr;
}

#pragma mark -- 创建window对象 白色背景色
+ (UIWindow *)createWindow{
    
    //单例写法 保障当前工程调用该方法创建window时 永远只有一个window
    static UIWindow *window = nil;
    if (window == nil) {
        window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        window.backgroundColor = [UIColor whiteColor];
    }
    return window;
}

#pragma mark -- 根据控制器名创建控制器并设置背景颜色

+ (UIViewController *)createViewControllerWithName:(NSString *)ctrName  andBackgroundColor:(UIColor *)bgColor{
   // UIViewController *ctr = [ZSQFactory createViewControllerWithName:ctrName];
    UIViewController *ctr = [self createViewControllerWithName:ctrName];
    //self 在对象方法中 表示的是调用方法的对象
    //self 在类方法中 表示的是当前类
    ctr.view.backgroundColor = bgColor;
    return ctr;
}
@end
