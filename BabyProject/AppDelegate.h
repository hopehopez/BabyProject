//
//  AppDelegate.h
//  BabyProject
//
//  Created by 张树青 on 16/2/15.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    //主视图控制器
    //MainViewController *_mainController;
    UINavigationController *_mainNav;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) MainViewController *mainController;

@end

