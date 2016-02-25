//
//  TimerHeaderViewController.m
//  BabyProject
//
//  Created by 张树青 on 16/2/25.
//  Copyright © 2016年 zsq. All rights reserved.
//

#import "TimerHeaderViewController.h"

@interface TimerHeaderViewController ()

@end

@implementation TimerHeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.babyImgV.layer.masksToBounds = YES;
    self.babyImgV.layer.cornerRadius = 25;
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
