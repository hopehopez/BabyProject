//
//  SummaryModel.h
//  BabyProject
//
//  Created by 张树青 on 16/2/25.
//  Copyright © 2016年 zsq. All rights reserved.
//

#import "JSONModel.h"

@interface SummaryModel : JSONModel

@property (nonatomic, copy) NSString <Optional> *count;
@property (nonatomic, copy) NSString <Optional> *createDate;
@property (nonatomic, copy) NSString <Optional> *imageUrls;
@property (nonatomic, copy) NSString <Optional> *relationWithCreators;
@property (nonatomic, copy) NSString <Optional> *timeLine;
@property (nonatomic, copy) NSString <Optional> *type;
@end
