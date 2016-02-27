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

static NSInteger k = 1;

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
    
    [self setScrollV];
    
    //注册键盘监听
    [self keyBoardNotifications];
    
    if (self.isComment) {
       [self.commentTxt becomeFirstResponder];
    }

    
    
    //设置初始页 数据
    self.titleLabel.text = [NSString stringWithFormat:@"照片详情%ld/%ld", _index + 1, _feedsArray.count ];
    FeedModel *model = _feedsArray[_index];
    
    NSString *URL = [NSString stringWithFormat:PHOTO_COMMENTS, model.ID, _page];
    [self loadDataWithURl:URL];
    
}

#pragma mark - 设置scrollView
- (void)setScrollV{
    
    //设置显示范围
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * _feedsArray.count,0);
    self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH * _index, 0);
    
    self.scrollView.showsHorizontalScrollIndicator = NO;;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = YES;
    
    self.scrollView.delegate = self;
    
    for (int i = 0; i < _feedsArray.count; i++) {
        UITableView *tv = [[UITableView alloc] initWithFrame:CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT  - 50 -64) style:UITableViewStyleGrouped];
        
        tv.delegate = self;
        tv.dataSource = self;

        //注册cell
        UINib *feedNib = [UINib nibWithNibName:@"FeedCell" bundle:nil];
        [tv registerNib:feedNib forCellReuseIdentifier:@"FeedCell"];
        
        UINib *commentNib = [UINib nibWithNibName:@"CommentCell" bundle:nil];
        [tv registerNib:commentNib forCellReuseIdentifier:@"CommentCell"];
        
        [self.scrollView addSubview:tv];
        
        [tv reloadData];
    }
}
#pragma mark - scrollView 代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
     NSInteger i = (self.scrollView.contentOffset.x + SCREEN_WIDTH/2 )/SCREEN_WIDTH;
     self.titleLabel.text = [NSString stringWithFormat:@"照片详情%ld/%ld", i+1, _feedsArray.count ];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger i = self.scrollView.contentOffset.x/SCREEN_WIDTH;
    
    //页面滑动时刷新数据
    FeedModel *model = _feedsArray[i];
    NSString *URL = [NSString stringWithFormat:PHOTO_COMMENTS, model.ID, _page];
    [self loadDataWithURl:URL];
}

#pragma mark - loadData
- (void)loadDataWithURl:(NSString *)url{
   
    [BaseHttpClient httpType:GET andURL:url andParameters:nil andSuccessBlock:^(NSURL *url, NSDictionary *data) {
        
        NSArray *dataArray = data[@"data"];
        //请dataArray 数据清空
        [_dataArray removeAllObjects];
        for (NSDictionary *dict in dataArray) {
            CommentModel1 *model = [[CommentModel1 alloc] initWithDictionary:dict error:nil];
            [_dataArray addObject:model];
        }
        
        NSInteger i = self.scrollView.contentOffset.x/SCREEN_WIDTH;
        NSArray *tvs = self.scrollView.subviews;
        UITableView *tv = tvs[i];
        //局部刷新评论
        [tv reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        
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
    
    //设置只在初始进入页面时执行

    if (indexPath.section == 0) {
        FeedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeedCell"];
        if (k<=_feedsArray.count){
            cell.model = _feedsArray[_feedsArray.count-k];
            cell.model2 = _feedsArray[_feedsArray.count-k];
            cell.row = indexPath.row;
            cell.controller = self;
        }
        k++;
        
       
        
        return cell;
    }else{
        
       CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
       cell.model = _dataArray[indexPath.row];
       return cell;
    }
}

#pragma mark - delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //分别动态计算cell的高度
    if (indexPath.section == 0) {
        FeedModel *model = self.feedsArray[_index];
        NSString *str = model.addonTitles;
        CGSize size = [str boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 16, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
         return size.height + 150 + SCREEN_WIDTH;

    }else {
        CommentModel1 *model = _dataArray[indexPath.row];
        NSString *str = model.content;
        CGSize size = [str boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 80, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        return size.height + 65;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

#pragma mark - 监听键盘的通知
- (void)keyBoardNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyBoardWillShow:(NSNotification *)noti{
    //获得键盘弹起时间
    float time = [[noti.userInfo objectForKey:@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    //获得键盘弹起高度
    float height = [[noti.userInfo objectForKey:@"UIKeyboardBoundsUserInfoKey"] CGRectValue].size.height;
    [UIView animateWithDuration:time animations:^{
        self.viewContraint.constant = height;
        //重新渲染
        [self.view layoutIfNeeded];
    }];
}
- (void)keyBoardWillHide:(NSNotification *)noti{
    float time = [[noti.userInfo objectForKey:@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    
    [UIView animateWithDuration:time animations:^{
        self.viewContraint.constant = 0;
        [self.view layoutIfNeeded];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated{
    k = 1;
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
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)sendBtn:(id)sender {
}
@end
