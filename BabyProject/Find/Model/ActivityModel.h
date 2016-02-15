//
//  ActivityModel.h
//  BabyProject
//
//  Created by 张树青 on 16/2/15.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import "JSONModel.h"

@interface ActivityModel : JSONModel
@property (nonatomic, copy) NSString <Optional> *accomplishedTimes;
@property (nonatomic, copy) NSString <Optional> *addonId;
@property (nonatomic, copy) NSString <Optional> *awardPoints;
@property (nonatomic, copy) NSString <Optional> *category;
@property (nonatomic, copy) NSString <Optional> *descriptionK;
@property (nonatomic, copy) NSString <Optional> *ID;
@property (nonatomic, copy) NSString <Optional> *name;
@property (nonatomic, copy) NSString <Optional> *sampleImage;
@end
