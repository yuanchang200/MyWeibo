//
//  DetailedPostTableViewCell.m
//  MyWeibo
//
//  Created by zn on 2018/11/14.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "DetailedPostTableViewCell.h"
#import "postItem.h"
#define UI_SCREEN_WIDTH 300

@implementation DetailedPostTableViewCell

NSInteger column_1 = 0;
NSInteger row_1 = 0;
CGFloat imageWidth_1;
CGFloat leadingSpace_1 = 8;
CGFloat imageSpace_1 = 4;
CGFloat originY_1;
CGFloat contentLabelOriginY_1 = 50;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _content.numberOfLines = 0;
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
    self.nickname.text = _singlePostItem.nickname;
    self.time.text = _singlePostItem.time;
    self.content.text = _singlePostItem.content;
    
    CGFloat contentHeight = [DetailedPostTableViewCell getLabelHeightWithText:self.content.text Width:UI_SCREEN_WIDTH - leadingSpace_1 * 2 Font:[UIFont systemFontOfSize:15]];
    [self.content setFrame:CGRectMake(7, 58, 305, contentHeight + 5)];
    
    if (_singlePostItem.postImgs.count == 1){
        column_1 = 1;
        imageWidth_1 = UI_SCREEN_WIDTH;
    }else if (_singlePostItem.postImgs.count == 2 || _singlePostItem.postImgs.count == 4){
        column_1 = 2;
        imageWidth_1 = (UI_SCREEN_WIDTH - (leadingSpace_1 + imageSpace_1) * 2) / 2;
    }else {
        column_1 = 3;
        imageWidth_1 = (UI_SCREEN_WIDTH - (leadingSpace_1 + imageSpace_1) * 2) / 3;
    }
    
    originY_1 = contentLabelOriginY_1 + contentHeight + leadingSpace_1;
    
    if(column_1 != 0){
        if(_singlePostItem.postImgs.count % column_1 == 0){
            row_1 = _singlePostItem.postImgs.count / column_1;
        }else{
            row_1 = _singlePostItem.postImgs.count / column_1 + 1;
        }
    }
    
    for (int i = 0; i < row_1; i++) {
        for (int j = 0; j < column_1; j++){
            if (i * column_1 + j < _singlePostItem.postImgs.count) {
                NSString *imageName = _singlePostItem.postImgs[i * column_1 + j];
                UIImage *image = [UIImage imageNamed:imageName];
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(leadingSpace_1 + j * (imageSpace_1 + imageWidth_1), originY_1 + leadingSpace_1 + i * (imageSpace_1 + imageWidth_1), imageWidth_1, imageWidth_1)];
                [imageView setImage:image];
                [self addSubview:imageView];
            }
        }
    }
}

@end
