//
//  TimerLineViewController.m
//  BabyProject
//
//  Created by 张树青 on 16/2/25.
//  Copyright © 2016年 zsq. All rights reserved.
//

#import "TimerLineViewController.h"
#import "PhotoCell1.h"
@interface TimerLineViewController ()<UITableViewDataSource, UITableViewDelegate>{

    NSMutableArray *_dataArray;
    
}

@end

@implementation TimerLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tv.delegate = self;
    self.tv.dataSource = self;
    
    
}

#pragma mark - 注册cell
- (void)registCell{
    
    UINib *nib1 = [UINib nibWithNibName:@"PhotoCell1" bundle:nil];
    [self.tv registerNib:nib1 forCellReuseIdentifier:@"PhotoCell1"];
}


#pragma mark - 添加刷新
- (void)addRefresh{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [_dataArray removeAllObjects];
        [self loadData];
        [self.tv.header endRefreshing];
    }];
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
    
    self.tv.header = header;
    
    [self.tv.header beginRefreshing];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadData];
        [self.tv.footer endRefreshing];
    }];
    
    self.tv.footer = footer;

}


#pragma mark - 下载数据
- (void)loadData{
//    NSString *url = [NSString stringWithFormat:FIND_TAG_FEEDS, self.ID, _page * NUMBER];
//    [BaseHttpClient httpType:GET andURL:url andParameters:nil andSuccessBlock:^(NSURL *url, NSDictionary *data) {
//        
//        [self.tv.header endRefreshing];
//
//        
//        
//        [self.tv reloadData];
//
//        
//    } andFailBlock:^(NSURL *url, NSError *error) {
//        NSLog(@"%@", error.localizedDescription);
//    }];
}
#pragma mark - tv data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PhotoCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoCell"];
    
    return cell;
    
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
