//
//  ShareModel.h
//  BabyProject
//
//  Created by 张树青 on 16/2/27.
//  Copyright © 2016年 zsq. All rights reserved.
//

#import "JSONModel.h"

@interface ShareModel : JSONModel
@property (nonatomic, copy) NSString <Optional> *QQ;
@property (nonatomic, copy) NSString <Optional> *QZONE;
@property (nonatomic, copy) NSString <Optional> *WECHAT_MOMENT;
@property (nonatomic, copy) NSString <Optional> *WEIBO;
@property (nonatomic, copy) NSString <Optional> *WEICHAT_CONTACT;
@property (nonatomic, copy) NSString <Optional> *text;
@property (nonatomic, copy) NSString <Optional> *weiboText;
@end
