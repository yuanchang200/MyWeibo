//
//  DetailTableViewController.h
//  MyWeibo
//
//  Created by zn on 2018/11/14.
//  Copyright © 2018年 zn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "postItem.h"
#import "commentItem.h"

@interface DetailTableViewController : UITableViewController

@property (nonatomic, strong) postItem *post;
@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, strong) NSArray *reposts;
@property (nonatomic, strong) NSArray *likes;

@end
