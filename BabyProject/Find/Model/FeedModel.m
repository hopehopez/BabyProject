//
//  FeedModel.m
//  BabyProject
//
//  Created by 张树青 on 16/2/16.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import "FeedModel.h"

@implementation FeedModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"ID": @"id"}];
}

@end
