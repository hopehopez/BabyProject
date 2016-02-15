//
//  RecommendModel.h
//  BabyProject
//
//  Created by 张树青 on 16/2/15.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import "JSONModel.h"

@interface RecommendModel : JSONModel
@property (nonatomic, copy) NSString <Optional> *count;
@property (nonatomic, strong) NSArray <Optional> *imagesArray;
@property (nonatomic, copy) NSString <Optional> *ID;
@property (nonatomic, copy) NSString <Optional> *name;
@property (nonatomic, copy) NSString <Optional> *type;
@end
