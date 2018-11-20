//
//  DetailedViewController.h
//  MyWeibo
//
//  Created by zn on 2018/11/20.
//  Copyright © 2018年 zn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "postItem.h"
#import "commentItem.h"


@interface DetailedViewController : UIViewController
@property (nonatomic, strong) postItem *post;
@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, strong) NSArray *reposts;
@property (nonatomic, strong) NSArray *likes;

@property (nonatomic, strong) UIScrollView *outerScrollView;
@property (nonatomic, strong) UIView *detailPostView;

@property (nonatomic, strong) UIView *detailCommentView;
@property (nonatomic, strong) UIScrollView* bottomScrollView;
@property (nonatomic, strong) UIButton* btn_repost;
@property (nonatomic, strong) UIButton* btn_comment;
@property (nonatomic, strong) UIButton* btn_like;
@property (nonatomic, strong) UIImageView* imageLine;
@property (nonatomic, strong) UITableView* table_repost;
@property (nonatomic, strong) UITableView* table_comment;
@property (nonatomic, strong) UITableView* table_like;
@property (nonatomic, strong) UIView* view_comment;
@property (nonatomic, strong) UIView* view_repost;
@property (nonatomic, strong) UIView* view_like;
@property (nonatomic, strong) UILabel* label_comment;

@end
