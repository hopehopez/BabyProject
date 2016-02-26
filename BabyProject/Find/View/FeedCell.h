//
//  FeedCell.h
//  BabyProject
//
//  Created by 张树青 on 16/2/16.
//  Copyright (c) 2016年 zsq. All rights reserved.
//


#import <UIKit/UIKit.h>
@class FeedCell;

@protocol FeedCellDelegate <NSObject>

- (void)addGood:(FeedCell *)cell;
- (void)addComment:(FeedCell *)cell;
- (void)addShare:(FeedCell *)cell;

@end

@interface FeedCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headPicImgV;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
- (IBAction)followClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *jingImagV;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;

@property (weak, nonatomic) IBOutlet UIButton *goodBtn;
- (IBAction)goodClick:(id)sender;
- (IBAction)commentClick:(id)sender;
- (IBAction)shareClick:(id)sender;
- (IBAction)detailBtn:(UIButton *)sender;

@property (nonatomic, strong) FeedModel *model;
@property (nonatomic, strong) FeedModel *model2;
@property (nonatomic, weak) id <FeedCellDelegate> delegate;
@property (nonatomic, strong) UIViewController *controller;
@property (nonatomic, assign) NSInteger row;

@end
