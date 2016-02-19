//
//  CommentCell.m
//  BabyProject
//
//  Created by 张树青 on 16/2/19.
//  Copyright © 2016年 zsq. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

- (void)awakeFromNib {
    // Initialization code
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = 15;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(CommentModel1 *)model{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.headPic] placeholderImage:nil options:SDWebImageRefreshCached];
    self.nameLabel.text = model.nickName;
    self.commentLabel.text = model.content;
}

@end
