//
//  ViewController.h
//  BabyProject
//
//  Created by 张树青 on 16/2/26.
//  Copyright © 2016年 zsq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *shareView;
- (IBAction)qzoneBtn:(id)sender;
- (IBAction)weichatBtn:(id)sender;

- (IBAction)friendQbtn:(id)sender;
- (IBAction)weiboBtn:(id)sender;


- (IBAction)qqBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
- (IBAction)cancelClick:(UIButton *)sender;

@property (nonatomic, strong) ShareModel *shareModel;
@property (nonatomic, strong) UIImage *img;

@end
