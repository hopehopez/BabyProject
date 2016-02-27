//
//  FeatureViewController.m
//  BabyProject
//
//  Created by 张树青 on 16/2/17.
//  Copyright (c) 2016年 zsq. All rights reserved.
//
#define NUMBER 20
#import "FeatureViewController.h"

@interface FeatureViewController ()<UITableViewDataSource, UITableViewDelegate, FeedCellDelegate>{
    NSMutableArray *_dataArray;
    NSInteger _page;
    NSInteger _count;
}


@end

@implementation FeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _page = 0;
    _dataArray = [NSMutableArray array];
    
    self.tv.delegate = self;
    self.tv.dataSource = self;
    
    
    [self registCell];
    
    [self addRefresh];
    
    [self loadData];
    
    
    
}
#pragma mark - 注册cell
- (void)registCell{
    UINib *nib = [UINib nibWithNibName:@"FeedCell" bundle:nil];
    [self.tv registerNib:nib forCellReuseIdentifier:@"FeedCell"];
}

#pragma mark - 添加刷新
- (void)addRefresh{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [_dataArray removeAllObjects];
        [self loadData];
        [self.tv.header endRefreshing];
    }];
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"正在刷新数据" forState:MJRefreshStateRefreshing];
    
    self.tv.header = header;
    [self.tv.header beginRefreshing];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page++;
        [self loadData];
        [self.tv.footer endRefreshing];
    }];
    self.tv.footer = footer;
}


#pragma mark - 下载数据
- (void)loadData{
     NSString *url = [NSString stringWithFormat:FEEDS_FEATURE, self.catagory, _page * NUMBER];
    [BaseHttpClient httpType:GET andURL:url andParameters:nil andSuccessBlock:^(NSURL *url, NSDictionary *data) {

        [self.tv.header endRefreshing];
        
        NSArray *feedsArray = data[@"data"];
        for (NSDictionary *dict1 in feedsArray) {
            NSDictionary *feedDict = dict1[@"feed"];
            FeedModel *model = [[FeedModel alloc] initWithDictionary:feedDict error:nil];
            NSDictionary *share = feedDict[@"share"];
            NSDictionary *shareUrls = share[@"urls"];
            ShareModel *shareModel = [[ShareModel alloc] initWithDictionary:shareUrls error:nil];
            shareModel.text = share[@"text"];
            shareModel.weiboText = share[@"weiboText"];
            model.share = shareModel;
            model.hasFollowed = dict1[@"hasFollowed"];

            
            model.hasFollowed = dict1[@"hasFollowed"];
            
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
    if (_dataArray.count>0) {
        FeedModel *model = _dataArray[indexPath.row];
        cell.jingImagV.hidden = NO;
        
        cell.row = indexPath.row;
        cell.controller = self;
        cell.model2 = model;
        [cell setModel:model];
        cell.delegate = self;
    }
    return cell;
    
}

#pragma mark delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_dataArray.count>0) {
        FeedModel *model = _dataArray[indexPath.row];
        NSString *str = model.addonTitles;
        CGSize size = [str boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 16, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
         return size.height + 150 + SCREEN_WIDTH;
    }
    return 550;
}


#pragma mark - FeedCell 的代理
- (void)addFollow:(FeedCell *)cell{
    
    
}
- (void)addGood:(FeedCell *)cell{
    
    
}

- (void)addComment:(FeedCell *)cell{
    
    PhotoDetailViewController *photoController = [[PhotoDetailViewController alloc] init];
    NSMutableArray *mArray = [_dataArray mutableCopy];
    
    photoController.feedsArray = mArray;
    photoController.index = cell.row;
    photoController.isComment = YES;
    
    [self.navigationController pushViewController:photoController animated:YES];
}

- (void)addShare:(FeedCell *)cell{
    
    
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

@end
