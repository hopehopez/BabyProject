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
    NSInteger _count;
}
@end

@implementation TopicActivityViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _page = 0;
    _dataArray = [NSMutableArray array];
    
    self.tv.delegate = self;
    self.tv.dataSource = self;
    
    
    
    self.tv.tableHeaderView = self.headView;
    
    self.headView.hidden = YES;
    //[self.headView removeFromSuperview];
    
    [self prepareView];
 
    [self registCell];
    
    [self loadData];
    
}

//填充头视图
- (void)prepareView{
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:self.model.sampleImage] placeholderImage:nil options:SDWebImageRefreshCached];
    self.nameLabel.text = self.model.name;
    //self.countLabel.text = [NSString stringWithFormat:@"%@%@", self.model.accomplishedTimes, @"人次参与"];
    self.descTxt.text = self.model.descriptionK;

}

#pragma mark - 注册cell
- (void)registCell{
    UINib *nib = [UINib nibWithNibName:@"FeedCell" bundle:nil];
    [self.tv registerNib:nib forCellReuseIdentifier:@"FeedCell"];
}

#pragma mark - 下载数据
- (void)loadData{
    NSString *url = [NSString stringWithFormat:FIND_LATEST_TOPICS, self.model.addonId, _page * NUMBER];
    [BaseHttpClient httpType:GET andURL:url andParameters:nil andSuccessBlock:^(NSURL *url, NSDictionary *data) {
        
        NSDictionary *dict = data[@"data"];
        self.countLabel.text = [NSString stringWithFormat:@"%@%@", dict[@"count"], @"人次参与"];
        NSArray *feedsArray = dict[@"feeds"];
        for (NSDictionary *dict1 in feedsArray) {
            NSDictionary *feedDict = dict1[@"feed"];
            FeedModel *model = [[FeedModel alloc] initWithDictionary:feedDict error:nil];
            model.hasFollowed = dict1[@"hasFollowed"];
            //model.likers = dict1[@"likes"];
            
            [_dataArray addObject:model];
        }
        
        [self.tv reloadData];
        
    } andFailBlock:^(NSURL *url, NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

#pragma mark - data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FeedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeedCell"];
    
    FeedModel *model = _dataArray[indexPath.row];
    [cell setModel:model];
    return cell;
}

#pragma mark delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 550;
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
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
