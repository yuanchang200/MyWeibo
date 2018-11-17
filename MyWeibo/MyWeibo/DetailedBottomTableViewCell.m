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

@interface DetailedBottomTableViewCell()<UITableViewDelegate, UITableViewDataSource>
@end

@implementation DetailedBottomTableViewCell

@synthesize comments;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0,0,320,320);
        UITableView *bottomTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [bottomTableView registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID3"];
        bottomTableView.tag = 100;
        bottomTableView.delegate = self;
        bottomTableView.dataSource = self;
        [self addSubview:bottomTableView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    UITableView *bottomTableView = (UITableView *)[self viewWithTag:100];
    bottomTableView.frame = CGRectMake(0.2, 0.3, self.bounds.size.width-5, self.bounds.size.height-100);
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
    return self.comments.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentTableViewCell *commentCell = [tableView dequeueReusableCellWithIdentifier:@"cellID3"];
    
    if(commentCell == nil){
        commentCell = [[CommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID3"];
    }
    commentCell.singleCommentItem = self.comments[indexPath.row];
    
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

