//
//  TimerHeaderViewController.h
//  BabyProject
//
//  Created by 张树青 on 16/2/25.
//  Copyright © 2016年 zsq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimerHeaderViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIImageView *userImgV;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UIImageView *babyImgV;
@property (weak, nonatomic) IBOutlet UILabel *babyNameLabel;

@end
