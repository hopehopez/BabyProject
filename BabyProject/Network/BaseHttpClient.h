//
//  BaseHttpClient.h
//  LimiteFree
//
//  Created by 张树青 on 16/1/21.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

//AFNetworking的再次封装 

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
//生成枚举 表示http请求的方式 GET POST PUT DELETE
typedef enum{
    GET = 1,
    POST,
    PUT,
    DELETE
}BaseHttpType;
//外部传入不同的枚举值 内部调用不同的请求方法进行请求
//定义两个block的类型 用于成功与失败的回调

typedef void (^httpSuccessBlock)(NSURL *url, NSDictionary *data);
//当前应用程序中所有的json最外层都是字典

typedef void (^httpFailBlock)(NSURL *url, NSError *error);

@interface BaseHttpClient : NSObject
//属性的声明
@property (nonatomic, copy) NSString *baseURL;
//请求接口服务器地址 API相同的前缀

@property (nonatomic, strong) AFHTTPSessionManager *manager;
//AFNetworking session 请求

//接口的声明
//网络层的封装 基本上都是抽象成单例类

//单例类对象方法的声明
+ (BaseHttpClient *)sharedBaseHttpClient;

//公共请求方法的声明
//传递请求的方式 以及相关的block等信息 在该方法内部再处理

+ (NSURL *)httpType:(BaseHttpType)type
             andURL:(NSString *)url
      andParameters:(NSDictionary *)params
    andSuccessBlock:(httpSuccessBlock)successBlock
       andFailBlock:(httpFailBlock)failBlock;

//取消所有请求的方法声明
+ (void)cancelHttpOperations;
//取消当前请求队列中的所有请求




@end
