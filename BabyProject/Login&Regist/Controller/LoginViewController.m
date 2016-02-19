//
//  LoginViewController.m
//  BabyProject
//
//  Created by 张树青 on 16/2/17.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"
@interface LoginViewController (){
    RegisterViewController *_regController;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
    self.hidesBottomBarWhenPushed = YES;
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


- (IBAction)weiLogin:(id)sender {
}

- (IBAction)sinaLogin:(id)sender {
}

- (IBAction)qqLogin:(id)sender {
}

- (IBAction)phoneLogin:(id)sender {
}

- (IBAction)registClick:(id)sender {
    _regController = [[RegisterViewController alloc] init];
    
    [self.navigationController pushViewController:_regController animated:YES];
    
}

- (IBAction)ignoreLogin:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
