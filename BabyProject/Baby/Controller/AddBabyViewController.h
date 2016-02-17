//
//  AddBabyViewController.h
//  BabyProject
//
//  Created by 张树青 on 16/2/18.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddBabyViewController : UIViewController
- (IBAction)backBtn:(id)sender;
- (IBAction)inviteBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *babyImagv;
@property (weak, nonatomic) IBOutlet UITextField *nameTxt;
@property (weak, nonatomic) IBOutlet UITextField *birthdayTxt;
@property (weak, nonatomic) IBOutlet UIButton *boyBtn;
@property (weak, nonatomic) IBOutlet UIButton *girlBtn;
@property (weak, nonatomic) IBOutlet UIButton *mmBtn;
@property (weak, nonatomic) IBOutlet UIButton *ddBtn;
- (IBAction)nextBtn:(id)sender;

@end
