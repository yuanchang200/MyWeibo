//
//  commentItem.m
//  MyWeibo
//
//  Created by zn on 2018/11/14.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "commentItem.h"

@implementation commentItem

-(instancetype)initWithDic:(NSDictionary *)dic{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+(instancetype)initCommentItem:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}

@end
