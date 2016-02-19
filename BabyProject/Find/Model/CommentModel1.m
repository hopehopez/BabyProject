//
//  CommentModel.m
//  BabyProject
//
//  Created by 张树青 on 16/2/19.
//  Copyright © 2016年 zsq. All rights reserved.
//

#import "CommentModel1.h"

@implementation CommentModel1

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id": @"ID"}];
}

@end
