//
//  CameraBGViewController.m
//  BabyProject
//
//  Created by 张树青 on 16/2/18.
//  Copyright © 2016年 zsq. All rights reserved.
//

#import "CameraBGViewController.h"
#import "CameraViewController.h"
@interface CameraBGViewController ()

@end

@implementation CameraBGViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    CameraViewController *cameraController = [[CameraViewController alloc] init];
    
    NSInteger index = [ZSQStorage getItemSelectedIndex];
    NSArray *array = self.tabBarController.viewControllers;
    UIViewController *viewControl = array[index];
    [viewControl presentViewController:cameraController animated:YES completion:^{
        
         self.tabBarController.selectedIndex = index;
        
    }];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
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
