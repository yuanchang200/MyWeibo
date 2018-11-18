//
//  DetailedBottomTableViewCell.h
//  MyWeibo
//
//  Created by zn on 2018/11/16.
//  Copyright © 2018年 zn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailedBottomTableViewCell : UITableViewCell
@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, strong) NSArray *reposts;
@property (nonatomic, strong) NSArray *likes;
@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, strong) UIButton* btn_repost;
@property (nonatomic, strong) UIButton* btn_comment;
@property (nonatomic, strong) UIButton* btn_like;
@property (nonatomic, strong) UIImageView* imageLine;
@property (nonatomic, strong) UITableView* table_repost;
@property (nonatomic, strong) UITableView* table_comment;
@property (nonatomic, strong) UITableView* table_like;
@end

