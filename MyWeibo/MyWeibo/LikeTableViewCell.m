//
//  LikeTableViewCell.m
//  MyWeibo
//
//  Created by zn on 2018/11/17.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "LikeTableViewCell.h"
#import "likeItem.h"

@implementation LikeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _headImg.layer.masksToBounds = YES;
    _headImg.layer.cornerRadius = 42/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSingleLikeItem:(likeItem *)singleLikeItem{
    _singleLikeItem = singleLikeItem;
    self.headImg.image = [UIImage imageNamed:_singleLikeItem.icon];
    self.nickname.text = _singleLikeItem.nickname;
    self.bio.text = _singleLikeItem.bio;
}

@end
