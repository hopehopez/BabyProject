//
//  IconCell.h
//  BabyProject
//
//  Created by 张树青 on 16/2/24.
//  Copyright © 2016年 zsq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IconCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *title;
//展示文字

@property (nonatomic, strong) UIImageView *iconImageView;
//展示图片

- (void)reloadCellWithImage:(NSString *)imageName;

@end
