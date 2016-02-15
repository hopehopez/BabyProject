//
//  FindViewController.m
//  BabyProject
//
//  Created by 张树青 on 16/2/15.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import "FindViewController.h"
#import "ActivityModel.h"
#import "RecommendModel.h"
#import "ActivityCell.h"
#import "RecommendCell.h"
@interface FindViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor lightGrayColor];
    _dataArray = [NSMutableArray array];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self registCell];
    

    
    [self loadData];
    
}

#pragma mark - 创建头视图
- (void)createHeadView{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    ActivityModel *model = [_dataArray firstObject];
    
    if (model) {
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:headView.bounds];
        [imgV sd_setImageWithURL:[NSURL URLWithString:model.sampleImage] placeholderImage:nil options:SDWebImageRefreshCached];
        [headView addSubview:imgV];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 300)/2, 50, 300, 30)];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.font = [UIFont systemFontOfSize:24];
        nameLabel.text = model.name;
        [headView addSubview:nameLabel];
        
        UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100)/2, 100, 100, 20)];
        countLabel.backgroundColor = [UIColor whiteColor];
        countLabel.font = [UIFont systemFontOfSize:15];
        countLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.layer.cornerRadius = 10;
        nameLabel.layer.masksToBounds = YES;
        countLabel.text = [NSString stringWithFormat:@"%@%@", model.accomplishedTimes, @"人次参与"];
        [headView addSubview:countLabel];
    }
    
    self.tableView.tableHeaderView = headView;
}

#pragma mark - 注册cell
- (void)registCell{
    UINib *nib1 = [UINib nibWithNibName:@"ActivityCell" bundle:nil];
    [_tableView registerNib:nib1 forCellReuseIdentifier:@"ActivityCell"];
    
    UINib *nib2 = [UINib nibWithNibName:@"RecommendCell" bundle:nil];
    [_tableView registerNib:nib2 forCellReuseIdentifier:@"RecommendCell"];
}

#pragma mark - 下载数据
- (void)loadData{
    [BaseHttpClient httpType:GET andURL:FIND_SQUARE_URL andParameters:nil andSuccessBlock:^(NSURL *url, NSDictionary *data) {
        
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
        
        [self createHeadView];
        
    } andFailBlock:^(NSURL *url, NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

#pragma mark - data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = [_dataArray lastObject];
    if (array.count > 0) {
        return array.count + 1;
    }
    else{
        return 0;
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityCell"];
        ActivityModel *model = _dataArray[1];
        cell.lastActivityLabel.text = model.name;
        return cell;
    }else{
        RecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecommendCell"];
        RecommendModel *model = _dataArray[2][indexPath.row - 1];
        [cell setModel:model];
        return cell;
    }
    
}
#pragma mark - delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 50;
    }else{
        return (SCREEN_WIDTH - 12)/4 + 60;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
//    ActivityModel *model = [_dataArray firstObject];
//    
//    if (model) {
//        UIImageView *imgV = [[UIImageView alloc] initWithFrame:headView.bounds];
//        [imgV sd_setImageWithURL:[NSURL URLWithString:model.sampleImage] placeholderImage:nil options:SDWebImageRefreshCached];
//        [headView addSubview:imgV];
//        
//        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 300)/2, 50, 300, 30)];
//        nameLabel.backgroundColor = [UIColor clearColor];
//        nameLabel.textColor = [UIColor whiteColor];
//        nameLabel.textAlignment = NSTextAlignmentCenter;
//        nameLabel.font = [UIFont systemFontOfSize:24];
//        nameLabel.text = model.name;
//        [headView addSubview:nameLabel];
//        
//        UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 150)/2, 100, 150, 20)];
//        countLabel.backgroundColor = [UIColor whiteColor];
//        countLabel.font = [UIFont systemFontOfSize:15];
//        countLabel.textAlignment = NSTextAlignmentCenter;
//        nameLabel.layer.cornerRadius = 5;
//        countLabel.text = [NSString stringWithFormat:@"%@%@", model.accomplishedTimes, @"人次参与"];
//        [headView addSubview:countLabel];
//    }
//    
//    
//    return headView;
//}

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
