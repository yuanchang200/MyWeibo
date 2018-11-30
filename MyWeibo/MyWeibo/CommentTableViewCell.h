//
//  CommentTableViewCell.h
//  MyWeibo
//
//  Created by zn on 2018/11/14.
//  Copyright © 2018年 zn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class commentItem;

@interface CommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *trend;

@property (nonatomic, strong) commentItem *singleCommentItem;

+ (CGFloat)getLabelHeightWithText: (NSString *)text Width:(CGFloat)width Font:(UIFont *)font;

@end
