//
//  LikeTableViewCell.h
//  MyWeibo
//
//  Created by zn on 2018/11/17.
//  Copyright © 2018年 zn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class likeItem;
@interface LikeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UILabel *bio;

@property (nonatomic, strong) likeItem *singleLikeItem;

@end
