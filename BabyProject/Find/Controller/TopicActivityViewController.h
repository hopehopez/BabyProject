//
//  TopicActivityViewController.h
//  BabyProject
//
//  Created by 张树青 on 16/2/16.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopicActivityViewController : UIViewController

- (IBAction)backClick:(id)sender;


@property (weak, nonatomic) IBOutlet UITableView *tv;
@property (weak, nonatomic) IBOutlet UICollectionView *cv;

@property (nonatomic, strong) ActivityModel *model;

@end
