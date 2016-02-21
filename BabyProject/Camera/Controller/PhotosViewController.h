//
//  PhotosViewController.h
//  BabyProject
//
//  Created by 张树青 on 16/2/21.
//  Copyright © 2016年 zsq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotosViewController : UIViewController
- (IBAction)backBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UICollectionView *cv;

@property (nonatomic, strong) NSArray *dataArray1;

@end
