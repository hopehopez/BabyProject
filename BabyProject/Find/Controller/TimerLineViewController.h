//
//  TimerLineViewController.h
//  BabyProject
//
//  Created by 张树青 on 16/2/25.
//  Copyright © 2016年 zsq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimerLineViewController : UIViewController
- (IBAction)backClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tv;

@property (nonatomic, strong) FeedModel *model;

@end
