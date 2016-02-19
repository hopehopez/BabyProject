//
//  CommentModel.m
//  BabyProject
//
//  Created by 张树青 on 16/2/19.
//  Copyright © 2016年 zsq. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

+ (JSONKeyMapper *)keyMapper{
    return  [[JSONKeyMapper alloc ] initWithDictionary:@{@"ID":@"id"}];
}

@end
