//
//  ZSQStorage.h
//  ZSQDemo
//
//  Created by 张树青 on 15/12/28.
//  Copyright (c) 2015年 zsq. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 数据操作类 增删改查 用户信息
 */
@interface ZSQStorage : NSObject
/*
 设置为安装
 */
+ (void)install;
/*
 判断是否安装
 */
+ (NSInteger)isInstall;
/*
 设置选中的item的index
 */
+ (void)setItemSelectedIndex:(NSInteger)index;
/*
 获取选中的item的index
 */
+ (NSInteger)getItemSelectedIndex;

/**
 *  设置用户登录状态
 */
+ (void)setLogin:(NSInteger)login;
/**
 *  获取用户登录状态
 */
+ (NSInteger)getLogin;

/**
 *  记录当前登录用户
 */
+ (void)setCurrentUser:(NSDictionary *)userDict;
/**
 *  获取当前登录用户
 */
+ (NSDictionary *)getCurrentUser;

/*
 获取沙盒中Documents的路径
 */
+ (NSString *)getDocumentsPath;

/*
 存储网络连接状态
 */
+ (void)setNetworkStatus:(NSInteger)status;
/*
 获取网络连接状态
 */
+ (NSInteger)getNetWorkStatus;
@end
