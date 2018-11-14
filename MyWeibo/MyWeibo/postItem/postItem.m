//
//  postItem.m
//  MyWeibo
//
//  Created by zn on 2018/11/9.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "postItem.h"

@implementation postItem

-(instancetype)initWithDic:(NSDictionary *)dic{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+(instancetype)initPostItem:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}

@end
