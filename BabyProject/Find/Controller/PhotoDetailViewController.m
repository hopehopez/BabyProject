//
//  PhotoDetailViewController.m
//  BabyProject
//
//  Created by 张树青 on 16/2/19.
//  Copyright © 2016年 zsq. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import "CommentCell.h"
@interface PhotoDetailViewController ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *_dataArray;
    
}

@end

@implementation PhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)setScrollV{
    //设置显示范围
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * _feedsArray.count, SCREEN_HEIGHT - 64 - 50);
    self.scrollView.contentOffset = CGPointMake(0, 0);
    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    self.scrollView.pagingEnabled = YES;
    
    self.scrollView.delegate = self;
    
    for (int i = 0; i < _feedsArray.count; i++) {
        UITableView *tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 50) style:UITableViewStyleGrouped];
        tv.delegate = self;
        tv.dataSource = self;
        
        UINib *feedNib = [UINib nibWithNibName:@"FeedCell" bundle:nil];
        [tv registerNib:feedNib forCellReuseIdentifier:@"FeedCell"];
        
        UINib *commentNib = [UINib nibWithNibName:@"CommentCell" bundle:nil];
        [tv registerNib:commentNib forCellReuseIdentifier:@"CommentCell"];
        
        [self.scrollView addSubview:tv];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger i = self.scrollView.contentOffset.x/SCREEN_WIDTH;
    
    NSArray *tvs = self.scrollView.subviews;
    
    UITableView *tv = tvs[i];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        NSArray *array = [_dataArray lastObject];
        return array.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        FeedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeedCell"];
        FeedModel *model = [_dataArray firstObject];
        cell.model = model;
        
        return cell;
    }else{
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
        return cell;
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
}
- (IBAction)sendBtn:(id)sender {
}
@end
