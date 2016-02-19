//
//  PhotoDetailViewController.m
//  BabyProject
//
//  Created by 张树青 on 16/2/19.
//  Copyright © 2016年 zsq. All rights reserved.
//

#define NUMBER 20

#import "PhotoDetailViewController.h"
#import "CommentCell.h"
#import "CommentModel1.h"
@interface PhotoDetailViewController ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *_dataArray;
    NSInteger _page;
}

@end

@implementation PhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _page = 0;
    
    _dataArray = [NSMutableArray array];
    
    FeedModel *model = _feedsArray[0];
    
    NSString *URL = [NSString stringWithFormat:PHOTO_COMMENTS, model.ID, _page];
    
    [self loadDataWithURl:URL];
    
    [self setScrollV];
    
}

- (void)setScrollV{
    
    //设置显示范围
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * _feedsArray.count, SCREEN_HEIGHT - 64 - 50);
    self.scrollView.contentOffset = CGPointMake(0, 0);
    
    self.scrollView.showsHorizontalScrollIndicator = YES;;
    self.scrollView.showsVerticalScrollIndicator = YES;
    
    self.scrollView.pagingEnabled = YES;
    
    self.scrollView.delegate = self;
    
    for (int i = 0; i < _feedsArray.count; i++) {
        UITableView *tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT  - 50) style:UITableViewStyleGrouped];
        tv.delegate = self;
        tv.dataSource = self;
        
        UINib *feedNib = [UINib nibWithNibName:@"FeedCell" bundle:nil];
        [tv registerNib:feedNib forCellReuseIdentifier:@"FeedCell"];
        
        UINib *commentNib = [UINib nibWithNibName:@"CommentCell" bundle:nil];
        [tv registerNib:commentNib forCellReuseIdentifier:@"CommentCell"];
        
        [self.scrollView addSubview:tv];
    }
}
#pragma mark - scrollView 代理
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
//    NSInteger i = self.scrollView.contentOffset.x/SCREEN_WIDTH;
//    
//    self.titleLabel.text = [NSString stringWithFormat:@"照片详情%ld/%ld", i+1, _feedsArray.count ];
//    
//    FeedModel *model = _feedsArray[i];
//    
//    NSString *URL = [NSString stringWithFormat:PHOTO_COMMENTS, model.ID, _page];
//    
//    [self loadDataWithURl:URL];
    
}

#pragma mark - loadData
- (void)loadDataWithURl:(NSString *)url{
   
    [BaseHttpClient httpType:GET andURL:url andParameters:nil andSuccessBlock:^(NSURL *url, NSDictionary *data) {
        
        NSArray *dataArray = data[@"data"];
        
        //[_dataArray removeAllObjects];
        
        for (NSDictionary *dict in dataArray) {
            
            NSError *error = nil;
            
            CommentModel1 *model = [[CommentModel1 alloc] initWithDictionary:dict error:&error];
            
            
            model.headPic = dict[@"headPic"];
            if (error) {
                NSLog(@"%@", error);
            }
            
            [_dataArray addObject:model];
            
        }
        
        NSInteger i = self.scrollView.contentOffset.x/SCREEN_WIDTH;
        
        NSArray *tvs = self.scrollView.subviews;
        
        UITableView *tv = tvs[i];
        
        [tv reloadData];
        
        
    } andFailBlock:^(NSURL *url, NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
    

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else{
        return _dataArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        FeedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeedCell"];
        
        cell.model = self.feedsArray[_index];
        
        return cell;
    }else{
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
        
       cell.model = _dataArray[indexPath.row];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        FeedModel *model = self.feedsArray[_index];

        NSString *str = model.addonTitles;
        CGSize size = [str boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 16, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        return size.height + 520;

    }else {
        
        CommentModel1 *model = _dataArray[indexPath.row];
        
        NSString *str = model.content;
        CGSize size = [str boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 80, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        return size.height + 50;
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

- (IBAction)backBtn:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
- (IBAction)sendBtn:(id)sender {
}
@end
