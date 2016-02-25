//
//  TagFeedsViewController.h
//  BabyProject
//
//  Created by 张树青 on 16/2/17.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagFeedsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
- (IBAction)backClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tv;
@property (weak, nonatomic) IBOutlet UICollectionView *cv;

- (IBAction)addClick:(id)sender;


@property (nonatomic, copy) NSString *ID;

@end
