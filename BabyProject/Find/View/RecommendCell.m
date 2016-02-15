//
//  RecommendCell.m
//  BabyProject
//
//  Created by 张树青 on 16/2/15.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import "RecommendCell.h"

@implementation RecommendCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(RecommendModel *)model{
    self.nameLabel.text = model.name;
    self.countLabel.text = [NSString stringWithFormat:@"%@%@", model.count, @"条记录"];
    [self.imgV1 sd_setImageWithURL:[NSURL URLWithString:model.imagesArray[0]] placeholderImage:[UIImage imageNamed:@"default_feed"] options:SDWebImageRefreshCached];
    [self.imgV2 sd_setImageWithURL:[NSURL URLWithString:model.imagesArray[1]] placeholderImage:[UIImage imageNamed:@"default_feed"] options:SDWebImageRefreshCached];
    [self.imgV3 sd_setImageWithURL:[NSURL URLWithString:model.imagesArray[2]] placeholderImage:[UIImage imageNamed:@"default_feed"] options:SDWebImageRefreshCached];
    [self.imgv4 sd_setImageWithURL:[NSURL URLWithString:model.imagesArray[3]] placeholderImage:[UIImage imageNamed:@"default_feed"] options:SDWebImageRefreshCached];
}

@end
