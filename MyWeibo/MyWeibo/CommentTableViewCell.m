//
//  CommentTableViewCell.m
//  MyWeibo
//
//  Created by zn on 2018/11/14.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "commentItem.h"
#define UI_SCREEN_WIDTH 300
@implementation CommentTableViewCell

CGFloat leadingSpace_2 = 8;
CGFloat contentLabelOriginY_2 = 50;
CGFloat originY_2;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _comment.numberOfLines = 0;
    _headImage.layer.masksToBounds = YES;
    _headImage.layer.cornerRadius = 42/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)getLabelHeightWithText:(NSString *)text Width:(CGFloat)width Font:(UIFont *)font{
    CGSize size = CGSizeMake(width, MAXFLOAT);
    CGSize returnSize;
    
    NSDictionary *attribute = @{ NSFontAttributeName : font};
    returnSize = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    return returnSize.height;
}

- (void)setSingleCommentItem:(commentItem *)singleCommentItem{
    _singleCommentItem = singleCommentItem;
    self.headImage.image = [UIImage imageNamed:_singleCommentItem.icon];
    self.nickname.text = _singleCommentItem.nickname;
    self.comment.text = _singleCommentItem.content;
    self.time.text = _singleCommentItem.time;
    //self.trend.text = _singleCommentItem.likeNum;
    self.trend.text = [[NSString alloc] initWithFormat:@"Likes: %@",_singleCommentItem.likeNum];
    
    CGFloat contentHeight = [CommentTableViewCell getLabelHeightWithText:self.comment.text Width:UI_SCREEN_WIDTH - leadingSpace_2 * 2 Font:[UIFont systemFontOfSize:14]];
    
    originY_2 = contentLabelOriginY_2 + contentHeight + leadingSpace_2;
    
    [self.comment setFrame:CGRectMake(60, 29, 252, contentHeight + 5)];
    [self.time setFrame:CGRectMake(60, originY_2, 191, 25)];
}

@end
