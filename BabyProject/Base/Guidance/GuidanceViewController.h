//
//  GuidanceViewController.h
//  LimiteFree
//
//  Created by Elean on 16/1/19.
//  Copyright (c) 2016年 Elean. All rights reserved.
//
//实现引导页 App安装后只展示一次

#import <UIKit/UIKit.h>
typedef void(^MyBlock)(void);
@interface GuidanceViewController : UIViewController

/*
- (instancetype)initWithImagesArr:(NSArray *)imagesArr andBlock:(void(^)(void))block;
*/
- (instancetype)initWithImagesArr:(NSArray *)imagesArr andBlock:(MyBlock)block;
//imagesArr 引导页的图片名 block 最后一张引导页显示结束的回调 到AppDelegate 修改根控制器


//init --> loadView --> viewDidLoad --> viewWillAppear --> viewDidAppear --> viewWillDisappear --> viewDidDisappear --> dealloc

//如果控制器在创建之初 带有xib init方法会在viewDidLoad后边执行

@end









