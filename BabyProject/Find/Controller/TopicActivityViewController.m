//
//  TopicActivityViewController.m
//  BabyProject
//
//  Created by 张树青 on 16/2/16.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#define NUMBER 18

#import "TopicActivityViewController.h"
#import "HeadCell.h"
#import "HeaderView.h"
@interface TopicActivityViewController ()<UITableViewDataSource, UITableViewDelegate, FeedCellDelegate, UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout>{
    NSMutableArray *_dataArray;
    NSInteger _page;
    NSInteger _count;
    
    UIView *_headView;
    UILabel *_countLabel;
    UIButton *_menuBtn;
    UIButton *_listBtn;
    
    UIView *_headView2;
    UILabel *_countLabel2;
    UIButton *_menuBtn2;
    UIButton *_listBtn2;
    
}
@end

@implementation TopicActivityViewController


- (void)viewWillAppear:(BOOL)animated{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _page = 0;
    
    _dataArray = [NSMutableArray array];
    
    self.tv.delegate = self;
    self.tv.dataSource = self;
    
    
    [self setHeadView];
    
    [self setHeadView2];
    
    [self registCell];
    
    self.tv.hidden = YES;
    //self.cv.hidden = YES;
    self.cv.backgroundColor = [UIColor clearColor];
    self.cv.delegate = self;
    self.cv.dataSource = self;
    

    [self addRefresh];
    
    [self loadData];
    
    
}

#pragma mart - 设置头视图
- (void)setHeadView{
    
    NSString *str = self.model.descriptionK;
    CGSize size = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 16, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    
    _headView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 280 + size.height)];
    _headView.backgroundColor = [UIColor clearColor];
    
    UIImageView *bg = [[UIImageView alloc] initWithFrame:_headView.bounds];
    bg.image = [UIImage imageNamed:@"cell_bg_h.png"];
    [_headView addSubview:bg];
    
    //图片
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170)];
    [imageView2 sd_setImageWithURL:[NSURL URLWithString: self.model.sampleImage]  placeholderImage:nil options:SDWebImageRefreshCached];
    [_headView addSubview:imageView2];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 175, 200, 21)];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.text = self.model.name;
    titleLabel.backgroundColor = [UIColor clearColor];
    [_headView addSubview:titleLabel];
    
    //亲密度
    UILabel *awardPoints = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 175, 72, 21)];
    awardPoints.font = [UIFont systemFontOfSize:12];
    awardPoints.textAlignment = NSTextAlignmentRight;
    awardPoints.textColor = [UIColor colorWithRed:252/255.0 green:71/255.0 blue:85/255.0 alpha:1];
    awardPoints.text = [NSString stringWithFormat:@"亲密度%@点", self.model.awardPoints];
    [_headView addSubview:awardPoints];
    
    //分割线
    UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(5, 200, SCREEN_WIDTH - 10, 1)];
    xian.backgroundColor = [UIColor lightGrayColor];
    [_headView addSubview:xian];
    
    //详情
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 205, SCREEN_WIDTH - 16, size.height + 20)];
    detailLabel.font = [UIFont systemFontOfSize:15];
    detailLabel.textColor = [UIColor lightGrayColor];
    detailLabel.backgroundColor = [UIColor clearColor];
    detailLabel.text = self.model.descriptionK;
    detailLabel.numberOfLines = 0;
    [_headView addSubview:detailLabel];
    
    //记录条数
    _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, CGRectGetMaxY(detailLabel.frame) + 10, SCREEN_WIDTH - 16, 40)];
    _countLabel.backgroundColor = [UIColor whiteColor];
    _countLabel.font = [UIFont systemFontOfSize:15];
    _countLabel.textColor = [UIColor lightGrayColor];
    [_headView addSubview:_countLabel];
    
    //显示样式控制按钮
    _menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 13 - 20, CGRectGetMaxY(detailLabel.frame) + 20, 30, 30)];
    [_menuBtn setImage:[UIImage imageNamed:@"btn_menu_n"] forState:UIControlStateNormal];
    [_menuBtn setImage:[UIImage imageNamed:@"btn_menu_h"] forState:UIControlStateSelected];
    [_menuBtn addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
    _menuBtn.selected = YES;
    [_headView addSubview:_menuBtn];
    
    _listBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 13 - 20 - 8 - 20, CGRectGetMaxY(detailLabel.frame) + 20, 30, 30)];
    [_listBtn setImage:[UIImage imageNamed:@"btn_list_n"] forState:UIControlStateNormal];
    [_listBtn setImage:[UIImage imageNamed:@"btn_list_h"] forState:UIControlStateSelected];
    [_listBtn addTarget:self action:@selector(showList:) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:_listBtn];
    
    
}

- (void)setHeadView2{
    
    NSString *str = self.model.descriptionK;
    CGSize size = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 16, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    
    _headView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 280 + size.height)];
    _headView2.backgroundColor = [UIColor clearColor];
    
    UIImageView *bg = [[UIImageView alloc] initWithFrame:_headView2.bounds];
    bg.image = [UIImage imageNamed:@"cell_bg_h.png"];
    [_headView2 addSubview:bg];
    
    //图片
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170)];
    [imageView2 sd_setImageWithURL:[NSURL URLWithString: self.model.sampleImage]  placeholderImage:nil options:SDWebImageRefreshCached];
    [_headView2 addSubview:imageView2];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 175, 200, 21)];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.text = self.model.name;
    titleLabel.backgroundColor = [UIColor clearColor];
    [_headView2 addSubview:titleLabel];
    
    //亲密度
    UILabel *awardPoints = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 175, 72, 21)];
    awardPoints.font = [UIFont systemFontOfSize:12];
    awardPoints.textAlignment = NSTextAlignmentRight;
    awardPoints.textColor = [UIColor colorWithRed:252/255.0 green:71/255.0 blue:85/255.0 alpha:1];
    awardPoints.text = [NSString stringWithFormat:@"亲密度%@点", self.model.awardPoints];
    [_headView2 addSubview:awardPoints];
    
    //分割线
    UILabel *xian = [[UILabel alloc] initWithFrame:CGRectMake(5, 200, SCREEN_WIDTH - 10, 1)];
    xian.backgroundColor = [UIColor lightGrayColor];
    [_headView2 addSubview:xian];
    
    //详情
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 205, SCREEN_WIDTH - 16, size.height + 20)];
    detailLabel.font = [UIFont systemFontOfSize:15];
    detailLabel.textColor = [UIColor lightGrayColor];
    detailLabel.backgroundColor = [UIColor clearColor];
    detailLabel.text = self.model.descriptionK;
    detailLabel.numberOfLines = 0;
    [_headView2 addSubview:detailLabel];
    
    //记录条数
    _countLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(8, CGRectGetMaxY(detailLabel.frame) + 10, SCREEN_WIDTH - 16, 40)];
    _countLabel2.backgroundColor = [UIColor whiteColor];
    _countLabel2.font = [UIFont systemFontOfSize:15];
    _countLabel2.textColor = [UIColor lightGrayColor];
    [_headView2 addSubview:_countLabel2];
    
    //显示样式控制按钮
    _menuBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 13 - 20, CGRectGetMaxY(detailLabel.frame) + 20, 30, 30)];
    [_menuBtn2 setImage:[UIImage imageNamed:@"btn_menu_n.png"] forState:UIControlStateNormal];
    [_menuBtn2 setImage:[UIImage imageNamed:@"btn_menu_h.png"] forState:UIControlStateSelected];
    [_menuBtn2 addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
    _menuBtn2.selected = YES;
    [_headView2 addSubview:_menuBtn2];
    
    _listBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 13 - 20 - 8 - 20, CGRectGetMaxY(detailLabel.frame) + 20, 30, 30)];
    [_listBtn2 setImage:[UIImage imageNamed:@"btn_list_n.png"] forState:UIControlStateNormal];
    [_listBtn2 setImage:[UIImage imageNamed:@"btn_list_h.png"] forState:UIControlStateSelected];
    [_listBtn2 addTarget:self action:@selector(showList:) forControlEvents:UIControlEventTouchUpInside];
    [_headView2 addSubview:_listBtn2];
    
    self.tv.tableHeaderView = _headView2;
    
  }


#pragma mark - 切换视图
- (void)showMenu:(UIButton *)sender{
    
    
    _menuBtn.selected = YES;
    _listBtn.selected = NO;
    self.tv.hidden = YES;
    self.cv.hidden = NO;
    
}

- (void)showList:(UIButton *)sender{
    
    _menuBtn.selected = NO;
    _listBtn.selected = YES;
    self.tv.hidden = NO;
    self.cv.hidden = YES;
    
}


#pragma mark - 注册cell
- (void)registCell{
    UINib *nib = [UINib nibWithNibName:@"FeedCell" bundle:nil];
    [self.tv registerNib:nib forCellReuseIdentifier:@"FeedCell"];
    
    UINib *iconNib = [UINib nibWithNibName:@"IconCell" bundle:nil];
    [self.cv registerNib:iconNib forCellWithReuseIdentifier:@"IconCell"];
    
    
    [self.cv registerNib: [UINib nibWithNibName:@"HeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeadView"];
}

#pragma mark - 添加刷新
- (void)addRefresh{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [_dataArray removeAllObjects];
        [self loadData];
        [self.tv.header endRefreshing];
    }];
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"快松手 要刷新啦" forState:MJRefreshStateRefreshing];
    
    self.tv.header = header;
    self.cv.header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page++;
        [self loadData];
        [self.tv.footer endRefreshing];
    }];
    self.tv.footer = footer;
    self.cv.footer = footer;
}

//  返回头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    //如果是头视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        HeaderView *header=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeadView" forIndexPath:indexPath];

        //头视图添加view
        [header addSubview:_headView];
        return header;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    NSString *str = self.model.descriptionK;
    CGSize size = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 16, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;

    return CGSizeMake(SCREEN_WIDTH, 280 + size.height);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    IconCell *cell = (IconCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"IconCell" forIndexPath:indexPath];
    
    FeedModel *model = _dataArray[indexPath.row];
    
    [cell.imgV sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"default_feed"] options:SDWebImageRefreshCached];
    
    return cell; 
}

#pragma mark - 下载数据
- (void)loadData{
    NSString *url = [NSString stringWithFormat:FIND_LATEST_TOPICS, self.model.addonId, _page * NUMBER];
    [BaseHttpClient httpType:GET andURL:url andParameters:nil andSuccessBlock:^(NSURL *url, NSDictionary *data) {
        
        
        NSDictionary *dict = data[@"data"];
        
        NSNumber *countNum = dict[@"count"];
        
        _countLabel.text = [NSString stringWithFormat:@" %@条记录", countNum];
        _countLabel2.text = [NSString stringWithFormat:@" %@条记录", countNum];
        
        NSArray *feedsArray = dict[@"feeds"];
        for (NSDictionary *dict1 in feedsArray) {
            NSDictionary *feedDict = dict1[@"feed"];
            FeedModel *model = [[FeedModel alloc] initWithDictionary:feedDict error:nil];
            model.hasFollowed = dict1[@"hasFollowed"];
            
            [_dataArray addObject:model];
        }
        
        [self.tv reloadData];
        [self.cv reloadData];
        
    } andFailBlock:^(NSURL *url, NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

#pragma mark - tv data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FeedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeedCell"];
    FeedModel *model = _dataArray[indexPath.row];
    cell.row = indexPath.row;
    cell.delegate = self;
    [cell setModel:model];
    return cell;
}

#pragma mark - tv delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FeedModel *model = _dataArray[indexPath.row];
    NSString *str = model.addonTitles;
    CGSize size = [str boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 16, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    return size.height + 150 + SCREEN_WIDTH;
    
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

- (IBAction)backClick:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
//立即参加
- (IBAction)joinClick:(id)sender {
    
    CameraViewController *cameraController = [[CameraViewController alloc] init];
    [self.tabBarController presentViewController:cameraController animated:YES completion:nil];
    
}
@end
