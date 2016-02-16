//
//  TopicActivityViewController.m
//  BabyProject
//
//  Created by 张树青 on 16/2/16.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#define NUMBER 18

#import "TopicActivityViewController.h"

@interface TopicActivityViewController ()<UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *_dataArray;
    NSInteger _page;
}
@end

@implementation TopicActivityViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _page = 0;
    _dataArray = [NSMutableArray array];
    
    [self prepareView];

    
    [self loadData];
    
}

- (void)prepareView{
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:self.model.sampleImage] placeholderImage:nil options:SDWebImageRefreshCached];
    self.nameLabel.text = self.model.name;
    self.countLabel.text = [NSString stringWithFormat:@"%@%@", self.model.accomplishedTimes, @"人次参与"];
    self.descTxt.text = self.model.descriptionK;

}

#pragma mark - 下载数据
- (void)loadData{
    NSString *url = [NSString stringWithFormat:FIND_LATEST_TOPICS, self.model.addonId, _page * NUMBER];
    [BaseHttpClient httpType:GET andURL:url andParameters:nil andSuccessBlock:^(NSURL *url, NSDictionary *data) {
        NSDictionary *dict = data[@"data"];
        
        
    } andFailBlock:^(NSURL *url, NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backClick:(id)sender {
}
@end
