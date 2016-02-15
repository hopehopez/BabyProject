//
//  BaseHttpClient.m
//  LimiteFree
//
//  Created by 张树青 on 16/1/21.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import "BaseHttpClient.h"

static BaseHttpClient *shareBaseHttpClient = nil;
//单例指针

@implementation BaseHttpClient

- (instancetype)initWithBaseUrl:(NSString *)baseUrl{
    self = [super init];
    if (self) {
        //在创建类的对象时 记录baseUrl 以及创建session对象 为网络数据的请求做好准备
        //网络封装时 请求数据用到的manager都是在构造方法中初始化的
        
        _baseURL = baseUrl;
        
        _manager = [AFHTTPSessionManager manager];
        
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        //如果该写法在使用时 会出现错误 提示需要加一句话 设置一下该manager支持的文件格式
        
        
        
    }
    return self;
}

#pragma mark -- 单例类方法
+ (BaseHttpClient *)sharedBaseHttpClient{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareBaseHttpClient = [[self alloc] initWithBaseUrl:BASE_URL];
    });
    return shareBaseHttpClient;
}

#pragma mark - 公共请求方法
+ (NSURL *)httpType:(BaseHttpType)type andURL:(NSString *)url andParameters:(NSDictionary *)params andSuccessBlock:(httpSuccessBlock)successBlock andFailBlock:(httpFailBlock)failBlock{
    //根据type去调用对应的请求方法
    //完整的逻辑应该是当前应用程序没有网络 直接返回错误提示 有网络 再进行请求
    
    if (![self isReachableEnable]) {
        
        NSLog(@"当前网络不可用!");//测试语句
        
        //1.创建单例对象
        BaseHttpClient *client = [BaseHttpClient sharedBaseHttpClient];
        
        //2.拼接请求的地址并转换
        NSString *signurl = [NSString stringWithFormat:@"%@%@", client.baseURL, url];
        //请求的地址应该是服务器地址 (API相同的前缀) 以及接口地址
        
        signurl = [signurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //转码 转化成二进制 避免地址中存在非法字符
        //地址的合法化
        
        //3.拼接返回的NSURL
        NSURL *returnURL = [NSURL URLWithString:signurl];
        
        return returnURL;
    } else {
        //通过请求的类型 调用不同的接口
        switch (type) {
            case GET:
                [self httpGetWithURL:url andParam:params andSuccessBlock:successBlock andFailBlock:failBlock];
                break;
            case POST:
                [self httpPOSTWithURL:url andParam:params andSuccessBlock:successBlock andFailBlock:failBlock];
                break;
            case PUT:
                [self httpGetWithURL:url andParam:params andSuccessBlock:successBlock andFailBlock:failBlock];
                break;
            case DELETE:
                [self httpGetWithURL:url andParam:params andSuccessBlock:successBlock andFailBlock:failBlock];
                break;
            default:
                break;
        }
    }
    
    return nil;
}

#pragma mark - 检测网络 
+ (BOOL)isReachableEnable{
    //检查当前是否有网络
    return [[Reachability reachabilityForInternetConnection] isReachable];
    //调用reachablity类中检查网络的方法
}

/**
 *  http不同的请求方法接口的封装
 */
#pragma mark - GET请求
+ (NSURL *)httpGetWithURL:(NSString *)url andParam:(NSDictionary *)param andSuccessBlock:(httpSuccessBlock)successBlock andFailBlock:(httpFailBlock)failBlock{
    //请求地址 请求参数 成功的回调 失败的回调
    
    //创建当前类的单例对象 使用对象的manager属性进行请求 请求的处理 使用GCD 放入主线程中 优先处理
    //关于方法的返回值
    
    //关于方法的返回值 将请求的地址转为NSURL对象进行返回
    //1.创建单例对象
    BaseHttpClient *client = [BaseHttpClient sharedBaseHttpClient];
    
    //2.拼接请求的地址并转换
    NSString *signurl = [NSString stringWithFormat:@"%@%@", client.baseURL, url];
    //请求的地址应该是服务器地址 (API相同的前缀) 以及接口地址
    
    signurl = [signurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //转码 转化成二进制 避免地址中存在非法字符
    //地址的合法化
    
    //3.拼接返回的NSURL
    NSURL *returnURL = [NSURL URLWithString:signurl];
    
    //4.请求地址不为空时进行请求
    if (![ISNull isNilOfSender:url]) {
        //使用client 对象中managr属性进行请求
        [client.manager GET:signurl parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
            //解析数据 判断是否为空 为空 回调错误block 不为空 回调成功block block的调用加入主队列 优先处理
            //(1)解析
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
             //(2)判断是否为空
            dispatch_async(dispatch_get_main_queue(), ^{
                //回调的处理都放在主队列中进行管理
                if (![ISNull isNilOfSender:dic]) {
                    successBlock(returnURL, dic);
                    //不为空 将数据返回
                } else {
                    //为空 返回一个请求数据位空的错误信息
                    NSError *error = [NSError errorWithDomain:@"请求数据为空" code:999 userInfo:nil];
                    //Domain 主要操作的提示
                    //code 错误编码
                    //userInfo 错误的详细信息
                    
                    failBlock(returnURL, error);
                }
                
            });
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            failBlock(returnURL, error);
            //请求发生错误 直接回调
        }];
    }
    
    return nil;
}

#pragma mark - POST请求
+ (NSURL *)httpPOSTWithURL:(NSString *)url andParam:(NSDictionary *)param andSuccessBlock:(httpSuccessBlock)successBlock andFailBlock:(httpFailBlock)failBlock{
    //请求地址 请求参数 成功的回调 失败的回调
    
    //创建当前类的单例对象 使用对象的manager属性进行请求 请求的处理 使用GCD 放入主线程中 优先处理
    //关于方法的返回值
    
    //关于方法的返回值 将请求的地址转为NSURL对象进行返回
    //1.创建单例对象
    BaseHttpClient *client = [BaseHttpClient sharedBaseHttpClient];
    
    //2.拼接请求的地址并转换
    NSString *signurl = [NSString stringWithFormat:@"%@%@", client.baseURL, url];
    //请求的地址应该是服务器地址 (API相同的前缀) 以及接口地址
    
    signurl = [signurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //转码 转化成二进制 避免地址中存在非法字符
    //地址的合法化
    
    //3.拼接返回的NSURL
    NSURL *returnURL = [NSURL URLWithString:signurl];
    
    //4.请求地址不为空时进行请求
    if (![ISNull isNilOfSender:url]) {
        //使用client 对象中managr属性进行请求
        [client.manager POST:signurl parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
            //解析数据 判断是否为空 为空 回调错误block 不为空 回调成功block block的调用加入主队列 优先处理
            //(1)解析
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            //(2)判断是否为空
            dispatch_async(dispatch_get_main_queue(), ^{
                //回调的处理都放在主队列中进行管理
                if (![ISNull isNilOfSender:dic]) {
                    successBlock(returnURL, dic);
                    //不为空 将数据返回
                } else {
                    //为空 返回一个请求数据位空的错误信息
                    NSError *error = [NSError errorWithDomain:@"请求数据为空" code:999 userInfo:nil];
                    //Domain 主要操作的提示
                    //code 错误编码
                    //userInfo 错误的详细信息
                    
                    failBlock(returnURL, error);
                }
                
            });
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            failBlock(returnURL, error);
            //请求发生错误 直接回调
        }];
    }
    
    return nil;
}
#pragma mark - PUT请求
+ (NSURL *)httpPUTWithURL:(NSString *)url andParam:(NSDictionary *)param andSuccessBlock:(httpSuccessBlock)successBlock andFailBlock:(httpFailBlock)failBlock{
    //请求地址 请求参数 成功的回调 失败的回调
    
    //创建当前类的单例对象 使用对象的manager属性进行请求 请求的处理 使用GCD 放入主线程中 优先处理
    //关于方法的返回值
    
    //关于方法的返回值 将请求的地址转为NSURL对象进行返回
    //1.创建单例对象
    BaseHttpClient *client = [BaseHttpClient sharedBaseHttpClient];
    
    //2.拼接请求的地址并转换
    NSString *signurl = [NSString stringWithFormat:@"%@%@", client.baseURL, url];
    //请求的地址应该是服务器地址 (API相同的前缀) 以及接口地址
    
    signurl = [signurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //转码 转化成二进制 避免地址中存在非法字符
    //地址的合法化
    
    //3.拼接返回的NSURL
    NSURL *returnURL = [NSURL URLWithString:signurl];
    
    //4.请求地址不为空时进行请求
    if (![ISNull isNilOfSender:url]) {
        //使用client 对象中managr属性进行请求
        [client.manager PUT:signurl parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
            //解析数据 判断是否为空 为空 回调错误block 不为空 回调成功block block的调用加入主队列 优先处理
            //(1)解析
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            //(2)判断是否为空
            dispatch_async(dispatch_get_main_queue(), ^{
                //回调的处理都放在主队列中进行管理
                if (![ISNull isNilOfSender:dic]) {
                    successBlock(returnURL, dic);
                    //不为空 将数据返回
                } else {
                    //为空 返回一个请求数据位空的错误信息
                    NSError *error = [NSError errorWithDomain:@"请求数据为空" code:999 userInfo:nil];
                    //Domain 主要操作的提示
                    //code 错误编码
                    //userInfo 错误的详细信息
                    
                    failBlock(returnURL, error);
                }
                
            });
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            failBlock(returnURL, error);
            //请求发生错误 直接回调
        }];
    }
    
    return nil;
}
#pragma mark - DELETE请求
+ (NSURL *)httpDELETEWithURL:(NSString *)url andParam:(NSDictionary *)param andSuccessBlock:(httpSuccessBlock)successBlock andFailBlock:(httpFailBlock)failBlock{
    //请求地址 请求参数 成功的回调 失败的回调
    
    //创建当前类的单例对象 使用对象的manager属性进行请求 请求的处理 使用GCD 放入主线程中 优先处理
    //关于方法的返回值
    
    //关于方法的返回值 将请求的地址转为NSURL对象进行返回
    //1.创建单例对象
    BaseHttpClient *client = [BaseHttpClient sharedBaseHttpClient];
    
    //2.拼接请求的地址并转换
    NSString *signurl = [NSString stringWithFormat:@"%@%@", client.baseURL, url];
    //请求的地址应该是服务器地址 (API相同的前缀) 以及接口地址
    
    signurl = [signurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //转码 转化成二进制 避免地址中存在非法字符
    //地址的合法化
    
    //3.拼接返回的NSURL
    NSURL *returnURL = [NSURL URLWithString:signurl];
    
    //4.请求地址不为空时进行请求
    if (![ISNull isNilOfSender:url]) {
        //使用client 对象中managr属性进行请求
        [client.manager DELETE:signurl parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
            //解析数据 判断是否为空 为空 回调错误block 不为空 回调成功block block的调用加入主队列 优先处理
            //(1)解析
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            //(2)判断是否为空
            dispatch_async(dispatch_get_main_queue(), ^{
                //回调的处理都放在主队列中进行管理
                if (![ISNull isNilOfSender:dic]) {
                    successBlock(returnURL, dic);
                    //不为空 将数据返回
                } else {
                    //为空 返回一个请求数据位空的错误信息
                    NSError *error = [NSError errorWithDomain:@"请求数据为空" code:999 userInfo:nil];
                    //Domain 主要操作的提示
                    //code 错误编码
                    //userInfo 错误的详细信息
                    
                    failBlock(returnURL, error);
                }
                
            });
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            failBlock(returnURL, error);
            //请求发生错误 直接回调
        }];
    }
    
    return nil;
}

#pragma mark - 取消
+ (void)cancelHttpOperations{
    
    //取消所有当前的网络请求
    [[BaseHttpClient sharedBaseHttpClient].manager.operationQueue cancelAllOperations];
    
   // [[AFHTTPSessionManager manager].operationQueue cancelAllOperations];
    
}

@end
