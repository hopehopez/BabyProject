//
//  FeedCell.m
//  BabyProject
//
//  Created by 张树青 on 16/2/16.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import "FeedCell.h"

@implementation FeedCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(FeedModel *)model{
    
    [self.headPicImgV sd_setImageWithURL:[NSURL URLWithString:model.creatorHeadPic] placeholderImage:nil options:SDWebImageRefreshCached];
    self.nickNameLabel.text = model.creatorNickName;
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:nil options:SDWebImageRefreshCached];
    self.cityLabel.text = [NSString stringWithFormat:@"%@%@", model.city, model.region];
    self.titleLabel.text = model.addonTitles;
}

- (IBAction)followClick:(id)sender {
}
@end
