//
//  ZSQStorage.m
//  ZSQDemo
//
//  Created by 张树青 on 15/12/28.
//  Copyright (c) 2015年 zsq. All rights reserved.
//

#import "ZSQStorage.h"


@implementation ZSQStorage

#pragma  mark - 获取沙盒路径
+ (NSString *)getDocumentsPath{
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = array[0];
    return documentPath;
}

#pragma mark - 设置为已安装
+ (void)install{
    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"install"];
}
#pragma mark - 判断是否安装
+ (NSInteger)isInstall{
    return  [[NSUserDefaults standardUserDefaults] integerForKey:@"install"];
}

#pragma mark - 设置选中的item的index
+ (void)setItemSelectedIndex:(NSInteger)index{
    
    if (index!=2) {
        [[NSUserDefaults standardUserDefaults] setInteger:index forKey:@"itemSelected"];
    }
    
}

#pragma mark - 获取选中的item的index
+ (NSInteger)getItemSelectedIndex{
  return  [[NSUserDefaults standardUserDefaults] integerForKey:@"itemSelected"];
}

#pragma mark - 设置用户登录状态
+ (void)setLogin:(NSInteger)login{
    [[NSUserDefaults standardUserDefaults] setInteger:login forKey:@"isLogin"];
}
#pragma mark - 获取用户登录状态
+ (NSInteger)getLogin{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"isLogin"];
}


#pragma mark - 记录当前登录用户
+ (void)setCurrentUser:(NSDictionary *)userDict{
    [[NSUserDefaults standardUserDefaults] setObject:userDict forKey:@"CurrentUser"];
}
#pragma mark - 获取当前登录用户
+ (NSDictionary *)getCurrentUser{
    NSObject *obj = [[NSUserDefaults standardUserDefaults] objectForKey:@"CurrentUser"];
    if (obj) {
        return (NSDictionary *)obj;
    }else {
        return nil;
    }
}

#pragma mark - 存储网络连接状态
+ (void)setNetworkStatus:(NSInteger)status{

    [[NSUserDefaults standardUserDefaults] setInteger:status forKey:@"NetWorkStatus"];
}

#pragma mark - 获取网络连接状态
+ (NSInteger)getNetWorkStatus{

    return [[NSUserDefaults standardUserDefaults] integerForKey:@"NetWorkStatus"];
}

@end
