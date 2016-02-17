//
//  RecommendModel.m
//  BabyProject
//
//  Created by 张树青 on 16/2/15.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import "RecommendModel.h"

@implementation RecommendModel

+ (JSONKeyMapper *)keyMapper{
   return  [[JSONKeyMapper alloc ] initWithDictionary:@{@"ID":@"id"}];
}

@end
