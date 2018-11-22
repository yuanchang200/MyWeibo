//
//  TableCellTableViewCell.h
//  MyWeibo
//
//  Created by zn on 2018/11/8.
//  Copyright © 2018年 zn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class postItem;

@interface TableCellTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIButton *repostBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UILabel *postLabel;

@property (nonatomic,strong) postItem *singlePostItem;
@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, strong) NSArray *reposts;
@property (nonatomic, strong) NSArray *likes;


+ (CGFloat)getLabelHeightWithText: (NSString *)text Width:(CGFloat)width Font:(UIFont *)font;
@end
