//
//  RecommendCell.h
//  BabyProject
//
//  Created by 张树青 on 16/2/15.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendModel.h"
@interface RecommendCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgV1;
@property (weak, nonatomic) IBOutlet UIImageView *imgV2;
@property (weak, nonatomic) IBOutlet UIImageView *imgV3;
@property (weak, nonatomic) IBOutlet UIImageView *imgv4;

@property (nonatomic, strong) RecommendModel *model;

@end
