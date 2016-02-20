//
//  PhotoDetailViewController.h
//  BabyProject
//
//  Created by 张树青 on 16/2/19.
//  Copyright © 2016年 zsq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoDetailViewController : UIViewController

@property (nonatomic, copy) NSMutableArray *feedsArray;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL isComment;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet UITextView *commentTxt;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewContraint;

- (IBAction)backBtn:(id)sender;
- (IBAction)sendBtn:(id)sender;


@end
