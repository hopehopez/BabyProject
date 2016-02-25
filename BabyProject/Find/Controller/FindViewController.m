//
//  FindViewController.m
//  BabyProject
//
//  Created by 张树青 on 16/2/15.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import "FindViewController.h"
#import "RecommendModel.h"
#import "ActivityCell.h"
#import "RecommendCell.h"
#import "TopicCell.h"
#import "PastTopicsViewController.h"
#import "TopicActivityViewController.h"
#import "TagFeedsViewController.h"
@interface FindViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    LoginViewController *loginView = [[LoginViewController alloc] init];
//    
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginView];
//    [self presentViewController:nav animated:YES completion:nil];

    
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor lightGrayColor];
    _dataArray = [NSMutableArray array];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self registCell];
    
    //[self loadData];
    
    [self addRefresh];
}

#pragma mark - 添加刷新
- (void)addRefresh{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
        [_tableView.header endRefreshing];
    }];
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
    
    _tableView.header = header;
    
    [_tableView.header beginRefreshing];
}

#pragma mark - 注册cell
- (void)registCell{
    UINib *nib = [UINib nibWithNibName:@"TopicCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"TopicCell"];
    
    UINib *nib1 = [UINib nibWithNibName:@"ActivityCell" bundle:nil];
    [_tableView registerNib:nib1 forCellReuseIdentifier:@"ActivityCell"];
    
    UINib *nib2 = [UINib nibWithNibName:@"RecommendCell" bundle:nil];
    [_tableView registerNib:nib2 forCellReuseIdentifier:@"RecommendCell"];
}

#pragma mark - 下载数据
- (void)loadData{
    [BaseHttpClient httpType:GET andURL:FIND_SQUARE_URL andParameters:nil andSuccessBlock:^(NSURL *url, NSDictionary *data) {
        
        [_tableView.header endRefreshing];
        
        NSDictionary *data2 = data[@"data"];
        
        //最新主题
        NSDictionary *latestActivityDict = data2[@"latestActivity"];
        ActivityModel *latestActivityModel = [[ActivityModel alloc] initWithDictionary:latestActivityDict error:nil];
        [_dataArray addObject:latestActivityModel];
        
        //往期主题
        NSDictionary *lastActivityDict = data2[@"lastActivity"];
        ActivityModel *lastActivityModel = [[ActivityModel alloc] initWithDictionary:lastActivityDict error:nil];
        [_dataArray addObject:lastActivityModel];
        
        //推荐
        NSMutableArray *mArray = [NSMutableArray array];
        NSArray *array = data2[@"recommendTagFeeds"];
        for (NSDictionary *dict in array){
            
            NSString *count = dict[@"count"];
            NSString *imageUrls = dict[@"imageUrls"];
            NSArray *imagesArray = [imageUrls componentsSeparatedByString:@","];
            NSDictionary *tagDict = dict[@"tag"];
            
            NSDictionary *recommendDict = @{@"count":count,
                                            @"imagesArray":imagesArray,
                                            @"ID":tagDict[@"id"],
                                            @"name":tagDict[@"name"],
                                            @"type":tagDict[@"type"]};
            
            RecommendModel *recommentModel = [[RecommendModel alloc] initWithDictionary:recommendDict error:nil];
            [mArray addObject:recommentModel];
            
        }
        [_dataArray addObject:mArray];
        
        [self.tableView reloadData];
        
        
    } andFailBlock:^(NSURL *url, NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

#pragma mark - data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = [_dataArray lastObject];
    if (array.count > 0) {
        return array.count + 2;
    }
    else{
        return 0;
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        TopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TopicCell"];
        ActivityModel *model = _dataArray[0];
        [cell.imgV sd_setImageWithURL:[NSURL URLWithString:model.sampleImage ] placeholderImage:nil options:SDWebImageRefreshCached];
        cell.nameLabel.text = model.name;
        cell.countLabel.text = [NSString stringWithFormat:@"%@%@", model.accomplishedTimes, @"人次参与"];
        return cell;
    }else if (indexPath.row == 1) {
        ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityCell"];
        ActivityModel *model = _dataArray[1];
        cell.lastActivityLabel.text = model.name;
        return cell;
    }else{
        RecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecommendCell"];
        RecommendModel *model = _dataArray[2][indexPath.row - 2];
        
        [cell setModel:model];
        return cell;
    }
    
}
#pragma mark - delegate
//返回cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 170;
    }
    if (indexPath.row == 1) {
        return 50;
    }else{
        return (SCREEN_WIDTH - 12)/4 + 65;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        TopicActivityViewController *topicController = [[TopicActivityViewController alloc] init];
        topicController.hidesBottomBarWhenPushed = YES;
        topicController.model = _dataArray[0];
        [self.navigationController pushViewController:topicController animated:YES];
    }else if (indexPath.row == 1){
        PastTopicsViewController *pastController = [[PastTopicsViewController alloc] init];
        pastController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:pastController animated:YES];
    }else{
        TagFeedsViewController *feedsController = [[TagFeedsViewController alloc] init];
        RecommendModel *model = _dataArray[2][indexPath.row - 2];
        feedsController.ID = model.ID;
        feedsController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:feedsController animated:YES];
    }
    
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

- (IBAction)SegmentChange:(UISegmentedControl *)sender {
}
@end
