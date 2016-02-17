//
//  AddBabyViewController.m
//  BabyProject
//
//  Created by 张树青 on 16/2/18.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import "AddBabyViewController.h"

@interface AddBabyViewController ()

@end

@implementation AddBabyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.babyImagv.layer.masksToBounds = YES;
    self.babyImagv.layer.cornerRadius = 40;
    
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

- (IBAction)backBtn:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)inviteBtn:(id)sender {
}
- (IBAction)nextBtn:(id)sender {
}
@end
