//
//  DetailedBottomTableViewCell.m
//  MyWeibo
//
//  Created by zn on 2018/11/16.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "DetailedBottomTableViewCell.h"
#import "CommentTableViewCell.h"
#import "commentItem.h"
#define UI_SCREEN_WIDTH 300

CGFloat leadingSpace_3 = 8;
CGFloat contentLabelOriginY_3 = 50;
CGFloat originY_3;
NSString *const commentCellIdentifier = @"cellID3";
NSString *const likeCellIdentifier = @"cellID4";

@interface DetailedBottomTableViewCell()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@end

@implementation DetailedBottomTableViewCell

@synthesize comments;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0,0,320,320);
        /*UITableView *bottomTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [bottomTableView registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:nil] forCellReuseIdentifier:commentCellIdentifier];
        bottomTableView.tag = 100;
        bottomTableView.delegate = self;
        bottomTableView.dataSource = self;
        [self addSubview:bottomTableView];*/
        CGFloat mainWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat mainHeight = [UIScreen mainScreen].bounds.size.height;
        _btn_repost = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, mainWidth/5*3/2, 30)];
        [_btn_repost setTitle:@"Repost" forState:UIControlStateNormal];
        [_btn_repost setTitleColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0] forState:UIControlStateNormal];
        _btn_repost.titleLabel.font = [UIFont systemFontOfSize:12];
    
        _btn_comment = [[UIButton alloc]initWithFrame:CGRectMake(mainWidth/5*3/2, 0, mainWidth/5*3/2, 30)];
        [_btn_comment setTitle:@"Comments" forState:UIControlStateNormal];
        [_btn_comment setTitleColor:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1.0] forState:UIControlStateNormal];
        _btn_comment.titleLabel.font = [UIFont systemFontOfSize:12];
        
        _btn_like = [[UIButton alloc]initWithFrame:CGRectMake(mainWidth/5*4, 0, mainWidth/5, 30)];
        [_btn_like setTitle:@"Likes" forState:UIControlStateNormal];
        [_btn_like setTitleColor:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1.0] forState:UIControlStateNormal];
        _btn_like.titleLabel.font = [UIFont systemFontOfSize:12];
        
        _imageLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 28, mainWidth/5*3/4, 3)];
        _imageLine.center = CGPointMake(mainWidth/5*3/4, 30.5);
        _imageLine.backgroundColor = [UIColor colorWithRed:255/255.0 green:124/255.0 blue:3/255.0 alpha:1.0];
        _imageLine.layer.masksToBounds = YES;
        _imageLine.layer.cornerRadius = 5/2;
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 37, mainWidth, mainHeight-37)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.contentSize = CGSizeMake(mainWidth*3, mainHeight-37);
        
        self.table_repost = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mainWidth, mainHeight-37) style:UITableViewStylePlain];
        self.table_comment = [[UITableView alloc]initWithFrame:CGRectMake(mainWidth, 0, mainWidth, mainHeight-37) style:UITableViewStylePlain];
        self.table_like = [[UITableView alloc]initWithFrame:CGRectMake(mainWidth*2, 0, mainWidth, mainHeight-37) style:UITableViewStylePlain];
        
        [self.table_repost registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:nil] forCellReuseIdentifier:commentCellIdentifier];
        self.table_repost.delegate = self;
        self.table_repost.dataSource = self;
        
        [self.table_comment registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:nil] forCellReuseIdentifier:commentCellIdentifier];
        self.table_comment.delegate = self;
        self.table_comment.dataSource = self;
        
        [_scrollView addSubview:self.table_repost];
        [_scrollView addSubview:self.table_comment];
        [_scrollView addSubview:self.table_like];
        [self addSubview:_btn_repost];
        [self addSubview:_btn_comment];
        [self addSubview:_btn_like];
        [self addSubview:_scrollView];
        [self addSubview:_imageLine];
        [_btn_repost setTag:199];
        [_btn_comment setTag:200];
        [_btn_like setTag:201];
        [self.table_repost setTag:202];
        [self.table_comment setTag:203];
        [self.table_like setTag:204];
        [_btn_repost addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_btn_comment addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_btn_like addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return self;
}

- (void)btnClicked:(UIButton*)sender{
    NSInteger tag = [sender tag];
    if(tag == 199){
        [UIView animateWithDuration:0.5f animations:^{
            _imageLine.center = CGPointMake(self.bounds.size.width/5*3/4, _imageLine.center.y);
            _scrollView.contentOffset = CGPointMake(0, 0);
        }];
        [_btn_repost setTitleColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_btn_comment setTitleColor:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_btn_comment setTitleColor:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1.0] forState:UIControlStateNormal];
    }
    else if(tag == 200){
        [UIView animateWithDuration:0.5f animations:^{
            _imageLine.center = CGPointMake(self.bounds.size.width/5*3/4*3, _imageLine.center.y);
            _scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
        }];
        [_btn_repost setTitleColor:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_btn_comment setTitleColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_btn_like setTitleColor:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1.0] forState:UIControlStateNormal];
    }
    else{
        [UIView animateWithDuration:0.5f animations:^{
            _imageLine.center = CGPointMake(self.bounds.size.width/10*9, _imageLine.center.y);
            _scrollView.contentOffset = CGPointMake(self.bounds.size.width*2, 0);
        }];
        [_btn_repost setTitleColor:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_btn_comment setTitleColor:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_btn_like setTitleColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0] forState:UIControlStateNormal];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _imageLine.center = CGPointMake(scrollView.contentOffset.x/3+self.bounds.size.width/5*3/4, _imageLine.center.y);
}

- (void)layoutSubviews{
    [super layoutSubviews];
    /*UITableView *bottomTableView = (UITableView *)[self viewWithTag:100];
    bottomTableView.frame = CGRectMake(0.2, 0.3, self.bounds.size.width-5, self.bounds.size.height-100);*/
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //[self.commentTableView registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID3"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger tag = tableView.tag;
    if(tag == 202){
        return self.reposts.count;
    }
    return self.comments.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger tag = tableView.tag;
    CommentTableViewCell *commentCell = [tableView dequeueReusableCellWithIdentifier:commentCellIdentifier];
    if(commentCell == nil){
        commentCell = [[CommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:commentCellIdentifier];
    }
    if(tag == 202){
        commentCell.singleCommentItem = self.reposts[indexPath.row];
    }
    else if(tag == 203){
        commentCell.singleCommentItem = self.comments[indexPath.row];
    }
    
    CGFloat contentHeight = [CommentTableViewCell getLabelHeightWithText:commentCell.singleCommentItem.content Width:UI_SCREEN_WIDTH - leadingSpace_3 * 2 Font:[UIFont systemFontOfSize:14]];
    
    originY_3 = contentLabelOriginY_3 + contentHeight + leadingSpace_3;
    CGRect rect = commentCell.frame;
    rect.size.height = originY_3;
    commentCell.frame = rect;
    
    return commentCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
@end

