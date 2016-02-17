//
//  FeedsViewController.m
//  BabyProject
//
//  Created by 张树青 on 16/2/15.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import "FeedsViewController.h"
#import "SCNavTabBarController.h"
#import "FeatureViewController.h"

@interface FeedsViewController ()

@end

@implementation FeedsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
    [self prepareView];
    
}

- (void)prepareView{
    
    FeatureViewController *oneViewController = [[FeatureViewController alloc] init];
    oneViewController.title = @"成长记录";
    oneViewController.catagory = @"1";
    
    FeatureViewController *twoViewController = [[FeatureViewController alloc] init];
    twoViewController.title = @"用品";
    twoViewController.catagory = @"2";
    
    FeatureViewController *threeViewController = [[FeatureViewController alloc] init];
    threeViewController.title = @"玩具";
    threeViewController.catagory = @"5";
    FeatureViewController *fourViewController = [[FeatureViewController alloc] init];
    fourViewController.title = @"奶粉辅食";
    fourViewController.catagory = @"4";
    
    SCNavTabBarController *navTabBarController = [[SCNavTabBarController alloc] init];
    
    navTabBarController.subViewControllers = @[oneViewController, twoViewController, threeViewController, fourViewController];
    navTabBarController.view.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 );
    [navTabBarController addParentController:self];

    
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
