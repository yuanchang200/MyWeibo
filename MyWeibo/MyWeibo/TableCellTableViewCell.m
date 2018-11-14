//
//  TableCellTableViewCell.m
//  MyWeibo
//
//  Created by zn on 2018/11/8.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "TableCellTableViewCell.h"
#import "postItem.h"
#define UI_SCREEN_WIDTH 300
@implementation TableCellTableViewCell

NSInteger column = 0;
NSInteger row = 0;
CGFloat imageWidth;
CGFloat leadingSpace = 8;
CGFloat imageSpace = 4;
CGFloat originY;
CGFloat contentLabelOriginY = 50;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _postLabel.numberOfLines = 0;//正文多行
    
    //圆形头像
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

- (void)setSinglePostItem:(postItem *)singlePostItem{
    
    _singlePostItem = singlePostItem;
    self.headImage.image = [UIImage imageNamed:_singlePostItem.headImg];
    self.titleLabel.text = _singlePostItem.nickname;
    self.timeLabel.text = _singlePostItem.time;
    self.postLabel.text = _singlePostItem.content;
    
    CGFloat contentHeight = [TableCellTableViewCell getLabelHeightWithText:self.postLabel.text Width:UI_SCREEN_WIDTH - leadingSpace * 2 Font:[UIFont systemFontOfSize:15]];
    [self.postLabel setFrame:CGRectMake(7, 58, 305, contentHeight + 5)];
    [self.repostBtn setTitle:_singlePostItem.repostNum forState:UIControlStateNormal];
    [self.commentBtn setTitle:_singlePostItem.commentNum forState:UIControlStateNormal];
    [self.likeBtn setTitle:_singlePostItem.likeNum forState:UIControlStateNormal];
    
    if (_singlePostItem.postImgs.count == 1){
        column = 1;
        imageWidth = UI_SCREEN_WIDTH * 0.55;
    }else if (_singlePostItem.postImgs.count == 2 || _singlePostItem.postImgs.count == 4){
        column = 2;
        imageWidth = (UI_SCREEN_WIDTH - (leadingSpace + imageSpace) * 2) / 3;
    }else {
        column = 3;
        imageWidth = (UI_SCREEN_WIDTH - (leadingSpace + imageSpace) * 2) / 3;
    }
    
    originY = contentLabelOriginY + contentHeight + leadingSpace;
    
    if(column != 0){
        if(_singlePostItem.postImgs.count % column == 0){
            row = _singlePostItem.postImgs.count / column;
        }else{
            row = _singlePostItem.postImgs.count / column + 1;
        }
    }
    
    for (int i = 0; i < row; i++) {
        for (int j = 0; j < column; j++){
            if (i * column + j < _singlePostItem.postImgs.count) {
                NSString *imageName = _singlePostItem.postImgs[i * column + j];
                UIImage *image = [UIImage imageNamed:imageName];
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(leadingSpace + j * (imageSpace + imageWidth), originY + leadingSpace + i * (imageSpace + imageWidth), imageWidth, imageWidth)];
                [imageView setImage:image];
                [self addSubview:imageView];
            }
        }
    }
}

@end
