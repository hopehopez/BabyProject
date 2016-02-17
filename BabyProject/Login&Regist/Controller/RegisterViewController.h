//
//  RegisterViewController.h
//  BabyProject
//
//  Created by 张树青 on 16/2/17.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
- (IBAction)backClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *phoneTxt;
- (IBAction)regClick:(id)sender;

@end
