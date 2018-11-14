//
//  postItem.h
//  MyWeibo
//
//  Created by zn on 2018/11/9.
//  Copyright © 2018年 zn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface postItem : NSObject

@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *headImg;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSArray *postImgs;
@property (nonatomic,copy) NSString *repostNum;
@property (nonatomic,copy) NSString *commentNum;
@property (nonatomic,copy) NSString *likeNum;

-(instancetype)initWithDic:(NSDictionary *)dic;

+(instancetype)initPostItem:(NSDictionary *)dic;

@end
