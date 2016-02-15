//
//  FindViewController.h
//  BabyProject
//
//  Created by 张树青 on 16/2/15.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindViewController : UIViewController
- (IBAction)SegmentChange:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
