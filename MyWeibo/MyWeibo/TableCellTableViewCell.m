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

@interface TableCellTableViewCell()<UIScrollViewDelegate>
@end

@implementation TableCellTableViewCell{
    UIScrollView *background;
}

NSInteger column = 0;
NSInteger row = 0;
CGFloat imageWidth;
CGFloat leadingSpace = 8;
CGFloat imageSpace = 4;
CGFloat originY;
CGFloat contentLabelOriginY = 50;
NSMutableArray *rectInWindowArray;


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
                
                imageView.tag = i*column+j;
                imageView.userInteractionEnabled = YES;
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
                [imageView addGestureRecognizer:tapGesture];
                
                [imageView setImage:image];
                [self addSubview:imageView];
            }
        }
    }
}

- (void)tapAction:(id)sender{
    int i_tap = 0, j_tap = 0;
    rectInWindowArray = [NSMutableArray array];
    
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    UIImageView *view = (UIImageView *)tap.view;
    NSInteger index = view.tag;
    
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    CGRect rectInWindow = [view convertRect:view.bounds toView:window];
    
    if(column == 1){
        imageWidth = UI_SCREEN_WIDTH * 0.55;
    }else{
        imageWidth = (UI_SCREEN_WIDTH - (leadingSpace + imageSpace) * 2) / 3;
    }
    
    for(int i = 0; i < row; i++){
        for(int j = 0; j < column; j++){
            if(i*column+j == index){
                i_tap = i;
                j_tap = j;
            }
        }
    }
    
    for(int i = 0; i < row; i++){
        for(int j = 0; j < column; j++){
            CGRect tmpRect = CGRectMake(rectInWindow.origin.x+(j-j_tap)*(imageSpace+imageWidth), rectInWindow.origin.y+(i-i_tap)*(imageSpace+imageWidth), imageWidth, imageWidth);
            [rectInWindowArray addObject:NSStringFromCGRect(tmpRect)];
        }
    }
    
    
    CGFloat mainWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat mainHeight = [UIScreen mainScreen].bounds.size.height;
    UIScrollView *imageScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, mainWidth, mainHeight)];
    background = imageScrollView;
    imageScrollView.delegate = self;
    imageScrollView.pagingEnabled = YES;
    imageScrollView.showsHorizontalScrollIndicator = NO;
    imageScrollView.bounces = YES;
    imageScrollView.contentSize = CGSizeMake(mainWidth*_singlePostItem.postImgs.count, mainHeight);
    [imageScrollView setBackgroundColor:[UIColor blackColor]];
    //[self.superview.superview.superview addSubview:imageScrollView];
    
    for (int i=0;i<_singlePostItem.postImgs.count;i++){
        UIImageView *largeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(mainWidth*i+leadingSpace, 100, mainWidth-leadingSpace*2, 360)];
        [largeImageView setImage:[UIImage imageNamed:_singlePostItem.postImgs[i]]];
        [imageScrollView addSubview:largeImageView];
        largeImageView.userInteractionEnabled = YES;
        largeImageView.tag = i;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeView:)];
        [largeImageView addGestureRecognizer:tapGesture];
    }
    imageScrollView.contentOffset = CGPointMake(mainWidth*index, 0);
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:view.image];
    tempImageView.frame = rectInWindow;
    [self.superview.superview.superview addSubview:tempImageView];
    
    [UIView animateWithDuration:0.2f animations:^{
        tempImageView.frame = CGRectMake(leadingSpace, 100, mainWidth-leadingSpace*2, 360);
    } completion:^(BOOL finished){
        [tempImageView removeFromSuperview];
        [self.superview.superview.superview addSubview:imageScrollView];
    }];
}

- (void)closeView:(id)sender{
    [background removeFromSuperview];
    
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    UIImageView *view = (UIImageView *)tap.view;
    NSInteger index = view.tag;
    
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:view.image];
    tempImageView.frame = view.frame;
    [self.superview.superview.superview addSubview:tempImageView];
    CGRect rectInWindow = CGRectFromString(rectInWindowArray[index]);
    
    [UIView animateWithDuration:0.2f animations:^{
        tempImageView.frame = rectInWindow;
    } completion:^(BOOL finished){
        [tempImageView removeFromSuperview];
    }];
}

@end
