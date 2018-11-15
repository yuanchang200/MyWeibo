//
//  TableViewTableViewController.h
//  MyWeibo
//
//  Created by zn on 2018/11/8.
//  Copyright © 2018年 zn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *homeTableView;
@property (nonatomic, strong) NSArray *posts;
@property (nonatomic, strong) NSArray *comments;
@end
