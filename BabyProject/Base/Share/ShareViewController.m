//
//  ViewController.m
//  BabyProject
//
//  Created by 张树青 on 16/2/26.
//  Copyright © 2016年 zsq. All rights reserved.
//

#import "ShareViewController.h"

@interface ShareViewController ()

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self prepareView];
}

- (void)prepareView{
   
    self.shareView.layer.cornerRadius = 10;
    self.shareView.layer.masksToBounds = YES;
    self.cancelBtn.layer.cornerRadius = 10;
    
    self.view.backgroundColor = [UIColor clearColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(share:)];
    
    [self.weichatImgV addGestureRecognizer:tap];
    [self.friendQImgV addGestureRecognizer:tap];
    [self.qzoneImgv addGestureRecognizer:tap];
    [self.weiboImgV addGestureRecognizer:tap];
    [self.qqImgV addGestureRecognizer:tap];
    //self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300);

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

- (IBAction)cancelClick:(UIButton *)sender {
    
    //[self dismissViewControllerAnimated:YES completion:nil];
    
    [UIView animateWithDuration:1
                     animations:^{
                         [self.view removeFromSuperview];
                     }];
    
}
@end
