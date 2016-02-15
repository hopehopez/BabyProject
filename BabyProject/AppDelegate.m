//
//  AppDelegate.m
//  SmallBabyProject
//
//  Created by 张树青 on 16/2/3.
//  Copyright © 2016年 张树青. All rights reserved.
//

#import "AppDelegate.h"
#import "GuidanceViewController.h"
#import "BabyViewController.h"
#import "FindViewController.h"
#import "CameraViewController.h"
#import "FeedsViewController.h"
#import "MessagesViewController.h"
#import "MainViewController.h"
@interface AppDelegate (){
    //宝贝视图控制器
    BabyViewController *_babyController;
    UINavigationController *_babyNav;
    
    //发现视图控制器
    FindViewController *_findController;
    UINavigationController *_findNav;
    
    //相机视图控制器
    CameraViewController *_cameraController;
    
    //动态视图控制器
    FeedsViewController *_feedsController;
    UINavigationController *_feedsNav;
    
    //消息视图控制器
    MessagesViewController *_messagesController;
    UINavigationController *_messagesNav;
    
    //主视图控制器
    MainViewController *_mainController;
    UINavigationController *_mainNav;
}

@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    //设置状态栏为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    _window.rootViewController = [self createRootController];
    
    _window.backgroundColor = [UIColor whiteColor];
    
    [_window makeKeyAndVisible];
    
    return YES;
    
}


#pragma mark -- 创建引导页
- (GuidanceViewController *)createGuidanceView{
    
    
    NSArray *imageArray = @[@"1.png",@"2.png",@"3.png",@"6.png"];
    
    GuidanceViewController *duidanceView = [[GuidanceViewController alloc]initWithImagesArr:imageArray andBlock:^{
        
        self.window.rootViewController = [self createRootController];
        
        NSLog(@"进入应用跳转成功！");
    }];
    
    return duidanceView;
    
}
#pragma mark - 创建视图控制器
- (UIViewController * )createRootController{
    //创建宝贝视图控制器
    _babyController = [[BabyViewController alloc] init];
    _babyNav = [[UINavigationController alloc] initWithRootViewController:_babyController];
    UITabBarItem *babyItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"tabbar_1b"] selectedImage:[UIImage imageNamed:@"tabbar_1a"]];
    _babyController.tabBarItem = babyItem;
    
    //创建发现视图控制器
    _findController = [[FindViewController alloc] init];
    _findNav = [[UINavigationController alloc] initWithRootViewController:_findController];
    UITabBarItem *findItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"tabbar_2b"] selectedImage:[UIImage imageNamed:@"tabbar_2a"]];
    _findNav.tabBarItem = findItem;
    
    //创建相机视图控制器
    _cameraController = [[CameraViewController alloc] init];
    UITabBarItem *cameraItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"tabbar_camera"] selectedImage:[UIImage imageNamed:@"tabbar_camera"] ];
    _cameraController.tabBarItem = cameraItem;
    
    //创建动态视图控制器
    _feedsController = [[FeedsViewController alloc] init];
    _feedsNav = [[UINavigationController alloc] initWithRootViewController:_feedsController];
    UITabBarItem *feedsItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"tabbar_3b"] selectedImage:[UIImage imageNamed:@"tabbar_3a"]];
    _feedsNav.tabBarItem = feedsItem;
    
    //创建消息视图控制器
    _messagesController = [[MessagesViewController alloc] init];
    _messagesNav = [[UINavigationController alloc] initWithRootViewController:_messagesController];
    UITabBarItem *messagesItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"tabbar_4b"] selectedImage:[UIImage imageNamed:@"tabbar_4a"]];
    _messagesNav.tabBarItem = messagesItem;
    
    //创建跟视图控制器对象
    _mainController = [[MainViewController alloc] init];
    
    
    //添加标签控制器中的子控制器
    _mainController.viewControllers = @[_babyNav, _findNav, _cameraController, _feedsNav, _messagesNav];
    
    return _mainController;
}


#pragma mark - tabBar 代理
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    //每次选中tabBarItem  更新用户偏好
    [ZSQStorage setItemSelectedIndex:tabBarController.selectedIndex];
    if (tabBarController.selectedIndex != 0) {
        [self setLoginView];
    }
}

#pragma mark - 注册通知 监听用户是否登录
- (void)registNotification{
    
    //注册通知 用户退出时 弹出登录页
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openApp:) name:@"LOGIN" object:nil];
}

#pragma mark - 监听的方法
- (void)openApp:(NSNotification *)noti{
    //设置默认选中
    [ZSQStorage setItemSelectedIndex:0];
    
    
}
#pragma mark - 创建登录页
- (void)setLoginView{
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
