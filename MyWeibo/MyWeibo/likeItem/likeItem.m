//
//  likeItem.m
//  MyWeibo
//
//  Created by zn on 2018/11/17.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "likeItem.h"

@implementation likeItem

-(instancetype)initWithDic:(NSDictionary *)dic{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+(instancetype)initLikeItem:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}

@end
