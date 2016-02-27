//
//  ViewController.m
//  BabyProject
//
//  Created by 张树青 on 16/2/26.
//  Copyright © 2016年 zsq. All rights reserved.
//

#import "ShareViewController.h"

@interface ShareViewController () <UMSocialUIDelegate>

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
    
    CGRect rect1 = self.shareView.frame;
    CGRect rect2 = self.cancelBtn.frame;
    
    [UIView animateWithDuration:0.4 animations:^{
        self.bgView.hidden = YES;
        self.shareView.frame = CGRectMake(rect1.origin.x, rect1.origin.y + 280, rect1.size.width, rect1.size.height);
        self.cancelBtn.frame = CGRectMake(rect2.origin.x, rect2.origin.y + 100, rect2.size.width, rect2.size.height);
    } completion:^(BOOL finished) {
        [self removeFromParentViewController];
        [self.view removeFromSuperview];
    }];
}
//QQ空间分享
- (IBAction)qzoneBtn:(id)sender {
    
    [self cancelClick:nil];
    
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQzone] content:self.shareModel.text image:[UIImage imageNamed:@"Dudu.jpg"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];

    
}
//微信好友
- (IBAction)weichatBtn:(id)sender {
    
    [self cancelClick:nil];
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url = self.shareModel.WECHAT_MOMENT;
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:self.shareModel.text image:self.img location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];
    
    

}
//朋友圈
- (IBAction)friendQbtn:(id)sender {
    [self cancelClick:nil];
    
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:self.shareModel.text image:self.img location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];

}
//新浪微博
- (IBAction)weiboBtn:(id)sender {
    
    [self cancelClick:nil];
    
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:self.shareModel.text image:self.img location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];
    
//    [[UMSocialControllerService defaultControllerService] setShareText:@"分享内嵌文字" shareImage:[UIImage imageNamed:@"icon"] socialUIDelegate:self];        //设置分享内容和回调对象
//    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
}
//QQ
- (IBAction)qqBtn:(id)sender {
    
    [self cancelClick:nil];
    
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToQQ] content:self.shareModel.text image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response) {
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];
}
@end
