//
//  commentItem.h
//  MyWeibo
//
//  Created by zn on 2018/11/14.
//  Copyright © 2018年 zn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface commentItem : NSObject

@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *likeNum;

-(instancetype)initWithDic:(NSDictionary *)dic;

+(instancetype)initCommentItem:(NSDictionary *)dic;

@end
