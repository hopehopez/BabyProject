//
//  PastTopicsViewController.m
//  BabyProject
//
//  Created by 张树青 on 16/2/16.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import "PastTopicsViewController.h"
#import "TopicCell.h"
@interface PastTopicsViewController ()<UITableViewDataSource, UITableViewDelegate>{
    NSInteger _page;
    NSMutableArray *_dataArray;
}

@end

@implementation PastTopicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBar.hidden = self;
    
    self.tabView.delegate = self;
    self.tabView.dataSource = self;
    
    _page = 0;
    _dataArray = [NSMutableArray array];
    
    [self registCell];
    
    [self loadData];
    
    [self addRefresh];
}

#pragma mark - 注册cell
- (void)registCell{
    UINib *nib = [UINib nibWithNibName:@"TopicCell" bundle:nil];
    [self.tabView registerNib:nib forCellReuseIdentifier:@"TopicCell"];
}

#pragma mark - 添加刷新
- (void)addRefresh{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [_dataArray removeAllObjects];
        [self loadData];
        [self.tabView.header endRefreshing];
    }];
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"快松手 要刷新啦" forState:MJRefreshStateRefreshing];
    
    self.tabView.header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page++;
        [self loadData];
        [self.tabView.footer endRefreshing];
    }];
    self.tabView.footer = footer;
}

#pragma mark - 下载数据
- (void)loadData{
    
    NSString *url = [NSString stringWithFormat:FIND_TOPICS, _page];
    
    [BaseHttpClient httpType:GET andURL:url andParameters:nil andSuccessBlock:^(NSURL *url, NSDictionary *data) {
        
        NSArray *array = data[@"data"];
        for (NSDictionary *dict in array) {
            ActivityModel *model = [[ActivityModel alloc] initWithDictionary:dict error:nil];
            [_dataArray addObject:model];
        }
        
        [self.tabView reloadData];
    } andFailBlock:^(NSURL *url, NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopicCell"];
    ActivityModel *model = _dataArray[indexPath.row];
    [cell.imgV sd_setImageWithURL:[NSURL URLWithString:model.sampleImage ] placeholderImage:nil options:SDWebImageRefreshCached];
    cell.nameLabel.text = model.name;
    cell.countLabel.text = [NSString stringWithFormat:@"%@%@", model.accomplishedTimes, @"人次参与"];
    return cell;

}

#pragma mark -delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
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
