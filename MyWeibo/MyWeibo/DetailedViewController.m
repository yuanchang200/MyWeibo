//
//  DetailedViewController.m
//  MyWeibo
//
//  Created by zn on 2018/11/20.
//  Copyright © 2018年 zn. All rights reserved.
//

#import "DetailedViewController.h"
#import "CommentTableViewCell.h"
#import "TableCellTableViewCell.h"
#import "LikeTableViewCell.h"
#import "commentItem.h"

#define UI_SCREEN_WIDTH 300

NSInteger column_d = 0;
NSInteger row_d = 0;
CGFloat imageWidth_d;
CGFloat leadingSpace_d = 8;
CGFloat imageSpace_d = 4;
CGFloat originY_d;
CGFloat contentLabelOriginY_d = 50;

NSString *const commentCellIdentifier = @"cellID3";
NSString *const likeCellIdentifier = @"cellID4";
NSString *const zero = @"0";

@interface DetailedViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@end

@implementation DetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor: [UIColor whiteColor]];
    
    CGFloat mainWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat mainHeight = [UIScreen mainScreen].bounds.size.height;
    
    _outerScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, mainWidth, mainHeight-37)];
    _outerScrollView.delegate = self;
    _outerScrollView.pagingEnabled = NO;
    _outerScrollView.showsVerticalScrollIndicator = NO;
    _outerScrollView.bounces = NO;
    _outerScrollView.contentSize = CGSizeMake(mainWidth, (mainHeight-37)*2);
    _outerScrollView.tag = 1;
    [_outerScrollView setBackgroundColor: [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]];
    
    _detailPostView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainWidth, mainHeight)];
    [_detailPostView setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 42, 42)];
    [icon setImage: [UIImage imageNamed:self.post.headImg]];
    icon.layer.masksToBounds = YES;
    icon.layer.cornerRadius = 42/2;
    UILabel *nickname = [[UILabel alloc] initWithFrame:CGRectMake(60, 8, 206, 26)];
    [nickname setText: self.post.nickname];
    nickname.font = [UIFont systemFontOfSize:15];
    UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(60, 29, 191, 25)];
    [time setText:self.post.time];
    time.font = [UIFont systemFontOfSize:12];
    [time setTextColor: [UIColor colorWithRed:150/250.0 green:150/250.0 blue:150/250.0 alpha:1.0]];
    UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(7, 58, 305, 18)];
    [content setText: self.post.content];
    content.font = [UIFont systemFontOfSize:15];
    content.numberOfLines = 0;
    
    CGFloat contentHeight = [TableCellTableViewCell getLabelHeightWithText:content.text Width:UI_SCREEN_WIDTH - leadingSpace_d * 2 Font:[UIFont systemFontOfSize:15]];
    [content setFrame:CGRectMake(7, 58, 305, contentHeight + 5)];
    
    if (self.post.postImgs.count == 1){
        column_d = 1;
        imageWidth_d = UI_SCREEN_WIDTH;
    }else if (self.post.postImgs.count == 2 || self.post.postImgs.count == 4){
        column_d = 2;
        imageWidth_d = (UI_SCREEN_WIDTH - (leadingSpace_d + imageSpace_d) * 2) / 2;
    }else {
        column_d = 3;
        imageWidth_d = (UI_SCREEN_WIDTH - (leadingSpace_d + imageSpace_d) * 2) / 3;
    }
    
    originY_d = contentLabelOriginY_d + contentHeight + leadingSpace_d;
    
    if(column_d != 0){
        if(self.post.postImgs.count % column_d == 0){
            row_d = self.post.postImgs.count / column_d;
        }else{
            row_d = self.post.postImgs.count / column_d + 1;
        }
    }
    
    
    [_detailPostView setFrame: CGRectMake(0, 0, mainWidth, originY_d + row_d * (imageWidth_d + imageSpace_d) + leadingSpace_d + 5)];
    
    [self.view addSubview: _outerScrollView];
    [_outerScrollView addSubview: _detailPostView];
    [_detailPostView addSubview: icon];
    [_detailPostView addSubview: nickname];
    [_detailPostView addSubview: time];
    [_detailPostView addSubview: content];
    
    for (int i = 0; i < row_d; i++) {
        for (int j = 0; j < column_d; j++){
            if (i * column_d + j < self.post.postImgs.count) {
                NSString *imageName = self.post.postImgs[i * column_d + j];
                UIImage *image = [UIImage imageNamed:imageName];
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(leadingSpace_d + j * (imageSpace_d + imageWidth_d), originY_d + leadingSpace_d + i * (imageSpace_d + imageWidth_d), imageWidth_d, imageWidth_d)];
                [imageView setImage:image];
                [_detailPostView addSubview:imageView];
            }
        }
    }
    
    //-----------Bottom----------------
    
    _detailCommentView = [[UIView alloc] initWithFrame:CGRectMake(0, _detailPostView.frame.size.height+10, mainWidth, 350)];
    [_detailCommentView setBackgroundColor: [UIColor whiteColor]];
    
    _outerScrollView.contentSize = CGSizeMake(mainWidth, _detailCommentView.frame.origin.y+_detailCommentView.frame.size.height+100);
    
    _bottomScrollView = [[UIScrollView alloc ] initWithFrame:CGRectMake(0, 37, mainWidth, 300)];
    _bottomScrollView.delegate = self;
    _bottomScrollView.pagingEnabled = YES;
    _bottomScrollView.showsHorizontalScrollIndicator = NO;
    _bottomScrollView.bounces = NO;
    _bottomScrollView.contentSize = CGSizeMake(mainWidth*3, mainHeight-37);
    _bottomScrollView.tag = 2;
    [_bottomScrollView setBackgroundColor: [UIColor whiteColor]];
    
    _view_repost = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainWidth, 300)];
    _label_comment = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 200, 20)];
    [_label_comment setText:@"Come to share great content"];
    _label_comment.font = [UIFont systemFontOfSize:12];
    
    _view_comment = [[UIView alloc]initWithFrame:CGRectMake(mainWidth, 0, mainWidth, 300)];
    
    _view_like = [[UIView alloc]initWithFrame:CGRectMake(mainWidth*2, 0, mainWidth, 300)];
    
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
    
    self.table_repost = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mainWidth, 300) style:UITableViewStylePlain];
    self.table_comment = [[UITableView alloc]initWithFrame:CGRectMake(mainWidth, 0, mainWidth, 300) style:UITableViewStylePlain];
    self.table_like = [[UITableView alloc]initWithFrame:CGRectMake(mainWidth*2, 0, mainWidth, 300) style:UITableViewStylePlain];
    
    [self.table_repost registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:nil] forCellReuseIdentifier:commentCellIdentifier];
    self.table_repost.delegate = self;
    self.table_repost.dataSource = self;
    
    [self.table_comment registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:nil] forCellReuseIdentifier:commentCellIdentifier];
    self.table_comment.delegate = self;
    self.table_comment.dataSource = self;
    
    [self.table_like registerNib:[UINib nibWithNibName:@"LikeTableViewCell" bundle:nil] forCellReuseIdentifier:likeCellIdentifier];
    self.table_like.delegate = self;
    self.table_like.dataSource = self;
    
    [_view_comment addSubview:_label_comment];
    [_view_repost addSubview:_label_comment];
    [_view_like addSubview:_label_comment];
    
    if(self.reposts.count == 0){
        [_bottomScrollView addSubview:_view_repost];
    }else{
        [_bottomScrollView addSubview:self.table_repost];
    }
    
    if(self.comments.count == 0){
        [_bottomScrollView addSubview:_view_comment];
    }else{
        [_bottomScrollView addSubview:self.table_comment];
    }
    
    if(self.likes.count == 0){
        [_bottomScrollView addSubview:_view_like];
    }else{
        [_bottomScrollView addSubview:self.table_like];
    }
    
    [_outerScrollView addSubview: _detailCommentView];
    [_detailCommentView addSubview:_btn_repost];
    [_detailCommentView addSubview:_btn_comment];
    [_detailCommentView addSubview:_btn_like];
    [_detailCommentView addSubview:_bottomScrollView];
    [_detailCommentView addSubview:_imageLine];
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

- (void)btnClicked:(UIButton*)sender{
    NSInteger tag = [sender tag];
    if(tag == 199){
        [UIView animateWithDuration:0.2f animations:^{
            _imageLine.center = CGPointMake(_btn_repost.center.x, _imageLine.center.y);
            _bottomScrollView.contentOffset = CGPointMake(0, 0);
        }];
        [_btn_repost setTitleColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_btn_comment setTitleColor:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_btn_like setTitleColor:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1.0] forState:UIControlStateNormal];
    }
    else if(tag == 200){
        [UIView animateWithDuration:0.2f animations:^{
            _imageLine.center = CGPointMake(_btn_comment.center.x, _imageLine.center.y);
            _bottomScrollView.contentOffset = CGPointMake(self.view.bounds.size.width, 0);
        }];
        [_btn_repost setTitleColor:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_btn_comment setTitleColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_btn_like setTitleColor:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1.0] forState:UIControlStateNormal];
    }
    else{
        [UIView animateWithDuration:0.2f animations:^{
            _imageLine.center = CGPointMake(_btn_like.center.x, _imageLine.center.y);
            _bottomScrollView.contentOffset = CGPointMake(self.view.bounds.size.width*2, 0);
        }];
        [_btn_repost setTitleColor:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_btn_comment setTitleColor:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_btn_like setTitleColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0] forState:UIControlStateNormal];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView.tag == 2){
        if(scrollView.contentOffset.x <= self.view.bounds.size.width){
            _imageLine.center = CGPointMake(scrollView.contentOffset.x/self.view.bounds.size.width*(_btn_comment.center.x-_btn_repost.center.x)+_btn_repost.center.x, _imageLine.center.y);
        }
        else if(scrollView.contentOffset.x <= self.view.bounds.size.width*2){
            _imageLine.center = CGPointMake(scrollView.contentOffset.x/self.view.bounds.size.width*(_btn_like.center.x-_btn_comment.center.x), _imageLine.center.y);
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if(scrollView.tag == 2){
        if(scrollView.contentOffset.x == 0){
            _imageLine.center = CGPointMake(_btn_repost.center.x, _imageLine.center.y);
            [_btn_repost setTitleColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0] forState:UIControlStateNormal];
            [_btn_comment setTitleColor:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1.0] forState:UIControlStateNormal];
            [_btn_like setTitleColor:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1.0] forState:UIControlStateNormal];
        }else if(scrollView.contentOffset.x == self.view.bounds.size.width){
            _imageLine.center = CGPointMake(_btn_comment.center.x, _imageLine.center.y);
            [_btn_repost setTitleColor:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1.0] forState:UIControlStateNormal];
            [_btn_comment setTitleColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0] forState:UIControlStateNormal];
            [_btn_like setTitleColor:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1.0] forState:UIControlStateNormal];
        }else if(scrollView.contentOffset.x == self.view.bounds.size.width*2){
            _imageLine.center = CGPointMake(_btn_like.center.x, _imageLine.center.y);
            [_btn_repost setTitleColor:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1.0] forState:UIControlStateNormal];
            [_btn_comment setTitleColor:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1.0] forState:UIControlStateNormal];
            [_btn_like setTitleColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0] forState:UIControlStateNormal];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(scrollView.tag == 2){
        if(!decelerate){
            if(scrollView.contentOffset.x == 0){
                _imageLine.center = CGPointMake(_btn_repost.center.x, _imageLine.center.y);
                [_btn_repost setTitleColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0] forState:UIControlStateNormal];
                [_btn_comment setTitleColor:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1.0] forState:UIControlStateNormal];
                [_btn_like setTitleColor:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1.0] forState:UIControlStateNormal];
            }else if(scrollView.contentOffset.x == self.view.bounds.size.width){
                _imageLine.center = CGPointMake(_btn_comment.center.x, _imageLine.center.y);
                [_btn_repost setTitleColor:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1.0] forState:UIControlStateNormal];
                [_btn_comment setTitleColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0] forState:UIControlStateNormal];
                [_btn_like setTitleColor:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1.0] forState:UIControlStateNormal];
            }else if(scrollView.contentOffset.x == self.view.bounds.size.width*2){
                _imageLine.center = CGPointMake(_btn_like.center.x, _imageLine.center.y);
                [_btn_repost setTitleColor:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1.0] forState:UIControlStateNormal];
                [_btn_comment setTitleColor:[UIColor colorWithRed:144/255.0 green:144/255.0 blue:144/255.0 alpha:1.0] forState:UIControlStateNormal];
                [_btn_like setTitleColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0] forState:UIControlStateNormal];
            }
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger tag = tableView.tag;
    if(tag == 202){
        return self.reposts.count;
    }
    else if(tag == 203){
        return self.comments.count;
    }
    return self.likes.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger tag = tableView.tag;
    
    if(tag == 204){
        LikeTableViewCell *likeCell = [tableView dequeueReusableCellWithIdentifier:likeCellIdentifier];
        if(likeCell == nil){
            likeCell = [[LikeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:likeCellIdentifier];
        }
        likeCell.singleLikeItem = self.likes[indexPath.row];
        return likeCell;
    }
    
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
    
    CGFloat contentHeight = [CommentTableViewCell getLabelHeightWithText:commentCell.singleCommentItem.content Width:UI_SCREEN_WIDTH - leadingSpace_d * 2 Font:[UIFont systemFontOfSize:14]];
    
    originY_d = contentLabelOriginY_d + contentHeight + leadingSpace_d;
    CGRect rect = commentCell.frame;
    rect.size.height = originY_d;
    commentCell.frame = rect;
    
    return commentCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
