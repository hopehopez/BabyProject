//
//  TimerLineViewController.m
//  BabyProject
//
//  Created by 张树青 on 16/2/25.
//  Copyright © 2016年 zsq. All rights reserved.
//

#import "TimerLineViewController.h"
#import "TimerHeaderViewController.h"
#import "PhotoCell1.h"
#import "SummaryModel.h"
#define NUMBER 20
static NSInteger _page;
@interface TimerLineViewController ()<UITableViewDataSource, UITableViewDelegate>{

    NSMutableArray *_dataArray;
    TimerHeaderViewController *_headerController;
    
}

@end


@implementation TimerLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _page = 0;
    
    _dataArray = [NSMutableArray array];
    self.tv.delegate = self;
    self.tv.dataSource = self;
    
    [self setHeadView];
    
    [self registCell];
    
    [self addRefresh];
    
}

#pragma mark - 添加头视图
- (void)setHeadView{
    _headerController = [[TimerHeaderViewController alloc] init];
    _headerController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 232);
    self.tv.tableHeaderView = _headerController.view;
    //[self.view addSubview:_headerController.view];
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
        _page = 0;
        [self loadData];
        
    }];
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
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
    NSString *url1 = [NSString stringWithFormat:USER_INFO, self.model.creator];
    [BaseHttpClient httpType:GET andURL:url1 andParameters:nil andSuccessBlock:^(NSURL *url, NSDictionary *data) {
        
        [self.tv.header endRefreshing];

        NSDictionary *dict = data[@"data"]; 
        
        NSArray *babies = dict[@"babies"];
        NSDictionary *baby = babies[0];
        //宝宝昵称
        _headerController.babyNameLabel.text = baby[@"nickName"];
        //宝宝头像
        
        if (![baby[@"headPic"] isKindOfClass:[NSNull class]]) {
            [_headerController.babyImgV sd_setImageWithURL:[NSURL URLWithString:baby[@"headPic"]] placeholderImage:[UIImage imageNamed:@"default_baby"] options:SDWebImageRefreshCached];
        }
        
        
        NSDictionary *parent = dict[@"parent"];
        //用户昵称
        _headerController.userNameLabel.text = parent[@"nickName"];
        //用户头像
        [_headerController.userImgV sd_setImageWithURL:[NSURL URLWithString:parent[@"headPic"]] placeholderImage:[UIImage imageNamed:@"default_user"] options:SDWebImageRefreshCached];
        NSString *gender = [parent[@"gender"] stringValue];
        //称呼
        if ([gender isEqualToString:@"1"]) {
            _headerController.sexLabel.text = @"妈妈";
        }else{
            _headerController.sexLabel.text = @"爸爸";
        }
        
    } andFailBlock:^(NSURL *url, NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
    
    
    NSString *url2 = [NSString stringWithFormat:TIME_LINE_PHOTOS, self.model.babyId, _page * NUMBER];
    [BaseHttpClient httpType:GET andURL:url2 andParameters:nil andSuccessBlock:^(NSURL *url, NSDictionary *data) {
        
        [self.tv.header endRefreshing];
        
        NSArray *array = data[@"data"];
        
        for (NSDictionary *dict in array) {
            NSDictionary *dict1 = dict[@"data"];
            SummaryModel *model = [[SummaryModel alloc] initWithDictionary:dict1 error:nil];
            model.type = dict1[@"type"];
            model.timeLine = dict1[@"timeLine"];
            
            [_dataArray addObject:model];
        }
        
        [self.tv reloadData];
        
    } andFailBlock:^(NSURL *url, NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];

    
}
#pragma mark - tv data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_dataArray.count>0) {
        PhotoCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoCell1"];
        
        SummaryModel *model = _dataArray[indexPath.row];
        
        NSArray *urls = [model.imageUrls componentsSeparatedByString:@","];
        
        [cell.imgv1 sd_setImageWithURL:[NSURL URLWithString:urls[0]] placeholderImage:[UIImage imageNamed:@"default_feed"] options:SDWebImageRefreshCached];
        
        return cell;

    } else {
        return nil;
   }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 400;
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
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
