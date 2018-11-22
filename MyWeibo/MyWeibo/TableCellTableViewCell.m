//
//  TableCellTableViewCell.m
//  MyWeibo
//
//  Created by zn on 2018/11/8.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "TableCellTableViewCell.h"
#import "postItem.h"
#import "MyImageView.h"
#import "DetailedViewController.h"
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
    
    _repostBtn.tag = 11;
    [_repostBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_repostBtn addTarget:self action:@selector(btnClickedDown:) forControlEvents:UIControlEventTouchDown];
    [_repostBtn addTarget:self action:@selector(btnClickedUp:) forControlEvents:UIControlEventTouchUpInside];
    [_repostBtn addTarget:self action:@selector(btnClickedUp:) forControlEvents:UIControlEventTouchUpOutside];
    
    _commentBtn.tag = 12;
    [_commentBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_commentBtn addTarget:self action:@selector(btnClickedDown:) forControlEvents:UIControlEventTouchDown];
    [_commentBtn addTarget:self action:@selector(btnClickedUp:) forControlEvents:UIControlEventTouchUpInside];
    [_commentBtn addTarget:self action:@selector(btnClickedUp:) forControlEvents:UIControlEventTouchUpOutside];
    
    _likeBtn.tag = 13;
    [_likeBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_likeBtn addTarget:self action:@selector(btnClickedDown:) forControlEvents:UIControlEventTouchDown];
    [_likeBtn addTarget:self action:@selector(btnClickedUp:) forControlEvents:UIControlEventTouchUpInside];
    [_likeBtn addTarget:self action:@selector(btnClickedUp:) forControlEvents:UIControlEventTouchUpOutside];
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
    
    NSString *repostStr = [[NSString alloc] initWithFormat:@"Repost %@", _singlePostItem.repostNum];
    [self.repostBtn setTitle:repostStr forState:UIControlStateNormal];
    NSString *commentStr = [[NSString alloc] initWithFormat:@"Comments %@", _singlePostItem.commentNum];
    [self.commentBtn setTitle:commentStr forState:UIControlStateNormal];
    NSString *likeStr = [[NSString alloc] initWithFormat:@"Likes %@", _singlePostItem.likeNum];
    [self.likeBtn setTitle:likeStr forState:UIControlStateNormal];
    
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
                MyImageView *imageView = [[MyImageView alloc] initWithFrame:CGRectMake(leadingSpace + j * (imageSpace + imageWidth), originY + leadingSpace + i * (imageSpace + imageWidth), imageWidth, imageWidth)];
                
                imageView.i = i;
                imageView.j = j;
                imageView.row = row;
                imageView.column = column;
                imageView.count = _singlePostItem.postImgs.count;
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
    rectInWindowArray = [NSMutableArray array];
    
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    MyImageView *view = (MyImageView *)tap.view;
    
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    CGRect rectInWindow = [view convertRect:view.bounds toView:window];
    
    if(view.column == 1){
        imageWidth = UI_SCREEN_WIDTH * 0.55;
    }else{
        imageWidth = (UI_SCREEN_WIDTH - (leadingSpace + imageSpace) * 2) / 3;
    }
    
    for(int i = 0; i < view.row; i++){
        for(int j = 0; j < view.column; j++){
            if(i*view.column+j<view.count){
                CGRect tmpRect = CGRectMake(rectInWindow.origin.x+(j-view.j)*(imageSpace+imageWidth), rectInWindow.origin.y+(i-view.i)*(imageSpace+imageWidth), imageWidth, imageWidth);
                [rectInWindowArray addObject:NSStringFromCGRect(tmpRect)];
            }
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
    imageScrollView.contentOffset = CGPointMake(mainWidth*(view.i*view.column+view.j), 0);
    
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
    [tempImageView setFrame:CGRectMake(view.frame.origin.x-index*self.bounds.size.width, view.frame.origin.y, view.frame.size.width, view.frame.size.height)];
    [self.superview.superview.superview addSubview:tempImageView];
    CGRect rectInWindow = CGRectFromString(rectInWindowArray[index]);
    
    [UIView animateWithDuration:0.2f animations:^{
        tempImageView.frame = rectInWindow;
    } completion:^(BOOL finished){
        [tempImageView removeFromSuperview];
    }];
}

- (void)btnClicked:(UIButton*)sender{
    DetailedViewController *dViewController = [DetailedViewController alloc];
    dViewController.post = self.singlePostItem;
    dViewController.comments = self.comments;
    dViewController.reposts = self.reposts;
    dViewController.likes = self.likes;
    dViewController.tag = sender.tag;
    
    id object = [self nextResponder];
    while(![object isKindOfClass:[UIViewController class]]&&object!=nil){
        object = [object nextResponder];
    }
    UIViewController *superController = (UIViewController*)object;
    [superController.navigationController pushViewController:dViewController animated:YES];
}

- (void)btnClickedDown:(UIButton*)sender{
    if(sender.tag == 11){
        [_repostBtn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]];
    }else if(sender.tag == 12){
        [_commentBtn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]];
    }else if(sender.tag == 13){
        [_likeBtn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]];
    }
}

- (void)btnClickedUp:(UIButton*)sender{
    if(sender.tag == 11){
        [_repostBtn setBackgroundColor:[UIColor whiteColor]];
    }else if(sender.tag == 12){
        [_commentBtn setBackgroundColor:[UIColor whiteColor]];
    }else if(sender.tag == 13){
        [_likeBtn setBackgroundColor:[UIColor whiteColor]];
    }
}

@end
