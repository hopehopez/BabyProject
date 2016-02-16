//
//  TopicActivityViewController.h
//  BabyProject
//
//  Created by 张树青 on 16/2/16.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopicActivityViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *headView;
- (IBAction)backClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descTxt;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (weak, nonatomic) IBOutlet UITableView *tv;

@property (nonatomic, strong) ActivityModel *model;

@end
