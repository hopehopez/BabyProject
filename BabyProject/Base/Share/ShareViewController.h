//
//  ViewController.h
//  BabyProject
//
//  Created by 张树青 on 16/2/26.
//  Copyright © 2016年 zsq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *shareView;
@property (weak, nonatomic) IBOutlet UIImageView *weichatImgV;
@property (weak, nonatomic) IBOutlet UIImageView *friendQImgV;
@property (weak, nonatomic) IBOutlet UIImageView *qzoneImgv;
@property (weak, nonatomic) IBOutlet UIImageView *weiboImgV;
@property (weak, nonatomic) IBOutlet UIImageView *qqImgV;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
- (IBAction)cancelClick:(UIButton *)sender;

@end
