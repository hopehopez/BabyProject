//
//  CommentModel.h
//  BabyProject
//
//  Created by 张树青 on 16/2/19.
//  Copyright © 2016年 zsq. All rights reserved.
//

#import "JSONModel.h"

@interface CommentModel1 : JSONModel

@property (nonatomic, copy) NSString <Optional> *cid;
@property (nonatomic, copy) NSString <Optional> *content;
@property (nonatomic, copy) NSString <Optional> *feedId;
@property (nonatomic, copy) NSString <Optional> *headPic;
@property (nonatomic, copy) NSString <Optional> *ID;
@property (nonatomic, copy) NSString <Optional> *nickName;
@property (nonatomic, copy) NSString <Optional> *publishDate;
@property (nonatomic, copy) NSString <Optional> *removed;
@property (nonatomic, copy) NSString <Optional> *replyNickName;
@property (nonatomic, copy) NSString <Optional> *uid;

@end
