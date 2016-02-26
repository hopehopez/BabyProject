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
#import "CameraBGViewController.h"
#import "FeedsViewController.h"
#import "MessagesViewController.h"

#import "UMSocial.h"

@interface AppDelegate ()<UITabBarControllerDelegate>{
    //宝贝视图控制器
    BabyViewController *_babyController;
    UINavigationController *_babyNav;
    
    //发现视图控制器
    FindViewController *_findController;
    UINavigationController *_findNav;
    
    //相机视图控制器
    CameraBGViewController *_cameraController;
    
    //动态视图控制器
    FeedsViewController *_feedsController;
    UINavigationController *_feedsNav;
    
    //消息视图控制器
    MessagesViewController *_messagesController;
    UINavigationController *_messagesNav;
    
    //主视图控制器
//    MainViewController *_mainController;
//    UINavigationController *_mainNav;
}

@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [UMSocialData setAppKey:@"56cffb8b67e58e98eb002693"];
    
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    //设置状态栏为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    NSInteger isInstall = [ZSQStorage isInstall];
    
    if (isInstall) {
        _window.rootViewController = [self createRootController];
    }else {
        _window.rootViewController = [self createGuidanceView];
    }    
    
    _window.backgroundColor = [UIColor orangeColor];
    
    [_window makeKeyAndVisible];
    
    //循环检测网络状态
    [self monitorNetworkStatus];
    
    return YES;
    
}


#pragma mark -- 创建引导页
- (GuidanceViewController *)createGuidanceView{
    
    NSArray *imageArray = @[@"app1.jpg",@"app2.jpg",@"app3.jpg",@"app4.jpg"];
    
    GuidanceViewController *guidanceView = [[GuidanceViewController alloc]initWithImagesArr:imageArray andBlock:^{
        
        [ZSQStorage install];
        self.window.rootViewController = [self createRootController];
        
        NSLog(@"进入应用跳转成功！");
    }];
    
    return guidanceView;
    
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
    _cameraController = [[CameraBGViewController alloc] init];
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
    
    _mainController.delegate = self;
    
    return _mainController;
}

#pragma mark - 创建登录页
- (void)setLoginView{
    NSInteger login = [ZSQStorage getLogin];
    if (!login) {
        LoginViewController *loginView = [[LoginViewController alloc] init];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginView];
        
        [self.mainController presentViewController:nav animated:YES completion:nil];
    }
}

#pragma mark - tabBar 代理
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    //每次选中tabBarItem  更新用户偏好
    [ZSQStorage setItemSelectedIndex:tabBarController.selectedIndex];

}

//设置某个控制器不显示
- ( BOOL )tabBarController:( UITabBarController *)tabBarController shouldSelectViewController :( UIViewController *)viewController{
    
    // 代表 HMT_CViewController 这个 View 无法显示 , 无法点击到它代表的标签栏
    
//    if ([viewController isKindOfClass :[ CameraBGViewController class ]]) {
//       
//        return NO ;
//        
//    }
    return YES ;
    
}


#pragma mark - 注册通知 监听用户是否登录
- (void)registNotification{
    
    //注册通知 用户退出时 弹出登录页
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openApp:) name:@"LOGIN" object:nil];
}

#pragma mark - 监听的方法
- (void)openApp:(NSNotification *)noti{
   
    [self setLoginView];
    
}

#pragma mark - 循环检测网络连接状态

-(void)monitorNetworkStatus
{
    //1. 创建对象 通过不断的去请求百度的地址来检测网络状态
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    
    //2. 注册通知 监听网络状态
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    //3. 开始监听 如果网络状态发生变化 则触发通知方法
    [reach startNotifier];
}

#pragma mark -- 网络状态改变触发的通知方法
-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    
    if([reach isReachable])
    {
       // NSLog(@"Notification Says Reachable");
    }
    else
    {
       // NSLog(@"Notification Says Unreachable");
        [self showNoticeMsg:@"无网络连接，请检查网络" WithInterval:2.0f];
    }
}
#pragma mark - 全局提示信息
//提示网络状态（不带block）
-(void)showNoticeMsg:(NSString *)msg WithInterval:(float)timer
{
    [AJNotificationView showNoticeInView:self.window
                                    type:AJNotificationTypeBlue
                                   title:msg
                         linedBackground:AJLinedBackgroundTypeAnimated
                               hideAfter:timer
                                response:^{
                                    // NSLog(@"Response block");
                                }];
}
//提示网络状态（带block）
-(void)showNoticeMsg:(NSString *)msg WithInterval:(float)timer Block:(void (^)(void))response
{
    [AJNotificationView showNoticeInView:self.window
                                    type:AJNotificationTypeBlue
                                   title:msg
                         linedBackground:AJLinedBackgroundTypeAnimated
                               hideAfter:timer offset:0.0f delay:0.0f detailDisclosure:YES
                                response:response];
}

//提示正在提交
-(void)showLoading:(NSString *)msg
{
    NSString *content;
    
    if (msg==nil) {
        content=@"正在提交数据，请稍后…"; //正在提交数据，请稍后…
    }
    else
    {
        content=msg;
    }
    
    [SVProgressHUD showWithStatus:content maskType:SVProgressHUDMaskTypeClear];
}

//关闭提示
-(void)hideLoading
{
    [SVProgressHUD dismiss];
}

//提示成功信息 并在几秒后自动关闭
-(void)hideLoadingWithSuc:(NSString *)msg WithInterval:(float)timer
{
    [SVProgressHUD dismissWithSuccess:msg afterDelay:timer];
}

//提示错误信息 并在几秒后自动关闭
-(void)hideLoadingWithErr:(NSString *)msg WithInterval:(float)timer
{
    [SVProgressHUD dismissWithError:msg afterDelay:timer];
}

//提示成功
-(void)showSucMsg:(NSString *)msg WithInterval:(float)timer
{
    NSString *content;
    
    if (msg==nil) {
        content=@"成功"; //成功
    }
    else
    {
        content=msg;
    }
    
    [SVProgressHUD show];
    [SVProgressHUD dismissWithSuccess:content afterDelay:timer];
}

//提示失败
-(void)showErrMsg:(NSString *)msg WithInterval:(float)timer
{
    NSString *content = nil;
    
    if (msg==nil) {
        content = @"失败";  //失败
    }
    else
    {
        content = msg;
    }
    
    [SVProgressHUD show];
    [SVProgressHUD dismissWithError:content afterDelay:timer];
}

//提示网络错误
- (void)showNetworkError
{
    [SVProgressHUD show];
    [SVProgressHUD dismissWithError:@"网络错误" afterDelay:1.5];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    //app已经进入后台时 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"LOGIN" object:nil];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    //app已经进入激活状态是 注册通知
    [self registNotification];
    
    //[self setLoginView];
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
