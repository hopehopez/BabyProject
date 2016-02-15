//
//  ZSQFactory.h
//  UITabBarControllerV1
//
//  Created by 张树青 on 15/12/23.
//  Copyright (c) 2015年 zsq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//NSObject类 不支持UI控件或者UI相关的类
//如果需要使用 导入<UIKit/UIKit.h>

@interface ZSQFactory : NSObject
/**
 *  类名创建控制器器
 */
+ (UIViewController *)createViewControllerWithName:(NSString *)ctrName;
/**
 *  创建window
 */
+ (UIWindow *)createWindow;
/**
 *   类名创建控制器 并设置颜色
 */
+ (UIViewController *)createViewControllerWithName:(NSString *)ctrName  andBackgroundColor:(UIColor *)bgColor;
@end
