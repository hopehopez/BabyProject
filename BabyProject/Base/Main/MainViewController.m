//
//  MainViewController.m
//  BabyProject
//
//  Created by 张树青 on 16/2/15.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController (){
    //用临时变量记录高亮状态的按钮
    UILabel *_tmpLabel;
    UINavigationController *_tmpNavigationController;
    UIImageView *_tmpImgV;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - 隐藏系统tabBar上的子视图
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //获得标签栏上的所有子视图
    NSArray *subViewsArray = self.tabBar.subviews;
    for (UIView *view in subViewsArray) {
        view.hidden = YES;
    }
}

#pragma mark - 创建导航条按钮 添加到tabBar上
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSArray *array = self.viewControllers;
    float margin = (SCREEN_WIDTH - 25 * 4 - 38)/6;
    for (int i = 0; i<array.count; i++) {
        UINavigationController *nav = [array objectAtIndex:i];
        //创建图片
        UIImageView *itemImgV = nil;
        if (i<2) {
            itemImgV = [[UIImageView alloc] initWithFrame:CGRectMake(margin + i * (margin + 25), 0, 25, 49)];
        }else if (i==2) {
            itemImgV = [[UIImageView alloc] initWithFrame:CGRectMake(margin + i * (margin + 25), 5, 38, 38)];
        }else{
            itemImgV = [[UIImageView alloc] initWithFrame:CGRectMake(margin + i * (margin + 25) + 13, 0, 25, 49)];}
        itemImgV.image = nav.tabBarItem.image;
        
        //将图片添加到标签栏
        [self.tabBar addSubview:itemImgV];
        
        //创建按钮上的文字
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 38, SCREEN_WIDTH/5, 10)];
//        label.text = nav.tabBarItem.title;
//        label.textAlignment = NSTextAlignmentCenter;
//        label.font = [UIFont systemFontOfSize:15];
//        [itemImgV addSubview:label];
        
        //设置默认第二个按钮
        
        if (i==1) {
            itemImgV.image = nav.tabBarItem.selectedImage;
            //[label setTextColor:[UIColor orangeColor]];
            //将当前高亮的按钮保存在临时变量
           // _tmpLabel = label;
            _tmpImgV = itemImgV;
            _tmpNavigationController = nav;
            self.selectedIndex = 1;
        }
        
        //创建点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        itemImgV.userInteractionEnabled = YES;
        //为每张图片设置tag值
        itemImgV.tag = i + 100;
        [itemImgV addGestureRecognizer:tap];
    }
    
}

- (void)tapClick:(UITapGestureRecognizer *)tap{
    
    //将临时变量改为低亮
    [_tmpLabel setTextColor:[UIColor blackColor]];
    _tmpImgV.image = _tmpNavigationController.tabBarItem.image;
    
    //将点击的按钮变为高亮
    NSArray *navigationControllerArray = self.viewControllers;
    UINavigationController *nav = [navigationControllerArray objectAtIndex:tap.view.tag - 100];
    
    UIImageView *imgV = (UIImageView *)tap.view;
    imgV.image = nav.tabBarItem.selectedImage;
    
    //获取图片上的label
    UILabel *lb = (UILabel *)[imgV.subviews lastObject];
    [lb setTextColor:[UIColor orangeColor]];
    
    //临时变量保存高亮按钮
    _tmpNavigationController = nav;
    _tmpLabel = lb;
    _tmpImgV = imgV;
    
    //子视图控制器页面 的切换
    self.selectedIndex = tap.view.tag - 100;
    
    [self.delegate tabBarController:self didSelectViewController:self.selectedViewController];
    //    NSLog(@"%li", tap.view.tag);
    //    UIImageView *imgV = (UIImageView *)tap.view;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
