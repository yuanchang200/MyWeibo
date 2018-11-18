//
//  likeItem.h
//  MyWeibo
//
//  Created by zn on 2018/11/17.
//  Copyright © 2018年 zn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface likeItem : NSObject
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *bio;
@property (nonatomic,copy) NSString *nickname;

-(instancetype)initWithDic:(NSDictionary *)dic;

+(instancetype)initLikeItem:(NSDictionary *)dic;

@end
