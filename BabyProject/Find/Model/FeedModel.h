//
//  FeedModel.h
//  BabyProject
//
//  Created by 张树青 on 16/2/16.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import "JSONModel.h"
#import "ShareModel.h"

@interface FeedModel : JSONModel
@property (nonatomic, copy) NSString <Optional> *addons;
@property (nonatomic, copy) NSString <Optional> *addonTitles;
@property (nonatomic, copy) NSString <Optional> *babyBirthday;
@property (nonatomic, copy) NSString <Optional> *babyGender;
@property (nonatomic, copy) NSString <Optional> *babyId;
@property (nonatomic, copy) NSString <Optional> *babyNickName;
@property (nonatomic, copy) NSString <Optional> *batchImageFeed;
@property (nonatomic, copy) NSString <Optional> *batchWay;
@property (nonatomic, copy) NSString <Optional> *city;
@property (nonatomic, copy) NSString <Optional> *commentCount;
@property (nonatomic, copy) NSString <Optional> *content;
@property (nonatomic, copy) NSString <Optional> *createDate;
@property (nonatomic, copy) NSString <Optional> *creator;
@property (nonatomic, copy) NSString <Optional> *creatorDescription;
@property (nonatomic, copy) NSString <Optional> *creatorHeadPic;
@property (nonatomic, copy) NSString <Optional> *creatorNickName;
@property (nonatomic, copy) NSString <Optional> *expert;
@property (nonatomic, copy) NSString <Optional> *gpsPoint;
@property (nonatomic, copy) NSString <Optional> *ID;
@property (nonatomic, copy) NSString <Optional> *imageFeed;
@property (nonatomic, copy) NSString <Optional> *imageUrl;
@property (nonatomic, copy) NSString <Optional> *likeCount;
@property (nonatomic, copy) NSString <Optional> *liked;
@property (nonatomic, copy) NSString <Optional> *photoTime;
@property (nonatomic, copy) NSString <Optional> *region;
@property (nonatomic, copy) NSString <Optional> *relationWithCreator;
@property (nonatomic, copy) NSString <Optional> *removed;
@property (nonatomic, copy) NSString <Optional> *secured;
//@property (nonatomic, copy) NSString <Optional> *share;
@property (nonatomic, copy) NSString <Optional> *state;
@property (nonatomic, copy) NSString <Optional> *tags;
@property (nonatomic, copy) NSString <Optional> *taskAwardPoints;
@property (nonatomic, copy) NSString <Optional> *taskFeed;
@property (nonatomic, copy) NSString <Optional> *taskId;
@property (nonatomic, copy) NSString <Optional> *taskStatus;
@property (nonatomic, copy) NSString <Optional> *vaccineFeed;
@property (nonatomic, copy) NSString <Optional> *weightHeightFeed;
@property (nonatomic, copy) NSString <Optional> *hasFollowed;
//@property (nonatomic, copy) NSString <Optional> *likers;

@property (nonatomic, strong) ShareModel *share;

@end
