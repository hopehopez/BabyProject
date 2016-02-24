//
//  IconCell.m
//  BabyProject
//
//  Created by 张树青 on 16/2/24.
//  Copyright © 2016年 zsq. All rights reserved.
//

#import "IconCell.h"

@implementation IconCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame{
    //cell常用的构造方法
    
    if (self = [super initWithFrame:frame]) {
        
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width -10, self.frame.size.height - 10)];
        self.backgroundColor = [UIColor colorWithRed:218/255.0 green:218/255.0 blue:218/255.0 alpha:1];
        [self.contentView addSubview:_iconImageView];
        //self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}


- (void)reloadCellWithImage:(NSString *)imageName{
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:nil options:SDWebImageRefreshCached];
    
}


@end
