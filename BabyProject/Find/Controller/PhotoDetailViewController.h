//
//  PhotoDetailViewController.h
//  BabyProject
//
//  Created by 张树青 on 16/2/19.
//  Copyright © 2016年 zsq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet UIView *commentTxt;
- (IBAction)sendBtn:(id)sender;

@property (nonatomic, copy) NSMutableArray *feedsArray;
@property (nonatomic, assign) NSInteger index;
@end
